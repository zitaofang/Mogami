`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/01 18:12:43
// Design Name: 
// Module Name: integer_multiplier
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

// I copy the code from the fp divider which has be verified. 
// However, there are some differences:
// 1. the compensation follows the sign computation of the two operands and correct the matrix output
// to match the output sign.
// 2. "a" can be negative here. When this happens, negate it when we need to add a positive number - 
// adjust both the xor gate and the compensating bits.
module core_matrix(
    input out_sign,
    input a_negative,

    input [63:0] a,
    input [31:0] b_sign,
    input [31:0] b_m2,
    input [31:0] b_m0,
    output [63:0] lout_s,
    output [63:0] lout_c,
    output [63:0] hout_s,
    output [63:0] hout_c
    );
    
    // Unaligned Generation
    wire [65:0] unaligned_pp [0:31]; // partial products
    wire [31:0] negation_carry; // the carry-in for negated pp (they are nonzero only if negation is needed)
    wire [63:0] high_compensate; // Compensate if the highest sign bit of b does not equal to b's actual sign
    
    // Helper wire: negate the b_sign if a is negative (see the comments above the module declaration)
    wire [31:0] b_sign_negated = {32{a_negative}} ^ b_sign;
    generate
        genvar i;
        for (i = 0; i < 32; i = i + 1)
        begin: pp_gen
            wire [63:0] a_with_zero = a & {64{~b_m0[i]}};
            wire [65:0] raw_c2_pp = b_m2[i] ? {~b_sign[i], a_with_zero, 1'b0} : {~b_sign[i], 1'b0, a_with_zero};
            assign unaligned_pp[i] = raw_c2_pp ^ {1'b0, {65{b_sign_negated[i]}}};
            assign negation_carry[i] = b_sign_negated[i];
        end
    endgenerate
    // If the expected output sign does not match the highest bit sign given by the recoder, we need to compensate it.
    assign high_compensate = a & {64{out_sign ^ b_sign[31]}};
    
    // Tree arrange
    wire [127:0] pp_matrix [0:31];
    generate
        for (i = 0; i < 32; i = i + 1)
        begin: mat_gen
            assign pp_matrix[i][65 + 2 * i:2 * i] = unaligned_pp[i];
            if (i == 0) begin
                assign pp_matrix[0][66] = ~negation_carry[31];
                assign pp_matrix[0][67] = negation_carry[31];
                assign pp_matrix[0][68] = 0;
            end
        end
    endgenerate
    
    // Testing facility for the matrix itself
    
endmodule

module integer_multiplier(
    input [1:0] mode, // 00: unsigned; 01: b signed, a unsigned; 11: signed
    input [63:0] a,
    input [63:0] b,
    output [63:0] h,
    output [63:0] l
);
    
    // We handle the negative numbers in the following ways:
    // 1. "a" is negative. Notify the matrix that we have a negative a.
    // 2. "b" is negative. Inverse it and pass it to the recoder, and also add a carry-in
    // to the lowest bit. This will yield the correct redundant form.
    // Note that the sign logic is not on the critical path (it goes through the recoder)
    wire a_sign = a[63] & mode[0];
    wire b_sign = b[63] & mode[1];
    wire out_sign = a_sign ^ b_sign;
    
    wire [31:0] sign;
    wire [31:0] m2;
    wire [31:0] m0;
    wide_recoder recoder(
        .in(b ^ {64{b_sign}}), // Inverse b if it is negative
        .negative_in(b_sign),
        .sign(sign),
        .m2(m2),
        .m0(m0)
    );
    
    wire [63:0] out_s;
    wire [63:0] out_c;
    wire [63:0] out_hs;
    wire [63:0] out_hc;
    
    core_matrix matrix(
        .out_sign(out_sign),
        .a_negative(a_sign),
        .a(a),
        .b_sign(sign),
        .b_m2(m2),
        .b_m0(m0),
        .lout_s(out_s),
        .lout_c(out_c),
        .hout_s(out_hs),
        .hout_c(out_hc)
    );
endmodule

module wide_recoder(
    input [63:0] in,
    input negative_in,
    output [31:0] sign,
    output [31:0] m2,
    output [31:0] m0
);
    wire carry_int[0:64];
    assign carry_int[0] = negative_in;
    generate
        genvar i;
        for (i = 0; i < 64; i = i + 1)
        begin: cell_gen
            booth_recoder_2c booth(
                .b(in[2 * i + 1:2 * i]),
                .cin(carry_int[i]),
                .cout(carry_int[i + 1]),
                .sign(sign[i]),
                .m_0(m0[i]),
                .m_1(),
                .m_2(m2[i])
            );
        end
    endgenerate
endmodule

module multiplier_test();
    // test if the multiplier produce correct result
    
endmodule
