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
