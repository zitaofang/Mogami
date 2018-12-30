`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/18 10:29:56
// Design Name: 
// Module Name: imm_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_gen(
    input [31:0] inst,
    input [2:0] control,
    output [63:0] out
    );
    
    wire [31:0] imm_out[0:4];
    
    assign imm_out[0] = {{52{inst[31]}}, inst[31:20]}; // I Type
    assign imm_out[1] = {{52{inst[31]}}, inst[31:25], inst[11:7]}; // S Type
    assign imm_out[2] = {{51{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0}; // SB Type
    assign imm_out[4] = {inst[31:12], 12'b0}; // U Type
    assign imm_out[5] = {{43{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0}; // UJ Type
    
    assign out = imm_out[control];
endmodule

// experiment
module encoder_experiment(
    input [63:0] exp,
    input [63:0] man,
    
    // Setting
    input [2:0] rm,
    input is_double,
    
    output [63:0] out
);

    // Check if it is a denorms.
    wire is_denorm = exp[12];
    
    // calculate the shifting offset
    // By default, all shift to the right by 11 for double and 40 for single to align with the rounding bit
    // If a denorm presents (exp_biased <= 0), shift ~exp + 2 (+1 for 2's complement negation and +1 for 
    // the property of denorms). We will shift the constant part in this module, and leave the ~exp to the shifter.
    // If the result underflow, the high 7 bit in the result will not be 0 since the result >= 64.
    // To construct 11 and 13 fast, we use some bit hacking
    // s    : 0010 1000
    // s + d: 0010 1010
    // d    : 0000 1011
    // d + d: 0000 1101
    wire [12:0] offset_base = {7'b0, ~is_double, 2'b01, is_double & is_denorm, is_double ^ is_denorm, is_double};
    wire [12:0] exp_out;
    fp_exp_adder(
        .cin(1'b0),
        .exp1(offset_base),
        .exp2({13{is_denorm}} & ~exp[12:0]),
        .exp_r(exp_out),
        .overflow()
    );
    // Check if higher 7 bits has 1
    wire exp_underflow = |exp_out[12:6];
    
    // Process special value flag
    wire [1:0] special_value;
    // There are three levels of flags that can change the special value flag:
    // High: the overflow and underflow flag marked in calculation (exp[60:59])
    // Medium: the mantissa is 0
    // Low: denorm underflow detected in exponent adder, overflow by exp = 111..111 or 1 in higher 3 bit (for single)
    // Events with higher priority overwrites those with lower priority.
    // Note that this event will only change the flag if the flag is 00 (normal value).
    wire man_nonzero = |man;
    wire exp_all_one = &{~exp[12], exp[11:0]};
    wire single_overflow = |exp[11:9] & ~is_double;
    wire high_flag = exp[60] | exp[59];
    wire medium_flag = ~(high_flag | man_nonzero);
    
    wire to_inf = high_flag ? exp[60] : (~medium_flag & exp_all_one | single_overflow);
    wire to_zero = high_flag ? exp[59] : (medium_flag ? ~man_nonzero : exp_underflow);
    
    assign special_value[1] = to_inf & ~exp[61] | exp[62];
    assign special_value[0] = to_zero & ~exp[62] | exp[61];
    
    // send it to the shifter 
    wire [63:0] shifter_out;
    wire sticky, guard;
    shifter (
        .shift(exp_out[5:0]),
        .sl(1'b0),
        .extend_bit(1'b0),
        .in(man),
        .out(shifter_out),
        
        // FP Extension
        .sticky_all(), // Treat guard and round as a part of the sticky bit generation
        .sticky(sticky),
        .guard(guard),
        .round()
    );
    
    // Generate out + 1 for rounding up
    wire [63:0] round_up;
    constant_1bit_adder (
        .a(shifter_out),
        .carry_out(),
        .sign_carry_in(),
        .r(round_up)
    );
    wire roundup_shift = is_double ? round_up[53] : round_up[24];
    
    // Select rounding bit
    wire round_sel;
    rounding_sel(
        .guard(guard),
        .sticky(sticky),
        .rounding_mode(rm),
        .sign(exp[63]),
        .last_bit(shifter_out[0]),
        .rounding_sel(round_sel),
        .nv()
    );
    
    wire [63:0] double_out;
    wire [63:0] single_out;
    assign single_out[63:32] = 32'b0;
    
    // Decide mantissa output
    // If we have inf or zero, wipe all bit out
    // If we have NaN, wipe out all bit but set MSB to 1 (see RISC-V specs, section 8.3)
    // Otherwise, select the rounding bit.
    // If there is a carry-out when rounding up, ignore it since we don't have to actually
    // shift a 0
    wire [63:0] sv_man_int;
    assign sv_man_int[51] = &{special_value, is_double};
    assign sv_man_int[22] = &{special_value, ~is_double};
    assign sv_man_int[63:52] = 12'b0;
    assign sv_man_int[50:23] = 27'b0;
    assign sv_man_int[21:0] = 22'b0;
    wire [63:0] round_man_int = round_sel ? round_up : man;
    assign double_out[51:0] = |special_value ? sv_man_int[51:0] : round_man_int[51:0];
    assign single_out[22:0] = |special_value ? sv_man_int[22:0] : round_man_int[22:0];
    
    // Exponent + 1 when roundup produce a shift
    // We don't care about overflow since it will only happened when exp[12:0] is all 1,
    // in which case the output exponent will be overwritten by special value handler
    wire [12:0] shift_exp;
    constant_1bit_adder #(SIZE(13)) (
        .a(exp[12:0]),
        .carry_out(),
        .sign_carry_in(),
        .r(shift_exp)
    );
    
    // Encode exponent bit
    // Generally, just output exp[12:0].
    // If it is a denorm/zero, pull to 0.
    // If it is a inf/NaN, pull to 1.
    // If the mantissa rounding result in a carry-out, also add 1 to exp. No additional action
    // is needed if this bring it to 1111...11 since the mantissa is already all 0.
    wire [12:0] sv_exp_int = {13{special_value[1]}};
    wire [12:0] round_exp_int = (roundup_shift & round_sel) ? shift_exp : exp[12:0];
    assign double_out[62:52] = |{special_value, is_denorm} ? sv_exp_int : round_exp_int;
    assign single_out[30:23] = |{special_value, is_denorm} ? sv_exp_int[7:0] : round_exp_int[7:0];
    
    // sign
    assign double_out[63] = exp[63];
    assign single_out[31] = exp[63];
    
    assign out = is_double ? double_out : single_out;
endmodule

// Currently, to 64b, signed
module converter_experiment(
    input [63:0] exp,
    input [63:0] man,
    
    // setting
    input [1:0] rm,
    input to_64b,
    input to_signed,
    
    output [63:0] out
);
    // Determine the shifting offset: 64 - exponent.
    // If negative or 0, it overflows.
    // 64 in biased form is 1087.
    // d + 64: 0 0100 0011 1111
    // d + 32: 0 0100 0001 1111
    wire [12:0] offset_base;
    assign offset_base[12:6] = 7'b0010000;
    assign offset_base[5] = to_64b;
    assign offset_base[4:0] = 5'b11111;
    
    // The result from decoder will never make adder overflow
    wire [12:0] exp_out;
    fp_exp_adder(
        .cin(1'b1),
        .exp1(offset_base),
        .exp2(~exp[12:0]),
        .exp_r(exp_out),
        .overflow()
    );
    
    // Check overflow. For signed number, 0 is oveflow, but it isn't for unsigned number. 
    // Since we are only dealing with the number direcctly from the decoder, it is guaranteed
    // that a positive result will never > 128, so we just need to check the first 7 bits
    wire neqz = |exp_out[6:0] & to_signed; // If converting to unsigned, it is not an overflow
    wire exp_overflow = exp_out[12];
    
    // Send to the shifter
    // We pull exp_out[5] to 1 if we are converting to 32b
    wire [63:0] shifter_out;
    wire sticky, guard;
    shifter (
        .shift({exp_out[5] | ~to_64b, exp_out[4:0]}),
        .sl(1'b0),
        .extend_bit(1'b0),
        .in(man),
        .out(shifter_out),
        
        // FP Extension
        .sticky_all(), // Treat guard and round as a part of the sticky bit generation
        .sticky(sticky),
        .guard(guard),
        .round()
    );
    
    // Generate out + 1 for rounding up
    // If we get a carry-out, overflow occurred
    wire [63:0] round_up;
    wire round_overflow;
    constant_1bit_adder (
        .a(shifter_out),
        .carry_out(round_overflow),
        .sign_carry_in(),
        .r(round_up)
    );
    
    // Select rounding bit
    wire round_sel;
    rounding_sel(
        .guard(guard),
        .sticky(sticky),
        .rounding_mode(rm),
        .sign(exp[63]),
        .last_bit(shifter_out[0]),
        .rounding_sel(round_sel),
        .nv()
    );
    
    // Deal with special value
    // Pull to 011111..11 when overflow / inf, then xor it with sign bit.
    // For NaNs, treat it like a +inf, so we need to turn the sign positive.
    // We also need to turn the sign for 0 back to avoid flipping bit.
    // For unsigned, if overflow, pull to 111...111; if negative, pull to 0
    wire sign = exp[63] & ~exp[61];
    wire pull = exp[62] | exp_overflow | neqz | (round_overflow & round_sel) | (sign & ~to_signed);
    wire [63:0] pull_value;
    assign pull_value[63] = ~to_signed;
    assign pull_value[62:0] = 63'h7fff_ffff_ffff_ffff;
    
    // Produce unsigned version output
    wire [63:0] unsigned_output = pull ? 64'h7fff_ffff_ffff_ffff : (round_sel ? round_up : shifter_out);
    assign out = unsigned_output ^ {64{sign | (~to_signed & pull)}};
endmodule


module add_shifter_expriment(
    input [63:0] exp1,
    input [63:0] man1,
    input [63:0] exp2,
    input [63:0] man2,
    
    // setting
    
    output [63:0] out
);
    // Add two exp (with one negated)
    wire [12:0] exp_out;
    wire adder_overflow;
    fp_exp_adder(
        .cin(1'b1),
        .exp1(exp1[12:0]),
        .exp2(~exp2[12:0]),
        .exp_r(exp_out),
        .overflow(adder_overflow)
    );
    
    // Detect overflow: overflow or higher 7 bit has bit set
    wire exp_overflow = |{adder_overflow, exp_out[12:6]};
    
    
endmodule