`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 09:38:43
// Design Name: Mogami RISC-V CPU
// Module Name: RegFile
// Project Name: Mogami
// Target Devices: 
// Tool Versions: 
// Description: A multiport main register file.It provides more register entries 
// than required by the architecture to provide enough space for register renaming.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: This register file is based on the following literature:
// Tseng, Jessica H., and Krste Asanovic. "Banked multiported register files for high-frequency superscalar microprocessors.
//      " In Computer Architecture, 2003. Proceedings. 30th Annual International Symposium on, pp. 62-71. IEEE, 2003.
//////////////////////////////////////////////////////////////////////////////////


module RegFile(
    input clk,
    input write0En,
    input write1En,
    input write2En,
    input write3En,
    input [63:0] write0Data,
    input [63:0] write1Data,
    input [63:0] write2Data,
    input [63:0] write3Data,
    input [63:0] write0Addr,
    input [63:0] write1Addr,
    input [63:0] write2Addr,
    input [63:0] write3Addr,
    input [63:0] read0Addr,
    input [63:0] read1Addr,
    input [63:0] read2Addr,
    input [63:0] read3Addr,
    input [63:0] read4Addr,
    input [63:0] read5Addr,
    input [63:0] read6Addr,
    input [63:0] read7Addr,
    output [63:0] read0Data,
    output [63:0] read1Data,
    output [63:0] read2Data,
    output [63:0] read3Data,
    output [63:0] read4Data,
    output [63:0] read5Data,
    output [63:0] read6Data,
    output [63:0] read7Data
    );
    
    // I use the block memory IP (which is required by Xilinx to use the block RAM) as a bank.
    // The RAM has 2 cycles latency, so I need to pipeline the peripheral circuit. 
    
endmodule
