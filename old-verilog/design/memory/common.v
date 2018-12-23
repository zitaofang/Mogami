`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/14 14:31:41
// Design Name: Mogami RISC-V CPU
// Module Name: common
// Project Name: Mogami
// Target Devices: 
// Tool Versions: 
// Description: A utility collection. See each module for more information.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Three-state buffer of arbitrary size. The built-in verilog three-state buffer only accept one
// bit input.
module control_buf #(parameter WIDTH = 64) (
    input [WIDTH - 1:0] in,
    output [WIDTH - 1:0] out,
    input control
);
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1)
        begin: cmos_gen
            bufif1 (out[i], in[i], control);
        end
    endgenerate
endmodule

// Clear all bits above the lowest set bit
module clear_high_bits(
    input [3:0] in,
    output [3:0] out
    );
    wire [3:0] tmp0 = {in[3] & ~in[2], in[2], in[1] & ~in[0], in[0]};
    wire [1:0] tmp1 = {in[3] | in[2], in[1] | in[0]};
    assign out = {tmp0[3:2] & {2{~tmp1[0]}}, tmp0[1:0]};
endmodule

// Set all bits above the lowset set bit
module set_high_bits(
    input [3:0] in,
    output [3:0] out
    );
    wire [3:0] tmp0 = {in[3] | in[2], in[2], in[1] | in[0], in[0]};
    wire [1:0] tmp1 = {in[3] | in[2], in[1] | in[0]};
    assign out = {tmp0[3:2] | {2{tmp1[0]}}, tmp0[1:0]};
endmodule
