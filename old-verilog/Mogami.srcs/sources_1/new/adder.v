`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 15:38:45
// Design Name: Mogami RISC-V CPU
// Module Name: Adder
// Project Name: Mogami
// Target Devices: 
// Tool Versions: 
// Description: The full-length (64b) CLA. Used everywhere. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

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

module adder_lookahead_16b(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] r,
    output cout,
    output sign_cin,
    
    // FP extension
    output fp_exp_overflow
);
    // Lookahead
    wire gout; // Global g for cout calculation
    wire pout; // Global p for cout calculation
    wire [15:0] c_int; // carry for individual bits
    wire [15:0] g_int; // g for individual bits
    wire [15:0] p_int; // p for individual bits
    wire [3:0] g_int_0; // g for level 0 lookahead
    wire [3:0] p_int_0; // p for level 0 lookahead
    wire [3:0] c_int_0; // carry for level 0 lookahead
    generate
        genvar i, j;
        for (i = 0; i < 4; i = i + 1)
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
    endgenerate
    // Third
    lookahead lh_3(
        .pin(p_int_0),
        .gin(g_int_0),
        .cin(cin),
        .cout(c_int_0),
        .gout(gout),
        .pout(pout)
    );
    
    // add and assign
    assign g_int = a & b;
    assign p_int = a | b;
    assign r = a ^ b ^ c_int;
    assign sign_cin = c_int[15];
    assign cout = gout | (pout & cin);
    
    // FP Extension
    assign fp_exp_overflow = c_int[13] ^ c_int[12];
endmodule