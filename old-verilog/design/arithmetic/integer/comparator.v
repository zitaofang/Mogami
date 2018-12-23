`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 15:38:45
// Design Name: Mogami RISC-V CPU
// Module Name: Comparator
// Project Name: Mogami
// Target Devices: 
// Tool Versions: 
// Description: The combination of integer and FP comparator. It is ready to be 
// connected to the reservation station.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// A improved module for fp comparation
// It accepts two raw fp.
// If any of the operands is NaN, fire an exception anyway. The control unit will
// decide whether or not to suppress the exception. But it will still output a 0.
// FEQ, FMIN and FMAX will suppress the exception. 
// FMIN and FMAX will ignore the output from this module if any of the operand is
// NaN. 
module fp_comparator (
    input int_comp,
    input is_s, // it means "single precision" or "signed integer". Just a flag.
    input [63:0] a,
    input [63:0] b,
    output lt,
    output eq,
    output exception
);
    // Integer comparison support
    wire int_sign_a = is_s ? b[63] : a[63];
    wire int_sign_b = is_s ? a[63] : b[63];

    // Left-aligned single precision
    wire [63:0] left_align_a = is_s & int_comp ? {a[31:0], 32'b0} : a;
    wire [63:0] left_align_b = is_s & int_comp ? {b[31:0], 32'b0} : b;

    // Detect NaN
    wire a_exp_1 = is_s ? &a[30:23] : &a[62:52];
    wire b_exp_1 = is_s ? &b[30:23] : &b[62:52];
    wire a_man_non_0 = is_s ? |a[22:0] : |a[51:0];
    wire b_man_non_0 = is_s ? |b[22:0] : |b[51:0];
    assign exception = int_comp & ((a_exp_1 & a_man_non_0) | (b_exp_1 & b_man_non_0));
    
    // Bit 63 will be compared concurrently with the rest
    // Detect 0: +0 == -0
    wire a_high = int_comp ? (left_align_a[63] & |left_align_a[62:0]) : int_sign_a;
    wire b_high = int_comp ? (left_align_b[63] & |left_align_b[62:0]) : int_sign_b;
    
    wire high_eq = ~(a_high ^ b_high);
    wire high_lt = ~a_high & b_high;
    
    // ++++++++++++++++++++++++++++++++++
    
    wire [63:0] a_aug = {1'b0, left_align_a[62:0]};
    wire [63:0] b_aug = {1'b0, left_align_b[62:0]};
    
    // Compare
    wire comp_lt;
    wire comp_eq;
    comparator(
        .a(a_aug),
        .b(b_aug),
        .sign(1'b1),
        .lt(comp_lt),
        .eq(comp_eq)
    );
    
    // wrap up
    assign lt = ~exception & high_lt & comp_lt;
    assign eq = ~exception & & high_eq & comp_eq;
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

// The component that follow the standard port.
module comparator_module(
    input [3:0] control,
    input [63:0] a,
    input [63:0] b,
    input enable, 
    input busy,
    output [63:0] o
);

endmodule