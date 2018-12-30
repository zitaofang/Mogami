`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/17 21:55:02
// Design Name: 
// Module Name: regfile
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


module regfile(
    input [5:0] read_add1,
    input [5:0] read_add2,
    input [5:0] read_add3,
    input clk,
    input [5:0] write_add,
    input write_en,
    input [63:0] write_data,
    output [63:0] read_data1,
    output [63:0] read_data2,
    output [63:0] read_data3
    );
    reg [63:0] regs [0:63];
    assign read_data1 = regs[read_add1];
    assign read_data2 = regs[read_add2];
    assign read_data3 = regs[read_add3];
    always @ (posedge clk)
    begin
        if (write_en)
            regs[write_add] <= write_data;
    end
endmodule
