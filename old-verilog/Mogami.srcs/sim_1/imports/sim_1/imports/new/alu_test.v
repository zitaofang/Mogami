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
    
    /*initial begin
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
    
    assign res = result == r;*/
    
    reg clk;
    always @ (clk) begin
        #10 clk <= ~clk;
    end
    
    initial begin
        a = 24'hA3E63B;
        r = a;
        clk = 1'b0;
    end
    
    wire [11:0] sign;
    wire [11:0] m2;
    wire [11:0] m1;
    wire [11:0] m0;
    tc2sd_24bit test(
        .in(a),
        .sign(sign),
        .m_2(m2),
        .m_1(m1),
        .m_0(m0)
    );
    
    wire [23:0] pos;
    wire [23:0] neg;
    wire [11:0] pos_2 = ~sign & m2;
    wire [11:0] pos_1 = ~sign & m1;
    wire [11:0] neg_2 = sign & m2;
    wire [11:0] neg_1 = sign & m1;
    generate
        genvar i;
        for (i = 0; i < 12; i = i + 1)
        begin: fuck
            assign pos[2 * i + 1] = pos_2[i];
            assign neg[2 * i + 1] = neg_2[i];
            assign pos[2 * i] = neg_1[i];
            assign neg[2 * i] = neg_1[i];
        end
    endgenerate
    
    configurable_adder #(.BIT(24)) aaa (
        .carry_in(1'b1),
        .a(pos),
        .b(~neg),
        .carry_out(),
        .sign_carry_in(),
        .r(result[23:0])
    );
    assign res = result[23:0] == a[23:0];
endmodule
