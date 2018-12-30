`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zitao Fang
// 
// Create Date: 2018/06/18 15:38:45
// Design Name: Floating Point Exponent-based Shifter
// Module Name: FP_diff_shifter
// Project Name: Mogami
// Target Devices: 
// Tool Versions: 
// Description: 
// A component for shifting operand before fp addition, decoding fp and converting fp to integer.
// This component will be divided into two parts after the design is finished.
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// If there is not enough time for an shifter to do its job, split it into two parts.
// Use a pure shifter for the next part. 
// Also, this module doesn't distinguish addition and subtraction, so it is necessary for 
// the operand readers to flip the sign bit of exp_b if it is a fsub inst.
// This module treat exponents as 2's complement. (No bias) TODO: check this
//////////////////////////////////////////////////////////////////////////////////


module exp_adder(
    input [5:0] exp1,
    input [5:0] exp2,
    output [5:0] exp_r,
    output overflow
);
    wire [6:0] exp_shift_c;
    wire [5:0] exp_p = exp1[5:0] | ~exp2[5:0];
    wire [5:0] exp_g = exp1[5:0] & ~exp2[5:0];
    // Use canonic adder to minimize the delay
    assign exp_shift_c[0] = 1'b1;
    assign exp_shift_c[1] = exp_g[0] | exp_p[0];
    assign exp_shift_c[2] = exp_g[1] | (exp_p[1] & exp_g[0]) | (exp_p[1] & exp_p[0]);
    assign exp_shift_c[3] = exp_g[2] | (exp_p[2] & exp_g[1]) | (exp_p[2] & exp_p[1] & exp_g[0]) | (exp_p[2] & exp_p[1] & exp_p[0]);
    // ++++++++ Three gates ++++++++
    // Some variables for optimization
    wire exp_i[0:2]; // "i" means "intermediate"
    assign exp_i[0] = (exp_p[3] & exp_p[2] & exp_p[1] & exp_p[0]);
    assign exp_i[1] = (exp_p[3] & exp_p[2] & exp_p[1] & exp_g[0]);
    assign exp_shift_c[4] = exp_g[3] | (exp_p[3] & exp_g[2]) | (exp_p[3] & exp_p[2] & exp_g[1]) | exp_i[1]
        | exp_i[0];
    // ++++++++ Four gates +++++++++
    assign exp_i[2] = (exp_p[4] & exp_p[3] & exp_p[2] & exp_g[1]);
    assign exp_shift_c[5] = exp_g[4] | (exp_p[4] & exp_g[3]) | (exp_p[4] & exp_p[3] & exp_g[2]) | exp_i[2]
        | (exp_p[4] & exp_i[1]) | (exp_p[4] & exp_i[0]);
    assign exp_shift_c[6] = exp_g[5] | (exp_p[5] & exp_g[4]) | (exp_p[5] & exp_p[4] & exp_g[3]) | (exp_p[5] & exp_p[4] & exp_p[3] & exp_g[2])
            | (exp_p[5] & exp_i[2]) | (exp_p[5] & exp_p[4] & exp_i[1]) | (exp_p[5] & exp_p[4] & exp_i[0]);
            
    assign overflow = exp_shift_c[6] ^ exp_shift_c[5];
    assign exp_r = exp_shift_c[5:0] ^ exp1 ^ exp2;
endmodule

// A small comparator for exponents. (5 gates)
module fp_exp_comp(
    input [12:0] a,
    input [12:0] b,
    output lt,
    output eq
);
    wire [12:0] lt_bit = {~b[12] & a[12], ~a[11:0] & b[11:0]};
    wire [12:0] neq_bit = a ^ b;
    
    generate
        genvar i;
        // First level
        wire lt_int_first [6:0];
        wire neq_int_first [6:0];
        assign lt_int_first[6] = lt_bit[12];
        assign neq_int_first[6] = neq_bit[12];
        for (i = 0; i < 6; i = i + 1)
        begin: first_level
            assign lt_int_first[i] = neq_bit[2 * i + 1] ? lt_bit[2 * i + 1] : lt_bit[2 * i];
            assign neq_int_first[i] = neq_bit[2 * i + 1];
        end
        // Second level
        wire lt_int_second [3:0];
        wire neq_int_second [3:0];
        assign lt_int_second[3] = lt_int_first[6];
        assign neq_int_second[3] = neq_int_first[6];
        for (i = 0; i < 4; i = i + 1)
        begin: second_level
            assign lt_int_second[i] = neq_int_first[2 * i + 1] ? lt_int_first[2 * i + 1] : lt_int_first[2 * i];
            assign neq_int_second[i] = neq_int_first[2 * i + 1];
        end
        // Third level
        wire lt_int_third [1:0];
        wire neq_int_third [1:0];
        for (i = 0; i < 2; i = i + 1)
        begin: third_level
            assign lt_int_second[i] = neq_int_second[2 * i + 1] ? lt_int_second[2 * i + 1] : lt_int_second[2 * i];
            assign neq_int_second[i] = neq_int_second[2 * i + 1];
        end
    endgenerate
    
    assign lt = neq_int_third[1] ? lt_int_third[1] : lt_int_third[0];
    assign eq = ~neq_int_third[1];
endmodule

// The new FP exponent adder, a full-scale 13 bits adder.
// Note that it doesn't output exponent-specific format value, but normal
// 2's complement.
module fp_exp_adder(
    input cin,
    input [12:0] exp1,
    input [12:0] exp2,
    output [12:0] exp_r,
    output overflow
);

endmodule

module rounding_sel(
    input guard,
    input sticky,
    input [2:0] rounding_mode,
    input sign,
    input last_bit,
    output rounding_sel,
    output nv
);
    wire round_bit[0:7];
    // Round to Nearest, ties to Even
    assign round_bit[0] = (sticky & guard) ? last_bit : guard;
    // Round towards Zero
    assign round_bit[1] = 0;
    // Round Down (towards -inf)
    assign round_bit[2] = (guard | sticky) & sign;
    // Round Up (towards +inf)
    assign round_bit[3] = (guard | sticky) & ~sign;
    // Round to Nearest, ties to Max Magnitude
    assign round_bit[4] = guard;
    assign round_bit[5] = 0; // Invalid
    assign round_bit[6] = 0; // Invalid
    assign round_bit[7] = 0; // Invalid
    
    assign rounding_sel = round_bit[rounding_mode];
    assign nv = guard | sticky;
endmodule

module fp_diff_shifter(
    // The control bit
    // bit 2 and 1 indicate the mode (temp):
    // 00 - round+encode, 01 - adder preshift, 10 - convert to signed integer, 11 - convert to unsigned integer
    // bit 0 specifies input/output (depends on context) length: 0 - 32b, 1 - 64b
    input [2:0] opcode,
    // The first operand
    input [63:0] exp_a,
    input [63:0] man_a,  
    // The second operand - valid only if it is FPADD mode.
    input [63:0] exp_b,
    input [63:0] man_b,
    // output
    output [63:0] res_exp,
    output [63:0] res_man,
    // Flag bit: indicating which operand is being shifted
    output shift_flag
);
    // +++++ Rounder and encoder +++++
    
    // The rounding step will follow the shifter.
    
    // Prepare the operands for the adder
    // The encoder uses adder instead of comparator to check if it works. The shifter will just use the inverse as shifting parameter (if needed).
    // The shifter is only used for denorm. If a denorm presents (exp_biased <= 0), shifted ~exp + 2 (+1 for 2's complement negation and +1 for 
    // the property of denorms). We will shift the constant part in this module, and leave the ~exp to the shifter.
    // For the output of small adder, we will only look at its sign. If it is negative, and the original exp indicates it is a denorm, underflow
    // occurred. 
    // The lower bound (closed) of biased exponent for single precision is -23 and -52 for double precision. We will just add 23 or 52 to the exp.
    // We have a hack here to select 23 or 52 (I expect that optimization will attach the NOT gate to the mux): 
    // (NOTE 1)
    /*
    wire [12:0] exp_lower_bound;
    assign exp_lower_bound[12:6] = 7'b0;
    assign exp_lower_bound[5] = opcode[0];
    assign exp_lower_bound[4:2] = 3'b101;
    assign exp_lower_bound[1:0] = {2{~opcode[0]}};
    */
    // Check if it is a denorms.
    wire is_denorm = exp_a[12];
    
    // +++++ add preshift +++++
    // For adder preshift, we will use the difference between two exponents. 
    // Special value for FADD: check the encoding format for more info
    //     00  01  10  11
    // 00  00  00  10  11
    // 01  00  01  10  11
    // 10  10  10  a   11
    // 11  11  11  11  11
    // where a = exp1[63] ^ exp2[63] ? 11 : 10
    wire fadd_spec[1:0];
    assign fadd_spec[1] = exp_a[62] | exp_b[62];
    assign fadd_spec[0] = exp_a[61] & exp_b[61] | (exp_a[62] & ~exp_a[61] & exp_b[62] & ~exp_b[61] & (exp_a[63] ^ exp_b[63]));
    
    // The mini adder operands is just exp_a[12:0] and exp_b[12:0]. Done.
    
    // +++++++ convert to integer (both) ++++++++
    // For this part, we will shift the mantissa to the right by (int bit) - exp[12:0].
    // For signed integer, subtract an additional 1. We will then xor it with sign bit, and add 1 in rounding adder.
    // If the result is negative, overflow occurred. We set it to the corresponding value by selecting xor operand.
    
    // Prepare adder operand. We will use carry in to control signed and unsigned numbers.
    // The adder is 31 and 63.
    // (NOTE 1)
    /*
    wire [12:0] to_int_exp;
    assign to_int_exp[12:6] = 7'b0;
    assign to_int_exp[5] = opcode;
    assign to_int_exp[4:0] = 5'b11111;
    */
    
    // The xor part will be used after the shift.
    
    // ==========================================
    // Small adder: We use a full-scale 13b canonic adder.
    // It is expensive but fast --  in this case, 6 FO4 delay makes it worth using.
    
    // First, determine constant operand. It is an confusing hacking - but it will help you understand it
    // if you write down 23, 31, 52 and 63 as binary numbers.
    // See the comments with mark (NOTE 1) for their meaning.
    wire [12:0] constant_add;
    assign constant_add[12:6] = 7'b0;
    assign constant_add[5] = opcode[0];
    assign constant_add[4] = 1'b1;
    assign constant_add[3] = opcode[2];
    assign constant_add[2] = 1'b1;
    assign constant_add[1:0] = {2{opcode[2] | opcode[1] | ~opcode[0]}};
    
    // Then, determine the carry in and xor operand for subtraction. It is 0 only if opcode[2:1] = 2'b0.
    wire minus_control = |opcode[2:1];
    
    // If it is adder preshift mode (01), use exp_b as the operand; otherwise, use constant_add.
    wire [12:0] adder_operand = (opcode[2] | ~opcode[1]) ? exp_b[12:0] : constant_add;
    
    wire [12:0] adder_res;
    wire adder_overflow;
    fp_exp_adder(
        .cin(minus_control),
        .exp1(adder_operand),
        .exp2({13{minus_control}} ^ exp_a[12:0]),
        .exp_r(adder_res),
        .overflow(adder_overflow)
    );
    
    // +++++ Rounder and encoder +++++
    // Detect any kind of overflow: exp is all 1 or overflow bit is set.
    //wire encoder_overflow = |{adder_res, adder_overflow, exp_a[60]};
    
    // Detect underflow of denorms. If the adder output is negative, and it is not due to adder overflow, it is an underflow.
    // In this case, there is no need to use the long shifter. We will only set up the rounding bits.
    // Rounding bit will only produce nonzero result if the adder output is -1, which means the guard bit is the leading 1 of
    // the mantissa. 
    wire underflow = is_denorm & adder_res[12] & ~adder_overflow;
    wire take_rounding_bit_encoder = &adder_res;
    // If the flag is true, treat the leading 1 as guard, the second bit as round, etc.
    // This bit will be generated while signals propagate through adder.
    wire guard_rounder = man_a[63];
    wire round_rounder = man_a[62];
    wire sticky_rounder = &man_a[61:0];
    
    // +++++ add preshift +++++
    // Select the right mantissa to shift
    assign shift_flag = (adder_res[12] ^ adder_overflow);
    wire [63:0] man_shift_input = (shift_flag ? man_a : man_b) & ~adder_overflow;
    
    // Small shift adjustment
    // If this is a subtraction, and the exponent is 0 or 1, there is a postshift but no big preshift.
    // If that is the case, and exp is 1, we do a small preshift here.
    wire adder_out_0 = ~|adder_res[12:1];
    wire preshift = adder_out_0 | &adder_res[12:1];
    wire no_small_preshift = |{adder_res[12:1], ~adder_res[0]};
    wire [63:0] shifted_man = no_small_preshift ? man_shift_input : {1'b0, man_shift_input[62:0]};
    
    // +++++++ convert to integer (both) ++++++++
    // Detect if it is negative. If it isn't negative:
    //  -- If it is 0: treat as negative
    //  -- Otherwise: overflow, set to corresponding value.
    // If exp_a is smaller than 0, underflow:
    //  -- If exp is -1. check reounding. 
    wire take_rounding_bit_converter = |exp_a[12:0];
    wire converter_overflow = ~adder_out_0 & ~adder_res[12] & opcode[1];
    wire converter_underflow = exp_a[12] & opcode[1];
    
    // =========================================
    // Negate the adder output if it is negative
    wire [12:0] counter_out;
    constant_1bit_adder #(BIT(13)) (
        .a(~adder_res),
        .carry_out(),
        .sign_carry_in(),
        .r(counter_out)
    );
    wire [12:0] exp_diff = adder_res[12] ? counter_out : adder_res;
    
    // Do all mantissa covering (overflow, ...)
    // add preshift:
    // If overflow occurred, cover mantissa with 0. Ignore sticky bit since they won't make any
    // difference.
    // convert to integer:
    // for unsigned, any negative sign result in all 0; overflow pull all bits to 1.
    // for signed, if overflow, sign bit ^ 0111111...
    wire [63:0] conv_overflow_man;
    assign conv_overflow_man[63] = exp_a[63];
    assign conv_overflow_man[62:0] = {63{~exp_a[63]}};
    wire pull_0 = (~opcode[1] & opcode[0] & adder_overflow) | (opcode[1] & opcode[0] & exp_a[63]) | exp_a[12];
    wire pull_1 = opcode[1] & opcode[0] & ~adder_out_0 & ~adder_res[12];
    // TODO use one-hot mux to select the mantissa
    
    // The case that no shifting is needed:
    // 1. for rounding, it is a denorm and not underflow.(kill the uop)
    // 2. for adder, small 1b shifter is invoked (delay the uop) or overflow (kill the uop)
    // 3. for converter, overflow occurred.
    
    // Encode the output exponent
    // For rounder, it will be sent to rounder, so the 
    
    // ==================
    // Select shift operand
    // Rounder: negated exp
    wire [5:0] round_shift_operand = {6{exp_a[12]}} ^ exp_a[5:0];
    // adder preshift: exp_diff, the difference between exp
    wire [5:0] adder_shift_operand = exp_diff[5:0];
    // converter: Just adder output, the difference between exp and 64 (or 32)
    wire [5:0] convert_shift_operand = adder_res[5:0];
    
    // Select direction
    // Rounder: to right
    // adder preshift: to right
    // converter: to right
    
    // Start the shifter.
    // Rounder: 
    wire [63:0] shifter_out;
    wire sticky_all, sticky, guard, round;
    shifter (
        .shift(opcode[1] ? convert_shift_operand : (opcode[0] ? adder_shift_operand : round_shift_operand)),
        .sl(1'b0),
        .extend_bit(1'b0),
        .in(shifter_sel ? man_a : man_b),
        .out(shifter_out),
        
        // FP Extension
        .sticky_all(sticky_all), // Treat guard and round as a part of the sticky bit generation
        .sticky(sticky),
        .guard(guard),
        .round(round)
    );
    
    // Generate +1 to the result of shifter
    wire [63:0] round_up;
    wire shift_1b;
    constant_1bit_adder (
        .a(shifter_out),
        .carry_out(shift_1b),
        .sign_carry_in(),
        .r(round_up)
    );
    // Check rounding bits
    // For single, 40 is guard
    // For double, 12 is guard
    // For 32b, 31 is guard
    // For 64b, guard is outside
    // For all wires below, 0 is last valid digit, 1 is guard, 2 is sticky, 
    // Index of different mode: {single, double, int64b, int32b}
    wire [0:2] rounding_bit [0:3];
    assign rounding_bit[0][0] = shifter_out[41];
    assign rounding_bit[1][0] = shifter_out[13];
    assign rounding_bit[2][0] = shifter_out[32];
    assign rounding_bit[3][0] = shifter_out[0];
    assign rounding_bit[0][1] = shifter_out[40];
    assign rounding_bit[1][1] = shifter_out[12];
    assign rounding_bit[2][1] = shifter_out[31];
    assign rounding_bit[3][1] = guard;
    assign rounding_bit[0][2] = |{shifter_out[39:0], sticky_all};
    assign rounding_bit[1][2] = |{shifter_out[11:0], sticky_all};
    assign rounding_bit[2][2] = |{shifter_out[30:0], sticky_all};
    assign rounding_bit[3][2] = sticky;
    // TODO from opcode to sel
    wire [0:1] rb_sel;
    
    // Select output
    wire rounding_sel;
    rounding_sel(
        .guard(rounding_bit[rb_sel][1]),
        .sticky(rounding_bit[rb_sel][2]),
        .rounding_mode(),
        .sign(exp_a[63]),
        .last_bit(rounding_bit[rb_sel]),
        .rounding_sel(rounding_sel),
        .nv()
    );
    assign res_man = rounding_sel ? round_up : shifter_out;
    
endmodule

// ======= Reference old design ===========
// This module should be added as an extension of shifter to the datapath.
// It calculate exponent and align.
// It will destroy the original data of the mantissa register being shifted.
module fp_adder_init(
    input [63:0] exp1, // In conversion mode, this must be 64/32; In shifting mode, lower 6 bit is shift control
    input [63:0] exp2,
    input [63:0] man1,
    input [63:0] man2,
    input fp_convert,  // 1 if converting fp to int
    input to_signed, // Applied if converting to int
    input shifter, // Shifting mode
    output [63:0] res_exp,
    output [63:0] res_man,
    output shift_sel
);
    // Special value
    //     00  01  10  11
    // 00  00  00  10  11
    // 01  00  01  10  11
    // 10  10  10  a   11
    // 11  11  11  11  11
    // a = exp1[63] ^ exp2[63] ? 11 : 10
    assign res_exp[62] = exp1[62] | exp2[62];
    assign res_exp[62] = exp1[61] & exp2[61] | (exp1[62] & ~exp1[61] & exp2[62] & ~exp2[61] & (exp1[63] ^ exp2[63]));
    
    // TODO Set if this is a conversion to 64 bit integer
    wire to_64b;
    
    // We use a small comparator to get the result sign.
    wire neg, eq;
    fp_exp_comp(
        .a(exp1),
        .b(exp2),
        .lt(neg),
        .eq(eq)
    );
    
    // Only the lower 6 bit of exponent difference will produce a valid/meaningful shifter output.
    // And we will only calculate the lower 6 bit before we send it into the shifter.
    wire [5:0] shift_bit;
    wire overflow;
    exp_adder(
        .exp1(exp1[5:0]),
        .exp2(exp2[5:0]),
        .exp_r(shift_bit),
        .overflow(overflow)
    );
    
    // Calculation of high 6 bits; some of these calculation is done concurrently with shifter
    // Flip and add
    wire [6:0] high_exp;
    wire high_cin;
    exp_adder(
        .exp1(exp1[11:6]),
        .exp2(exp2[11:6]),
        .exp_r(high_exp[5:0]),
        .overflow(high_cin)
    );
    assign high_exp[6] = exp1[12] ^ exp2[12] ^ high_cin;
    
    // shift if negated: the inversed value of a negative number is 1 less than the negated number.
    // This is not on the critical path.
    wire [63:0] shift_operand = neg ? {1'b0, man1[63:1]} : man2;
    // main shift
    wire [63:0] shifted_man;
    wire guard, round, sticky, sticky_all;
    shifter (
        .shift(shifter ? exp1[5:0] : shift_bit ^ {6{neg}}),
        .sl(1'b0),
        .extend_bit(1'b0),
        .in(shift_operand),
        .out(shifted_man),
        .sticky_all(sticky_all),
        .sticky(sticky),
        .guard(guard),
        .round(round)
    );
    
    // If the exponent difference is valid for shifting, the output of high_exp has only three possible value:
    // 000...000(exp1 - exp2 = 1), 111...111(exp1 = exp2), 111...110(exp1 - exp2 = -1).
    // If valid but high_exp[0] is 0(diff 1), the lower 6 bits adder must overflow, or the value it gets is invalid.
    // Also, if it is in the conversion mode, and the exponent > 64 or 32 (diff is positive), it is invalid
    // Here is how to detect this value. (3 gates if optimized)
    wire invalid = ((&high_exp | ~(|high_exp[6:1])) & (~high_exp[0] ^ overflow) | (~neg & ~eq & fp_convert)) & ~shifter;
    // If we are converting fp to int, but result is invalid,
    wire res_sel = fp_convert & ~(to_signed ^ neg);
    
    // Finalize
    assign res_man = invalid ? {64{res_sel}} : shifted_man;
    assign res_exp[63] = neg ? exp1[63] : exp2[63];
    assign res_exp[60] = 1'b0;
    assign res_exp[59] = to_64b ? sticky : sticky_all;
    assign res_exp[58] = to_64b & guard;
    assign res_exp[57] = to_64b & round;
    assign res_exp[56:13] = 46'b0;
    assign res_exp[12:0] = neg ? exp1[12:0] : exp2[12:0];
endmodule
// =========== Another reference design =============
// experiment
module encoder_double_experiment(
    input [63:0] exp,
    input [63:0] man,
    
    // Setting
    input [2:0] rm,
    
    output [63:0] out
);

    // Check if it is a denorms.
    wire is_denorm = exp[12];
    
    // calculate the shifting offset
    // By default, all shift to the right by 11 to align with the rounding bit
    // If a denorm presents (exp_biased <= 0), shift ~exp + 2 (+1 for 2's complement negation and +1 for 
    // the property of denorms). We will shift the constant part in this module, and leave the ~exp to the shifter.
    // If the result underflow, the high 7 bit in the result will not be 0 since the result >= 64.
    // To construct 11 and 13 fast, we use some bit hacking
    // 0010 1000
    // 0010 1010
    // 0000 1011
    // 0000 1101
    wire [12:0] offset_base = {11'b11, is_denorm, 1'b0};
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
    // Low: denorm underflow detected in exponent adder, overflow by exp = 111..111
    // Events with higher priority overwrites those with lower priority.
    // Note that this event will only change the flag if the flag is 00 (normal value).
    wire man_nonzero = |man;
    wire exp_all_one = &{~exp[12], exp[11:0]};
    wire high_flag = exp[60] | exp[59];
    wire medium_flag = ~(high_flag | man_nonzero);
    
    wire to_inf = high_flag ? exp[60] : (~medium_flag & exp_all_one);
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
    wire roundup_shift = round_up[51];
    
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
    
    // Decide mantissa output
    // If we have inf or zero, wipe all bit out
    // If we have NaN, wipe out all bit but set MSB to 1 (see RISC-V specs, section 8.3)
    // Otherwise, select the rounding bit.
    // If there is a carry-out when rounding up, ignore it since we don't have to actually
    // shift a 0
    wire [63:0] sv_man_int;
    assign sv_man_int[51] = &{special_value};
    assign sv_man_int[63:52] = 12'b0;
    assign sv_man_int[50:0] = 51'b0;
    wire [63:0] round_man_int = round_sel ? round_up : man;
    assign out[51:0] = |special_value ? sv_man_int[51:0] : round_man_int[51:0];
    
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
    assign out[62:52] = |special_value ? sv_exp_int : round_exp_int;
    
    // sign
    assign out[63] = exp[63];
endmodule