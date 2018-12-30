`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 20:57:41
// Design Name: 
// Module Name: arith_component
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


module arith_component(

    );
endmodule

// ============= Common Component ================

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

// ============= Shifter ==============

//============================

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
