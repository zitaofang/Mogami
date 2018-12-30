`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 15:38:45
// Design Name: 
// Module Name: FP_diff_shifter
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

// ============ New Multiplier Part ===============
// The new multiplier comprises three parts:
// 1. This part will process the exponent.
// 2. A normal multiplier will process the mantissa concurrently.
// 3. A common rounder.
// A new encoding is used here.
// TODO Fix this
module fp_mul_exp(
    input [63:0] a,
    input [63:0] b,
    output [63:0] r
);
    // If overflow, just pull it up to 2'b10
    // Special value process: (Vertical: A, Horizontal: B)
    //     00  01  10  11
    // 00  00  00  10  11
    // 01  00  01  11  11
    // 10  10  11  10  11
    // 11  11  11  11  11
    assign r[62] = (a[62] | b[62]) | (a[60] | b[60]);
    assign r[61] = ~(a[62] | a[61] | b[62]) | ~(a[62] | b[62] | b[61]) | ~(a[61] | b[61]) | ~(a[60] | b[60]);
    
    // Sign process
    assign r[63] = a[63] ^ b[63];
    
    // Add exp
    adder_lookahead_16b(
        .a({3'b0, a[12:0]}),
        .b({3'b0, b[12:0]}),
        .cin(1'b1),
        .r(r[12:0]),
        .cout(),
        .sign_cin(),
        .fp_exp_overflow(r[60])
    );
    
    assign r[59:12] = 48'b0;
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

// TODO Rewrite it with Booth, Add fused addition
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