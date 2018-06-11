`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2018 05:30:43 PM
// Design Name: 
// Module Name: common
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

module demux #(parameter CON_BIT = 1, parameter WIDTH = 64) (
    output [WIDTH * 2 ** CON_BIT - 1:0] out_bus,
    input [CON_BIT - 1:0] control,
    input [WIDTH - 1:0] in
);
    genvar i;
    generate
    for (i = 0; i < CON_BIT + 1; i = i + 1)
    begin: outer
        wire [WIDTH - 1:0] out_wire [2 ** (CON_BIT - i) - 1:0];
        genvar j;
        for (j = 0; j < 2 ** (CON_BIT - i); j = j + 1)
        begin: inner
            if (i == 0)
                assign out_bus[j * 64 + 63:j * 64] = out_wire[j];
            else begin
                assign outer[i - 1].out_wire[j * 2 + 1] = control[i - 1] ? out_wire[j] : 0;
                assign outer[i - 1].out_wire[j * 2] = control[i - 1] ?  0 : out_wire[j];
            end
        end
    end
    assign outer[CON_BIT].out_wire[0] = in;
    endgenerate  
endmodule

// SBS - find the most/least significant bit set
module sbs #(parameter OUT_BIT = 6, parameter IS_MSBS = 1) (
    input [2 ** OUT_BIT - 1:0] in,
    output [OUT_BIT - 1:0] out,
    output indeterminate
);
    wire [2 ** OUT_BIT - 1:0] int [0:OUT_BIT];
    assign int[OUT_BIT - 1] = in;
    assign indeterminate = int[0][0];
    generate
        genvar i, j;
        for (i = OUT_BIT - 1; i >= 0; i = i - 1)
        begin: outer
            wire [2 ** i - 1:0] res;
            for (j = 0; j < 2 ** i; j = j + 1)
            begin: inner
                assign int[i][j] = int[i + 1][2 * j] | int[i + 1][2 * j + 1];
                if(IS_MSBS)
                    assign res[j] = int[i + 1][2 * j + 1];
                else
                    assign res[j] = int[i + 1][2 * j];
            end
            assign out[i] = |res;
        end
    endgenerate
endmodule

// Clear high bits - clear all bits higher than the least significant 0
// parameter POWER: specific the width as 2 ** POWER.
// parameter SET: if SET == 1, set all bits higher/lower (see below) than the least/most significant
// 1; otherwise, clear all bits higher/lower than the least/most significant 0
// parameter HIGHER: if HIGHER == 1, use "higher" and "least" in the previous statement, vice versa.
// How this works (SET = 0, HIGHER = 1):
//  in[1]---------&--------out[1]
//               |
//              | 
//  in[0]------------------out[0]
module clear_bits_cell #(parameter POWER = 6, parameter SET = 1, parameter HIGHER = 1) (
    input [2 ** POWER - 1:0] in,
    output [2 ** POWER - 1:0] out
);
    generate
        if (POWER == 0)
            assign out = in;
        else begin
            wire [2 ** (POWER - 1) - 1:0] in_sub[0:1];
            wire [2 ** (POWER - 1) - 1:0] out_sub[0:1];
            assign in_sub[0] = in[2 ** (POWER - 1) - 1:0];
            assign in_sub[1] = in[2 ** POWER - 1:2 ** (POWER - 1)];
            assign out[2 ** (POWER - 1) - 1:0] = out_sub[0];
            assign out[2 ** POWER - 1:2 ** (POWER - 1)] = out_sub[1];
            
            wire [2 ** (POWER - 1) - 1:0] int;
            if(SET)
                assign int = in_sub[0] | in_sub[1];
            else
                assign int = in_sub[0] & in_sub[1];
                
            if (HIGHER) begin
                assign out_sub[0] = in_sub[0];
                assign out_sub[1] = int;
            end else begin
                assign out_sub[0] = int;
                assign out_sub[1] = in_sub[1];
            end
        end
    endgenerate
endmodule

module clear_bit #(parameter POWER = 6, parameter SET = 1, parameter HIGHER = 1) (
   input [2 ** POWER - 1:0] in,
   output [2 ** POWER - 1:0] out
);
    wire [2 ** POWER - 1:0] int[0:POWER];
    assign int[0] = in;
    assign out = int[POWER];
    
    generate
        genvar i, j;
        for (i = 0; i < POWER; i = i + 1)
        begin: outer
            for (j = 0; j < 2 ** (POWER - 1 - i); j = j + 1)
            begin: inner
                clear_bits_cell #(.POWER(i + 1), .SET(SET), .HIGHER(HIGHER)) (
                    .in(int[i][2 ** (i + 1) * (j + 1) - 1:2 ** (i + 1) * j]),
                    .out(int[i + 1][2 ** (i + 1) * (j + 1) - 1:2 ** (i + 1) * j])
                );
            end
        end
    endgenerate
endmodule

// reverse the index of a bus
module index_reverser #(WIDTH = 64) (
    input [WIDTH - 1:0] in,
    output [WIDTH - 1:0] out
);
    generate
        genvar i;
        for (i = 0; i < WIDTH; i = i + 1)
        begin: rev_gen
            assign out[WIDTH - i - 1] = in[i];
        end
    endgenerate
endmodule

// A fast adder for constant adding
module constant_1bit_adder #(parameter BIT = 64, parameter CONST_BIT = 0) (
    input [BIT - 1:0] a,
    output carry_out,
    output sign_carry_in,
    output [BIT - 1:0] r
);
    localparam level = log2(BIT);
    // Build an "and" tree
    generate
        genvar i, j;
        for (i = 0; i < level; i = i + 1)
        begin: outer
            localparam wire_count = BIT / (2 ** i);
            localparam extra_wire = BIT % (2 ** i) >= 2 ** (i - 1);
            // One more wire for the tail case
            wire int [0:wire_count + extra_wire - 1];
            for (j = 0; j < wire_count; j = j + 1)
            begin: inner
                if (i == 0)
                    assign int[j] = a[2 * j] & a[2 * j + 1];
                else
                    assign int[j] = outer[i - 1].int[2 * j] & outer[i - 1].int[2 * j + 1];
            end
            // tail case
            if (extra_wire)
                if (i == 0)
                    assign int[wire_count] = a[2 * wire_count];
                else
                    assign int[wire_count] = outer[i - 1].int[2 * wire_count];
        end
    endgenerate
    
    wire [BIT - 1:0] c;
    generate
        for (i = 0; i < BIT; i = i + 1)
        begin: gen_outer
            localparam [level:0] bit_extractor = i;
            wire [level - 1:0] and_list;
            for (j = 0; j < level; j = j + 1)
            begin: gen_inner
                if (bit_extractor[j])
                    // If the bit is set, include the right branch subtree in the and_list
                    if (j == level - 1)
                        assign and_list[j] = outer[j].int[0];
                    else
                        assign and_list[j] = outer[j].int[bit_extractor[level - 1:j + 1] * 2];
                else
                    // Otherwise, put an 1 to ignore it
                    assign and_list[j] = 1'b1;
            end
            // write a 1 into c[0] as the increment
            if (i)
                assign c[i]  = &and_list;
            else
                assign c[i] = 1'b1;
        end
    endgenerate
    
    assign r = a ^ c;
    assign carry_out = a[BIT - 1] & c[BIT - 1];
    assign sign_carry_in = c[BIT - 1];
endmodule

module canonic_adder #(parameter A_BIT = 64, parameter B_BIT = 1) (
    input [A_BIT - 1:0] a,
    input [B_BIT - 1:0] b,
    output [A_BIT - 1:0] res
);

endmodule