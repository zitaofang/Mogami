`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2018 08:43:44 PM
// Design Name: 
// Module Name: cache_test
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

module clock_gen(
    output clk
    );
    reg clock;
    always begin
        #10 clock = ~clock; 
    end
endmodule

module cache_test();
    integer counter;
    integer write_en[0:3];

    wire clk;
    wire[63:0] addr;
    reg [63:0] write_data;
    reg refilled;
    reg write_finish;
    clock_gen(.clk(clk));
    cache(.enable(1), .clk(clk), .addr(addr), .write_data(write_data), .refilled(refilled),
        .write_finish(write_finish)); 
    initial begin
        
    end
endmodule
