`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2018 05:22:22 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input [63:0] a,
    input [63:0] b,
    input [2:0] funct3,
    input funct7_5,
    input funct7_0,
    output [63:0] res
    );
    // if funct7[0] is set, it is a RV64M instruction
    wire [63:0] res_sel [0:7];
    wire [63:0] res_sel_m [0:7];
    assign res = funct7_0 ? res_sel_m[funct3] : res_sel[funct3];
    
    // sll and sll only have funct3[2] different
    wire [63:0] shift_out;
    shifter shift(.shift(b[5:0]), .sl(funct3[2]), .extend_bit(a[63] & funct7_5), .in(a), .out(shift_out));
    // slt and sltu only have funct3[0] different
    wire comp_out;
    comparator comp(.a(a), .b(b), .sign(funct3[0]), .lt(comp_out), .eq());
    wire [63:0] add_out;
    adder_lookahead add(.a({64{~funct7_5}} ^ a), .b(b), .cin(funct7_5), .r(add_out));
    
    assign res_sel[0] = add_out;
    assign res_sel[1] = shift_out;
    assign res_sel[2] = {63'b0, {comp_out}};
    assign res_sel[3] = {63'b0, {comp_out}};
    assign res_sel[4] = a ^ b;
    assign res_sel[5] = shift_out;
    assign res_sel[6] = a | b;
    assign res_sel[7] = a & b;
    
    // funct3[1] indicates the signedness of all M instructions
    wire [63:0] mul_out_h;
    wire [63:0] mul_out_l;
    multiplier mul(.sign(funct3[1:0]), .a(a), .b(b), .h(mul_out_h), .l(mul_out_l));
    wire [63:0] div_out;
    wire [63:0] rem_out;
    divider div(.sign(funct3[1]), .diviend(a), .divisor(b), .quotient(div_out), .remainder(rem_out));
    assign res_sel_m[0] = mul_out_l;
    assign res_sel_m[1] = mul_out_h;
    assign res_sel_m[2] = mul_out_h;
    assign res_sel_m[3] = mul_out_h;
    assign res_sel_m[4] = div_out;
    assign res_sel_m[5] = div_out;
    assign res_sel_m[6] = rem_out;
    assign res_sel_m[7] = rem_out;
    
endmodule

module shifter_cell #(parameter level = 0) (
    input sl,
    input shift,
    input [2 ** level - 1:0] in,
    inout [2 ** level - 1:0] left_c,
    inout [2 ** level - 1:0] right_c,
    output [2 ** level - 1:0] out
    );
    wire [2 ** level - 1:0] left_c_out;
    wire [2 ** level - 1:0] right_c_out;
    assign out = shift ? (sl ? left_c : right_c) : in;
    control_buf #(.WIDTH(2 ** level)) to_right (.in(in), .out(right_c), .control(sl & shift));
    control_buf #(.WIDTH(2 ** level)) to_left (.in(in), .out(left_c), .control(~sl & shift));
endmodule

module single_shifter #(parameter level = 0) (
    input shift,
    input sl,
    input extend_bit,
    input [63:0] in,
    output [63:0] out
    );
    localparam wire_width = 2 ** level;
    localparam group_count = 2 ** (6 - level);
    
    wire [wire_width - 1:0] grouped_in[0:group_count - 1];
    wire [wire_width - 1:0] grouped_out[0:group_count - 1];
    wire [wire_width - 1:0] carry_int[0:group_count];

    generate
        genvar i, j;
        for (i = 0; i < group_count; i = i + 1)
        begin: grouping
            assign grouped_in[i] = in[(i + 1) * wire_width - 1:i * wire_width];
            assign out[(i + 1) * wire_width - 1:i * wire_width] = grouped_out[i];
        end
        
        for (j = 0; j < group_count; j = j + 1)
        begin: cell_gen
            shifter_cell #(.level(level)) the_cell (
                .sl(sl),
                .shift(shift),
                .in(grouped_in[j]),
                .left_c(carry_int[j]),
                .right_c(carry_int[j + 1]),
                .out(grouped_out[j])
            );    
        end
    endgenerate
    
    // Always move 0 in when shifting left
    control_buf #(.WIDTH(wire_width)) from_right (.in(0), .out(carry_int[0]), .control(sl));
    // Depends on the shift mode, move 1 or 0 in when shifting right
    control_buf #(.WIDTH(wire_width)) from_left (.in({(wire_width){extend_bit}}), .out(carry_int[group_count]), .control(~sl));
endmodule

module shifter (
    input [5:0] shift,
    input sl,
    input extend_bit,
    input [63:0] in,
    output [63:0] out
    );
    wire [63:0] intermediate [0:6];
    assign intermediate[0] = in;
    assign out = intermediate[6];
    genvar i;
    generate
        for(i = 0; i < 6; i = i + 1)
        begin: shifter_gen
            single_shifter #(.level(i)) shift (.in(intermediate[i]), .out(intermediate[i + 1]),
                .shift(shift[i]), .sl(sl), .extend_bit(extend_bit));
        end
    endgenerate
endmodule

module single_adder (
    input a,
    input b, 
    input carry_in, 
    output carry_out,
    output r
    );
    assign r = a ^ b ^ r;
    assign carry_out = (a & b) | (b & carry_in) | (carry_out & a);
endmodule

module adder (
    input carry_in,
    input [63:0] a,
    input [63:0] b,
    output carry_out,
    output sign_carry_in,
    output [63:0] r
);
    wire intermediate [0:64];
    assign intermediate[0] = carry_in;
    assign carry_out = intermediate[64];
    assign sign_carry_in = intermediate[63];
    
    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1)
        begin: adder_gen
            single_adder(.a(a[i]), .b(b[i]), .r(r[i]),
                .carry_in(intermediate[i]), .carry_out(intermediate[i + 1]));
        end
    endgenerate
endmodule

module comparator(
    input [63:0] a,
    input [63:0] b,
    input sign,
    output lt,
    output eq
    );
    // swap the sign bit of a and b when they are signed
    wire [63:0] signed_a;
    wire [63:0] signed_b;
    assign signed_a[62:0] = a[62:0];
    assign signed_b[62:0] = b[62:0];
    assign signed_a[63] = sign ? b[63] : a[63];
    assign signed_b[63] = sign ? a[63] : b[63];
    
    wire [63:0] lt_bit = ~signed_a & signed_b;
    wire [63:0] neq_bit = signed_a ^ signed_b;
    
    // A comparison tree
    generate
        genvar i, j;
        for (i = 0; i < 6; i = i + 1)
        begin: level
            wire lt_int [0:2 ** (5 - i) - 1];
            wire neq_int [0:2 ** (5 - i) - 1];
            for (j = 0; j < 2 ** (5 - i); j = j + 1)
            begin: cell_
                if (i == 0) begin
                    assign lt_int[j] = neq_bit[2 * j + 1] ? lt_bit[2 * j + 1] : lt_bit[2 * j];
                    assign neq_int[j] = neq_bit[2 * j + 1];
                end else begin
                    assign lt_int[j] = level[i - 1].neq_int[2 * j + 1] ? level[i - 1].lt_int[2 * j + 1] : level[i - 1].lt_int[2 * j];
                    assign neq_int[j] = level[i - 1].neq_int[2 * j + 1];
                end
            end
        end
    endgenerate
    
    assign lt = level[5].lt_int[0];
    assign eq = ~level[5].neq_int[0];
endmodule

// slT
module divider_cell(
    input [64:0] partial_rem_in,
    input [64:0] divisor,
    input [5:0] counter_in,
    input [5:0] counter_end,
    output [64:0] partial_rem_out,
    output pos_quotient,
    output neg_quotient,
    output [5:0] counter_out
);
    wire halt = ~|(counter_in ^ counter_end);
    assign counter_out = halt ? (counter_in - 1) : counter_in;
    
    assign pos_quotient = (~partial_rem_in[64] & ~partial_rem_in[63] & partial_rem_in[62]);
    assign neg_quotient = (partial_rem_in[64] & partial_rem_in[63] & ~partial_rem_in[62]);
    
    wire [64:0] partial_rem_int [0:1];
    assign partial_rem_int[0] = partial_rem_in;
    wire sign_carry_out;
    adder(.carry_in(pos_quotient), .a(partial_rem_in[63:0]),
        .b(pos_quotient ? ~divisor[63:0] : divisor[63:0]),
        .r(partial_rem_int[1][63:0]), .carry_out(sign_carry_out));
    single_adder(.a(partial_rem_in[64]), .b(pos_quotient ? ~divisor[64] : divisor[64]),
        .carry_in(sign_carry_out), .r(partial_rem_int[1][64]));
    assign partial_rem_out = halt ?
        partial_rem_in :
        {partial_rem_int[pos_quotient | neg_quotient][64:1], 1'b0};
endmodule

module divider (
    input sign,
    input [63:0] diviend,
    input [63:0] divisor,
    output [63:0] quotient,
    output [63:0] remainder
    );
    wire [5:0] diviend_bit;
    wire [5:0] divisor_bit;
    wire [63:0] diviend_unsigned;
    wire [63:0] divisor_unsigned;
    assign diviend_unsigned = (sign & diviend[63]) ? (~diviend + 1) : diviend;
    assign divisor_unsigned = (sign & divisor[63]) ? (~divisor + 1) : divisor;
    sbs #(.OUT_BIT(6), .IS_MSBS(1)) (.in(diviend_unsigned), .out(diviend_bit));
    sbs #(.OUT_BIT(6), .IS_MSBS(1)) (.in(divisor_unsigned), .out(divisor_bit));
    
    wire [64:0] aug_divisor;
    assign aug_divisor[63:0] = divisor;
    assign aug_divisor[64] = sign ? divisor[63] : 0;
    
    wire [63:0] pos_quotient;
    wire [63:0] neg_quotient;
    
    wire [64:0] rem_int [0:64];
    wire [64:0] counter_int [0:64];
    assign rem_int[0] = diviend;
    assign counter_int[0] = diviend_bit;
    generate
        genvar i;
        for (i = 0; i < 64; i = i + 1)
        begin: div_gen
            divider_cell(
                .partial_rem_in(rem_int[i]),
                .divisor(aug_divisor) ,
                .counter_in(counter_int[i]),
                .counter_end(divisor_bit),
                .partial_rem_out(rem_int[i + 1]),
                .pos_quotient(pos_quotient[63 - i]),
                .neg_quotient(neg_quotient[63 - i]),
                .counter_out(counter_int[i + 1])
            );
        end
    endgenerate
    
    wire comp_out;
    comparator(.a(diviend_bit), .b(divisor_bit), .sign(0), .lt(comp_out));
    wire [63:0] q_out;
    wire [63:0] normalized_q;
    wire skip_div = comp_out | ~|divisor;
    assign quotient = skip_div ? 0 : q_out;
    assign remainder = skip_div ? diviend : rem_int[64][64:1];
    adder(.carry_in(1), .a(pos_quotient), .b(~neg_quotient), .r(normalized_q));
    shifter(.shift(divisor_bit), .sl(1), .extend_bit(sign & normalized_q[63]),
        .in(normalized_q), .out(q_out));
endmodule

// =================
// Select the correct q digits. 
// WARNING: Bit 5 of p and Bit 3 of d are the sign bits.
module div_sel(
    input [5:0] p_high,
    input [5:0] pc_high,
    input [3:0] d_high,
    output [1:0] q_digit,
    output q_sign
);
    // First, generate the highest 5 bit of p
    wire [5:0] gen_p;
    wire [5:0] adder_p = p_high | pc_high;
    wire [5:0] adder_g = p_high & pc_high;
    wire [5:0] adder_c;
    wire gout_int;
    lookahead(
        .pin(adder_p[3:0]),
        .gin(adder_g[3:0]),
        .cin(1'b0),
        .cout(adder_c[3:0]),
        .gout(gout_int),
        .pout()
    );
    assign adder_c[4] = gout_int & adder_p[4] | adder_g[4];
    assign adder_c[5] = (gout_int & adder_p[4] | adder_g[4]) & adder_p[5] | adder_g[5];
    assign gen_p = p_high ^ pc_high ^ adder_c;
    
    // Carry at lower bits may eventually affect the high bits we look at here,
    // which will cause p >= 4d in next iteration if d is smaller than (radix-2)0.101.
    // To prevent this, when d < 0.101 and p > 00.111 (or 01.011 and 01.111), we select
    // a higher q digit.
    // In general, we add 1 to the digit if the following condition is met:
    // If d=0.111xxxx....: (1)
    //     if p=110.111xxx... or p=101.111xxx...
    // If d=0.100xxxx....: (2)
    //     if p=000.111xxx... or p=001.011xxx... or p=001.111xxx...
    // If d=0.101xxxx....: (3)
    //     if p=110.011xxx...
    wire add_1 = (((d_high[0] & d_high[1]) & (gen_p[5] & gen_p[2] & (gen_p[4] ^ gen_p[3]))) // (1)
        | ~(d_high[0] | d_high[1] | gen_p[5] | gen_p[4]) & (gen_p[3] | gen_p[2]) // (2)
        | ((~d_high[0] & d_high[1]) & (gen_p[5] & gen_p[4] & ~gen_p[3] & ~gen_p[2]))) // (3) 
        & (gen_p[1] & gen_p[0]); // Common condition: the lower two digits of p we inspect must be 1
    
    // If q is negative, inverse the bit waiting for inspection before checking
    // If q_high > 0b100, output 0b11 (3)
    // If q_high == 0b011 and d_high > 0b0010, output 0b10 (2)
    // Otherwise, output lower two bits of q_high. 
    assign q_sign = gen_p[5];
    wire [2:0] p_checking = {3{gen_p[5]}} ^ gen_p[4:2];
    wire [1:0] sel = {2{p_checking[2]}} | ({1'b1, ~(p_checking[1] & p_checking[0] & d_high[3])} & p_checking[1:2]);
    
    assign q_digit[0] = sel[0] ^ add_1;
    assign q_digit[1] = sel[1] ^ (sel[0] & add_1);
endmodule

module div_cell (
    // A pre-calculated value to accelerate the remainder computation
    // Note: we are using 1's complement to save +1 adder, so it is necessary to add 1 back
    input [65:0] d1, // = d
    input [65:0] d2, // = 2d
    input [65:0] d3, // = 3d

    input [65:0] p,
    input [65:0] pc,  // The carry part produced by CSAs
    
    output [1:0] q_digit,
    output q_sign,
    output [65:0] new_p,
    output [65:0] new_pc
);
    wire [1:0] sel;
    wire sel_sign;
    div_sel(.p_high(p[65:60]), .pc_high(pc[65:60]), .d_high(d1[65:62]), .q_digit(sel), .sign(sel_sign));
    assign q_digit = sel;
    assign q_sign = sel_sign;
    wire [65:0] div_sub [0:3];
    assign div_sub[0] = 66'h3_FFFF_FFFF_FFFF_FFFF;
    assign div_sub[1] = d1;
    assign div_sub[2] = d2;
    assign div_sub[3] = d3;
    
    wire [65:0] csa_r;
    wire [65:0] csa_c;
    csa #(.INPUT_SIZE(66)) (
        .a(p),
        .b({pc[65:1], ~sel_sign}), // If sel_sign is positive, add 1 as the carry_in for subtraction
        .c(div_sub[sel] ^ {66{~sel_sign}}),  // If sel_sign is positive, inverse the divisor
        .cin(1'b0),
        .cout(csa_c),
        .r(csa_r)
    );
    assign new_p = {csa_r[63:0], 2'b00};
    assign new_pc = {csa_c[63:0], 2'b00};
endmodule

// A 1-bit cell used for tail case.
module div_cell_1 (
    input [65:0] d,

    input [65:0] p,
    input [65:0] pc,  // The carry part produced by CSAs
    
    output q_digit,
    output q_sign,
    output [65:0] new_p,
    output [65:0] new_pc
);
    // generate higher 3 bits
    wire [2:0] high_p = p[65:63] | pc[65:63];
    wire [2:0] high_g = p[65:63] & pc[65:63];
    wire [2:0] high_c;
    assign high_c[0] = 1'b0;
    assign high_c[1] = high_g[0];
    assign high_c[2] = (high_p[1] & high_g[0]) | high_g[1];
    wire [2:0] high_bit = p[65:63] ^ pc[65:63] ^high_c;

    // Select
    assign q_digit = ~&high_bit;
    assign q_sign = high_bit[2];
    
    // Add
    wire [65:0] csa_r;
    wire [65:0] csa_c;
    csa #(.INPUT_SIZE(66)) (
        .a(p),
        .b({pc[65:1], ~q_sign}), // If sel_sign is positive, add 1 as the carry_in for subtraction
        .c((d & {66{q_digit}}) ^ {66{~q_sign}}),  // If sel_sign is positive, inverse the divisor
        .cin(1'b0),
        .cout(csa_c),
        .r(csa_r)
    );
    assign new_p = {csa_r[63:0], 2'b00};
    assign new_pc = {csa_c[63:0], 2'b00};
endmodule

module divider_1(
    input sign,
    input [63:0] dividend,
    input [63:0] divisor,
    output [63:0] quotient,
    output [63:0] remainder,
    
    input clk,
    input enable,
    output busy,
    output res_ready
);
    // Negate the divisor if it is negative
    wire divisor_signed = sign & divisor[63];
    wire [63:0] unsigned_divisor_int = {64{divisor_signed}} ^ divisor;
    wire [63:0] unsigned_divisor;
    constant_1bit_adder (
        .a(unsigned_divisor_int),
        .carry_out(),
        .sign_carry_in(),
        .r(unsigned_divisor)
    );
    
    // Detect and shift divisor
    wire [5:0] d_msbs;
    wire divide_0;
    sbs (
        .in(unsigned_divisor),
        .out(d_msbs),
        .indeterminate(divide_0)
    );
    
    // =================================
    
    wire [65:0] d;
    shifter (
        .shift(~d_msbs),
        .sl(1'b1),
        .extend_bit(1'b0),
        .in(divisor),
        .out(d[63:0])
    );
    assign d[65:64] = 2'b0;
    
    wire dividend_sign = dividend[63] & sign;
    
    wire [65:0] p = {{2{dividend_sign}}, dividend};
    
    // Calculate the bit need to shift at the end
    wire [5:0] shift_bit;
    constant_1bit_adder #(.BIT(6)) (
        .a(d_msbs),
        .carry_out(),
        .sign_carry_in(),
        .r(shift_bit)
    );
    
    // Calculate the dividing value (All are 1's complement)
    wire [65:0] d1 = d;
    wire [65:0] d2 = {1'b0, d[63:0], 1'b0};
    wire [65:0] d3;
    wire d3_carryout;
    adder_lookahead(
        .a(d1[63:0]),
        .b(d2[63:0]),
        .cin(1'b0),
        .r(d3[63:0]),
        .cout(d3_carryout),
        .sign_cin()
    );
    assign d1[64] = ~(~d[63] ^ d3_carryout);
    assign d2[65] = d[63] & ~d3_carryout;
    
    // Save everything
    reg [65:0] d1_reg;
    reg [65:0] d2_reg;
    reg [65:0] d3_reg;
    reg [5:0] shift_bit_reg;
    reg [5:0] shift_counter;
    reg [65:0] p_reg;
    reg [65:0] pc_reg;
    reg [63:0] pos_q_reg;
    reg [63:0] neg_q_reg;
    reg busy_reg;
    reg in_loop;
    reg dividend_sign_reg;
    always @ (posedge clk) begin
        if (~busy_reg & enable & divide_0) begin
            d1_reg <= d1;
            d2_reg <= d2;
            d3_reg <= d3;
            shift_bit_reg <= shift_bit;
            p_reg <= p;
            pc_reg <= 66'b0;
            pos_q_reg <= 64'b0;
            neg_q_reg <= 64'b0;
            busy_reg <= 1'b1;
            shift_counter <= 6'b0;
            in_loop <= 1'b1;
            dividend_sign_reg <= dividend_sign;
        end
    end
    
    // ========== THE END OF THE INITIAL STAGE ===========
    
    // We need 32 divider cells, but we will use a register to reduce it to 2 or 4, depending on
    // the pipeline stage delay
    parameter CELL_NUM = 2;
    wire [65:0] p_int[0:CELL_NUM];
    wire [65:0] pc_int[0:CELL_NUM];
    wire [CELL_NUM * 2 - 1:0] pos_q_int;
    wire [CELL_NUM * 2 - 1:0] neg_q_int;
    assign p_int[0] = p_reg;
    assign pc_int[0] = pc_reg;
    generate
        genvar i;
        for (i = 0; i < CELL_NUM; i = i + 1)
        begin: divider_cells
            wire [1:0] q_raw;
            wire q_sign;
            div_cell (
                .d1(d1_reg),
                .d2(d2_reg),
                .d3(d3_reg),
                .p(p_int[i]),
                .pc(pc_int[i]),
                .q_digit(q_raw),
                .q_sign(q_sign),
                .new_p(p_int[i + 1]),
                .new_pc(pc_int[i + 1])
            );
            assign pos_q_int[2 * (CELL_NUM - i) + 1: 2 * (CELL_NUM - i)] = {2{~q_sign}} & q_raw;
            assign neg_q_int[2 * (CELL_NUM - i) + 1: 2 * (CELL_NUM - i)] = {2{q_sign}} & q_raw;
        end
    endgenerate
    
    // add 4 (the current number of bits generated) to the shift counter
    wire [5:0] new_counter;
    constant_1bit_adder #(.BIT(4)) (
        .a(shift_counter[5:2]),
        .carry_out(),
        .sign_carry_in(),
        .r(new_counter[5:2])
    );
    assign new_counter[1:0] = shift_counter[1:0];
    
    // Compare the counter to see if it need to break
    wire loop_continue;
    comparator(
        .a(new_counter),
        .b(shift_bit_reg),
        .sign(1'b0),
        .lt(loop_continue),
        .eq()
    );
    
    // +++++++++++++++++++++++++++++
    
    // The result of this section will only be stored at the end end of the loop, 
    // since the last iteration will not do anything. When (current counter + 4) > shift bit,
    // the loop only sets the in_loop bit to 0 to break and doesn't write any useful data
    // to the register. 
    // We will use this loop to prepare for the tail case. 
    
    // Calculate how many bits left
    // We use a 2-bit adder to calculate it
    wire [1:0] tail_con;
    assign tail_con[0] = ~(shift_bit_reg[0] ^ ~shift_counter[0]);
    assign tail_con[1] = (shift_bit_reg[0] | ~shift_counter[0]) ^ shift_bit_reg[1] ^ ~shift_counter[1];
    
    // Set the tail state controller
    // If this is 0, the module will use 2-bit divider cell; otherwise, use 1-bit divider cell.
    // Its initial value will be the inverse of tail_con[1] (since we don't go through 2-bit cell
    // when there is only 1 bit left) 
    wire tail_state = ~tail_con[1];
    
    // ++++++++++++++++++++++++++++
    
    // Save everything
    reg tail_state_reg;
    reg [1:0] tail_con_reg;
    always @ (posedge clk) begin
        if (busy_reg & in_loop) begin
            if (loop_continue) begin
                pos_q_reg[63:CELL_NUM * 2] <= pos_q_reg[63 - CELL_NUM * 2:0];
                pos_q_reg[CELL_NUM * 2 - 1:0] <= pos_q_int;
                neg_q_reg[63:CELL_NUM * 2] <= neg_q_reg[63 - CELL_NUM * 2:0];
                neg_q_reg[CELL_NUM * 2 - 1:0] <= neg_q_int;
                shift_counter <= new_counter;
                p_reg <= p_int[CELL_NUM];
                pc_reg <= pc_int[CELL_NUM];
            end else begin
                tail_state_reg <= tail_state;
                tail_con_reg <= tail_con;
            end
            in_loop <= loop_continue;
        end
    end
    
    // ================== THE END OF THE LOOP STAGE ==================
    
    // 2-bit divider cell output
    wire [65:0] p_out_tail2;
    wire [65:0] pc_out_tail2;
    wire [63:0] pos_q_tail2;
    wire [63:0] neg_q_tail2;
    
    // 2-bit divider cell
    wire [1:0] q_raw_tail2;
    wire q_sign_tail2;
    div_cell (
        .sub1(d1_reg),
        .sub2(d2_reg),
        .sub3(d3_reg),
        .p(p_reg),
        .pc(pc_reg),
        .q_digit(q_raw_tail2),
        .q_sign(q_sign_tail2),
        .new_p(p_out_tail2),
        .new_pc(pc_out_tail2)
    );
    
    assign pos_q_tail2[63:2] = pos_q_reg[61:0];
    assign pos_q_tail2[1:0] = q_raw_tail2 & {2{~q_sign_tail2}};
    assign neg_q_tail2[63:2] = neg_q_reg[61:0];
    assign neg_q_tail2[1:0] = q_raw_tail2 & {2{q_sign_tail2}};
    
    // save everything
    always @ (posedge clk) begin
        if (busy_reg & ~in_loop & tail_con_reg[1]) begin
            tail_con_reg[1] <= 1'b0;
            pos_q_reg <= pos_q_tail2;
            neg_q_reg <= neg_q_tail2;
            p_reg <= p_out_tail2;
            pc_reg <= pc_out_tail2;
        end
    end
    
    // ================== THE END OF THE 2-BIT TAIL STAGE ===================
    
    // 1-bit divider cell
    wire [65:0] p_out_tail1;
    wire [65:0] pc_out_tail1;
    wire [63:0] pos_q_tail1;
    wire [63:0] neg_q_tail1;
    wire q_raw_tail1;
    wire q_sign_tail1;
    div_cell_1 (
        .d(d1_reg),
        .p(p_reg),
        .pc(pc_reg),
        .q_digit(q_raw_tail1),
        .q_sign(q_sign_tail1),
        .new_p(p_out_tail1),
        .new_pc(pc_out_tail1)
    );
    
    assign pos_q_tail1[63:1] = pos_q_reg[62:0];
    assign pos_q_tail1[0] = q_raw_tail1 & ~q_sign_tail1;
    assign neg_q_tail1[63:1] = neg_q_reg[62:0];
    assign neg_q_tail1[0] = q_raw_tail1 & q_sign_tail1;    
    
    // save everything
    always @ (posedge clk) begin
        if (busy_reg & ~in_loop & ~tail_con_reg[1] & tail_con_reg[0]) begin
            tail_con_reg[0] <= 1'b0;
            pos_q_reg <= pos_q_tail1;
            neg_q_reg <= neg_q_tail1;
            p_reg <= p_out_tail1;
            pc_reg <= pc_out_tail1;
        end
    end
    
    // ================== THE END OF THE 1-BIT TAIL STAGE ===================
    
    // We will generate both corrected and uncorrected version, then select the one
    // applied to this case as the result.
    
    // Corrected version
    wire [65:0] corrected_p;
    wire [65:0] corrected_pc;
    csa #(.INPUT_SIZE(66)) (
        .a(p_reg),
        .b(pc_reg),
        .c({66{dividend_sign_reg}} ^ d1_reg),
        .cin(dividend_sign_reg),
        .cout(corrected_pc),
        .r(corrected_p)
    );
    wire [63:0] corrected_q;
    wire [63:0] corrected_qc;
    csa #(.INPUT_SIZE(64)) (
        .a(divisor_signed ? neg_q_reg : pos_q_reg),
        .b(~(divisor_signed ? pos_q_reg : neg_q_reg)),
        .c({62'b0, dividend_sign_reg, 1'b0}),
        .cin(1'b0),
        .cout(corrected_qc),
        .r(corrected_q)
    );
    
    // Start CPA adding
    wire [63:0] corrected_r;
    adder_lookahead corrected_r_adder(
        .a(corrected_p[63:0]),
        .b(corrected_pc[63:0]),
        .cin(1'b0),
        .r(corrected_r),
        .cout(),
        .sign_cin()
    );
    wire [63:0] uncorrected_r;
    adder_lookahead uncorrected_r_adder(
        .a(p_reg[63:0]),
        .b(pc_reg[63:0]),
        .cin(1'b0),
        .r(uncorrected_r),
        .cout(),
        .sign_cin()
    );
    wire [63:0] corrected_final_q;
    adder_lookahead corrected_q_adder(
        .a(corrected_q),
        .b(corrected_qc),
        .cin(1'b0),
        .r(corrected_final_q),
        .cout(),
        .sign_cin()
    );
    wire [63:0] uncorrected_final_q;
    adder_lookahead uncorrected_q_adder(
        .a(divisor_signed ? neg_q_reg : pos_q_reg),
        .b(~(divisor_signed ? pos_q_reg : neg_q_reg)),
        .cin(1'b1),
        .r(uncorrected_final_q),
        .cout(),
        .sign_cin()
    );
    
    // Set output
    wire out_sel = uncorrected_r[63] ^ dividend_sign_reg;
    assign quotient = out_sel ? corrected_final_q : uncorrected_final_q;
    assign remainder = out_sel ? corrected_r : uncorrected_r;
    
    assign res_ready = busy_reg & ~in_loop & ~tail_con_reg[1] & ~tail_con_reg[0];
    assign busy = busy_reg;
    
    // Clear busy_reg
    always @ (posedge clk) begin
        if (res_ready)
            busy_reg <= 1'b0;
    end
endmodule

// =================

module csa #(parameter INPUT_SIZE = 128) (
    input [INPUT_SIZE - 1:0] a,
    input [INPUT_SIZE - 1:0] b,
    input [INPUT_SIZE - 1:0] c,
    input cin,
    output [INPUT_SIZE:0] cout,
    output [INPUT_SIZE:0] r
);
    assign r = {1'b0, a ^ b ^ c};
    assign cout = {(a & b) | (a & c) | (b & c), cin};
endmodule

// 4:2 CSA
// Note: in a multiplier, a 4:2 csa will never overflow
module csa4 #(parameter INPUT_SIZE = 64) (
    input [INPUT_SIZE - 1:0] a,
    input [INPUT_SIZE - 1:0] b,
    input [INPUT_SIZE - 1:0] c,
    input [INPUT_SIZE - 1:0] d,
    // Note: cin[1] is connected to the cin of the first 3:2 CSA, and cin[0] is connected to the second 3:2 CSA
    input [1:0] cin,
    output [INPUT_SIZE - 1:0] r,
    output [INPUT_SIZE - 1:0] cout
);
    wire [INPUT_SIZE - 1:0] int1;
    wire [INPUT_SIZE - 1:0] int2;
    csa #(.INPUT_SIZE(INPUT_SIZE)) csa_1 (.a(a), .b(b), .c(c), .cin(cin[1]), .r(int1), .cout(int2));
    csa #(.INPUT_SIZE(INPUT_SIZE)) csa_2 (.a(int1), .b(int2), .c({1'b0, d}), .cin(cin[0]), .r(r), .cout(cout));
endmodule

module partial_prod_gen #(parameter MSB_B = 0) (
    input b_bit,
    input [63:0] a,
    input a_sign,
    input b_sign,
    output [63:0] prod
);
    wire [63:0] prod_unsigned = a & {64{b_bit}};
    wire [63:0] prod_raw = {prod_unsigned[63] ^ a_sign, prod_unsigned[62:0]};
    generate
        if (MSB_B)
            assign #10 prod = prod_raw ^ {64{b_sign}};
        else
            assign #10 prod = prod_raw;
    endgenerate
endmodule

module multiplier (
    input [1:0] sign, // See the specs for its format (mul and mulh treated as signed)
    input [63:0] a,
    input [63:0] b,
    output [63:0] h,
    output [63:0] l
);
    
    // bit 1 control inversion on the left, bit 0 control inversion on the bottom
    wire [1:0] sign_con = {sign[1], sign[1] & sign[0]};
    
    generate
        genvar i, j;
        for (i = 0; i < 6; i = i + 1)
        begin: layer
            // Note the width is of the input wire
            localparam wire_width = 64 + 2 ** i;
            localparam wire_shift = 2 ** i;
            localparam wire_nums = 2 ** (5 - i);
            wire [wire_width - 1 + wire_shift:0] r_int [0:wire_nums - 1];
            wire [wire_width - 1 + wire_shift:0] c_int [0:wire_nums - 1];
            for (j = 0; j < wire_nums; j = j + 1)
            begin: CSAs
                if (i == 0)
                begin
                    wire [63:0] prod1;
                    wire [63:0] prod2;
                    partial_prod_gen #(.MSB_B(0)) generator_1 (.a(a), .b_bit(b[2 * j]), .a_sign(sign_con[1]), .b_sign(sign_con[0]), .prod(prod1));
                    partial_prod_gen #(.MSB_B(j == 31)) generator_2 (.a(a), .b_bit(b[2 * j + 1]), .a_sign(sign_con[1]), .b_sign(sign_con[0]), .prod(prod2));
                    csa #(.INPUT_SIZE(wire_width + wire_shift)) accumulator 
                        (.a({1'b0, prod1}), .b({prod2, 1'b0}), .c({wire_width{1'b0}}), .cin(1'b0), .r(r_int[j]), .cout(c_int[j]));
                end else begin // Accumulation tree
                    wire [wire_width - 1 + wire_shift:0] a_int = {{wire_shift{1'b0}}, layer[i - 1].r_int[2 * j]};
                    wire [wire_width - 1 + wire_shift:0] ac_int = {{wire_shift{1'b0}}, layer[i - 1].c_int[2 * j]};
                    wire [wire_width - 1 + wire_shift:0] b_int = {layer[i - 1].r_int[2 * j + 1], {wire_shift{1'b0}}};
                    wire [wire_width - 1 + wire_shift:0] bc_int = {layer[i - 1].c_int[2 * j + 1], {wire_shift{1'b0}}};
                    csa4 #(.INPUT_SIZE(wire_width + wire_shift)) accumulator
                        (.a(a_int), .b(ac_int), .c(b_int), .d(bc_int), .cin(2'b0), .r(r_int[j]), .cout(c_int[j]));
                end
            end
        end
    endgenerate
    
    // add extra bit
    // If "a" is signed, add 1 at Bit 127 and Bit 63
    // If "b" is signed, add 1 at Bit 63
    wire bit_127 = sign_con[0];
    wire bit_63 = sign_con[0] ^ sign_con[1];
    wire bit_64 = sign_con[0] & sign_con[1];
    wire [127:0] r /*= layer[5].r_int[0]*/;
    wire [127:0] c /*= layer[5].c_int[0]*/;
    csa #(.INPUT_SIZE(128)) remove_bit
        (.a(layer[5].r_int[0]), .b(layer[5].c_int[0]), .c({bit_127, 62'b0, bit_64, bit_63, 63'b0}), .cin(1'b0), .r(r), .cout(c));
    
    // Use two adders to add them
    wire adder_carry;
    adder_lookahead adder_low (
        .a(r[63:0]),
        .b(c[63:0]),
        .cin(1'b0),
        .r(l),
        .cout(adder_carry),
        .sign_cin()
    );
    adder_lookahead adder_high (
        .a(r[127:64]),
        .b(c[127:64]),
        .cin(adder_carry),
        .r(h),
        .cout(),
        .sign_cin()
    );
endmodule

// ==================

module lookahead(
    input [3:0] pin,
    input [3:0] gin,
    input cin,
    output [3:0] cout,
    output gout,
    output pout
);
    assign cout[0] = cin;

    wire cout_int_1; // Intermediate value for cout[1] calculation
    and(cout_int_1, pin[0], cin);
    or(cout[1], gin[0], cout_int_1);
    
    wire cout_int_2[0:1]; // Intermediate value for cout[2] calculation
    and(cout_int_2[0], pin[1], gin[0]);
    and(cout_int_2[1], pin[1], pin[0], cin);
    or(cout[2], gin[1], cout_int_2[0], cout_int_2[1]);
    
    wire cout_int_3[0:2]; // Intermediate value for cout[3] calculation
    and(cout_int_3[0], pin[2], gin[1]);
    and(cout_int_3[1], pin[2], pin[1], gin[0]);
    and(cout_int_3[2], pin[2], pin[1], pin[0], cin);
    or(cout[3], gin[2], cout_int_3[0], cout_int_3[1], cout_int_3[2]);
    
    wire gout_int[0:2]; // Intermediate value for gout calculation
    and(gout_int[0], pin[3], gin[2]);
    and(gout_int[1], pin[3], pin[2], gin[1]);
    and(gout_int[2], pin[3], pin[2], pin[1], gin[0]);
    or(gout, gin[3], gout_int[0], gout_int[1], gout_int[2]);
    
    and(pout, pin[3], pin[2], pin[1], pin[0]);
    
endmodule

module adder_lookahead(
    input [63:0] a,
    input [63:0] b,
    input cin,
    output [63:0] r,
    output cout,
    output sign_cin
);
    // Lookahead
    wire gout; // Global g for cout calculation
    wire pout; // Global p for cout calculation
    wire [63:0] c_int; // carry for individual bits
    wire [63:0] g_int; // g for individual bits
    wire [63:0] p_int; // p for individual bits
    wire [15:0] g_int_0; // g for level 0 lookahead
    wire [15:0] p_int_0; // p for level 0 lookahead
    wire [15:0] c_int_0; // carry for level 0 lookahead
    wire [3:0] g_int_1; // g for level 1 lookahead
    wire [3:0] p_int_1; // p for level 1 lookahead
    wire [3:0] c_int_1; // carry for level 1 lookahead
    generate
        genvar i, j;
        for (i = 0; i < 16; i = i + 1)
        begin: first
            lookahead lh_1(
                .pin(p_int[i * 4 + 3:i * 4]),
                .gin(g_int[i * 4 + 3:i * 4]),
                .cin(c_int_0[i]),
                .cout(c_int[i * 4 + 3:i * 4]),
                .gout(g_int_0[i]),
                .pout(p_int_0[i])
            );
        end
        for (j = 0; j < 4; j = j + 1)
        begin: second
            lookahead lh_2(
                .pin(p_int_0[j * 4 + 3:j * 4]),
                .gin(g_int_0[j * 4 + 3:j * 4]),
                .cin(c_int_1[j]),
                .cout(c_int_0[j * 4 + 3:j * 4]),
                .gout(g_int_1[j]),
                .pout(p_int_1[j])
            );
        end
    endgenerate
    // Third
    lookahead lh_3(
        .pin(p_int_1),
        .gin(g_int_1),
        .cin(cin),
        .cout(c_int_1),
        .gout(gout),
        .pout(pout)
    );
    
    // add and assign
    assign g_int = a & b;
    assign p_int = a | b;
    assign r = a ^ b ^ c_int;
    assign sign_cin = c_int[63];
    assign cout = gout | (pout & cin);
endmodule