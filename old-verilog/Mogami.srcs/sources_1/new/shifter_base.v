`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 15:38:45
// Design Name: 
// Module Name: Shifter
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

module shifter_cell #(parameter level = 0) (
    input sl,
    input shift,
    input [2 ** level - 1:0] in,
    inout [2 ** level - 1:0] left_c,
    inout [2 ** level - 1:0] right_c,
    output [2 ** level - 1:0] out
    );
    wire [2 ** level - 1:0] left_c_out;
    wire [2 ** level - 1:0] right_c_out;
    assign out = shift ? (sl ? left_c : right_c) : in;
    control_buf #(.WIDTH(2 ** level)) to_right (.in(in), .out(right_c), .control(sl & shift));
    control_buf #(.WIDTH(2 ** level)) to_left (.in(in), .out(left_c), .control(~sl & shift));
endmodule

module single_shifter #(parameter level = 0) (
    input shift,
    input sl,
    input extend_bit,
    input [63:0] in,
    output [63:0] out
    );
    localparam wire_width = 2 ** level;
    localparam group_count = 2 ** (6 - level);
    
    wire [wire_width - 1:0] grouped_in[0:group_count - 1];
    wire [wire_width - 1:0] grouped_out[0:group_count - 1];
    wire [wire_width - 1:0] carry_int[0:group_count];

    generate
        genvar i, j;
        for (i = 0; i < group_count; i = i + 1)
        begin: grouping
            assign grouped_in[i] = in[(i + 1) * wire_width - 1:i * wire_width];
            assign out[(i + 1) * wire_width - 1:i * wire_width] = grouped_out[i];
        end
        
        for (j = 0; j < group_count; j = j + 1)
        begin: cell_gen
            shifter_cell #(.level(level)) the_cell (
                .sl(sl),
                .shift(shift),
                .in(grouped_in[j]),
                .left_c(carry_int[j]),
                .right_c(carry_int[j + 1]),
                .out(grouped_out[j])
            );    
        end
    endgenerate
    
    // Always move 0 in when shifting left
    control_buf #(.WIDTH(wire_width)) from_right (.in(0), .out(carry_int[0]), .control(sl));
    // Depends on the shift mode, move 1 or 0 in when shifting right
    control_buf #(.WIDTH(wire_width)) from_left (.in({(wire_width){extend_bit}}), .out(carry_int[group_count]), .control(~sl));
endmodule

module shifter #(parameter FP_EX = 1) (
    input [5:0] shift,
    input sl,
    input extend_bit,
    input [63:0] in,
    output [63:0] out,
    
    // FP Extension
    output sticky_all, // Treat guard and round as a part of the sticky bit generation
    output sticky,
    output guard,
    output round
);
    wire [63:0] intermediate [0:6];
    assign intermediate[6] = in;
    assign out = intermediate[0];
    genvar i;
    wire [5:0] shift_out_int;
    generate
        wire [1:0] guard_round_int[0:5];
        wire [5:0] sticky_int;
    
        for(i = 5; i >= 0; i = i - 1)
        begin: shifter_gen
            single_shifter #(.level(i)) shifter (.in(intermediate[i + 1]), .out(intermediate[i]),
                .shift(shift[i]), .sl(sl), .extend_bit(extend_bit));
                
            if (FP_EX) begin
                if (i == 0) begin
                    assign guard_round_int[i] = shift[i] ? {intermediate[i + 1][2 ** i - 1], guard_round_int[i + 1][1]}
                        : guard_round_int[i + 1];
                end else if (i == 5) begin
                    assign guard_round_int[i] = {2{shift[i]}} & intermediate[i + 1][2 ** i - 1:2 ** i - 2];
                end else begin
                    assign guard_round_int[i] = shift[i] ? intermediate[i + 1][2 ** i - 1:2 ** i - 2] : guard_round_int[i + 1];
                end
                
                if (i == 5) begin
                    assign sticky_int[i] = |intermediate[i + 1][2 ** i - 3:0] & shift[i];
                end else if (i == 2) begin
                    assign sticky_int[i] = |guard_round_int[i + 1] & shift[i];
                end else if (i == 1) begin
                    assign sticky_int[i] = guard_round_int[i + 1][0] & shift[i];
                end else begin
                    assign sticky_int[i] = |intermediate[i + 1][2 ** i - 3:0] | |guard_round_int[i + 1] & shift[i];
                end
            end
        end
        
        // FP Extension
        if (FP_EX) begin
             assign sticky = |sticky_int;
             assign sticky_all = |sticky_int | |guard_round_int[0];
             assign guard = guard_round_int[0][1];
             assign round = guard_round_int[0][0];
        end
    endgenerate
endmodule