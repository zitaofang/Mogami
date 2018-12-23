`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/18 09:40:32
// Design Name: 
// Module Name: reservation_station
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


module reservation_station(
    input clk,
    // New instruction: Connected to ROB
    input new_inst,
    // src 1 port: connected to ROB
    input p1, // present flag
    input [63:0] src1, // data if the src reg is available; otherwise the lowest bits are the tag
    // src 2 port: connected to ROB
    input p2,
    input [63:0] src2,
    // Inter-FU bus (there are four buses): connected to all reservation station using daisy chain
    input [3:0] vb_request,
    output [4 * 64 - 1:0] vb_data_out,
    output [4 * 6 - 1:0] vb_tag_out,
    input [4 * 64 - 1:0] vb_data_in,
    input [4 * 6 - 1:0] vb_tag_in,
    // FU port
    output [63:0] op1,
    output [63:0] op2,
    input [63:0] res1,
    input [63:0] res2, // Some units, like multiplier and divider, has two outputs
    input busy,
    // Writeback bus: connected to ROB (also 4)
    input [3:0] wb_request,
    output [4 * 64 - 1:0] wb_data,
    output [4 * 6 - 1:0] wb_tag,
    // Error handling related
    output nmi,
    input kill
    );
endmodule

// The completion buffer
module completion_buffer(
    input clk,
    input kill,
    
    // FU output
    input fu_out, // To keep up with the bus request, it must come in one cycle before the data comes in
    input [63:0] fu_output1,
    input [63:0] fu_output2, // For some component (like M extension and some FP units), there are two output port
    input [8:0] inst_tag,
    
    // CDB 
    // Arbitration
    output bus_request, // Should be sent one cycle before using the cycle
    input bus_grant,
    // Data
    output [3:0] bus_en,
    output [6 * 4 - 1:0] bus_tag,
    output [64 * 4 - 1:0] bus_data
    );
    // Bus request buffer
    reg [3:0] bus_request_buf;
    // Buffer, four entries
    reg [63:0] out1_buf;
    
    // Arbitrate
    assign bus_request = bus_request_buf[0];
    
endmodule