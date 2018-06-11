`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/06 17:58:26
// Design Name: 
// Module Name: alu_test
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


module alu_test(
    output res
    );
    reg [63:0] a;
    reg [63:0] b;
    reg [63:0] r;
    wire [63:0] result;
    
    /*adder_lookahead add(
        .a(a),
        .b(b),
        .cin(0),
        .r(result)
    );*/
    /*multiplier mul(
        .sign(2'b11),
        .a(a),
        .b(b),
        .h(result[127:64]),
        .l(result[63:0])
    );
    initial begin
        a = 64'hffff_ffff_ffff_ffff;
        b = 64'hffff_ffff_ffff_ffff;
        r = {64'b0, a} * {64'b0, b};
    end*/
    
    initial begin
        a = 64'h0000_0000_ffff_ffff;
        b = 15;
        r = a >> b;
    end
    
    shifter test(
        .shift(b),
        .sl(1'b0),
        .extend_bit(1'b1),
        .in(a),
        .out(result)
    );
    
    assign res = result == r;
endmodule
