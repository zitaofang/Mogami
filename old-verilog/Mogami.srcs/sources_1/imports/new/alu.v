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

module canonic_adder_exp (
    input [11:0] a,
    input [11:0] b,
    output [11:0] r
);
    wire [11:0] p = a | b;
    wire [11:0] g = a & b;
    wire and_tree[0:2];
    genvar i;
    generate
        for (i = 0; i < 3; i = i + 1)
        begin: and_tree_gen
            
        end
    endgenerate
    
endmodule

// All new version 

