`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 15:38:45
// Design Name: 
// Module Name: FP_diff_shifter
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

/*
// +++++ Decoding part +++++
// Special value processing
wire [1:0] special_value_de;
assign special_value_de[62] = opcode[0] ? &exp_a[30:23] : &exp_a[62:52];
assign special_value_de[61] = special_value_de[62] ^ (opcode[0] ? |exp_a[22:0] : |exp_a[51:0]);

// denorm normalizing
wire is_denorm = opcode[0] ? |exp_a[30:23] : |exp_a[62:52];
*/

module normalizer(
    input [63:0] operand,
    // (Normal shifter)
    input shifter,
    input [5:0] shifter_bit,
    output [63:0] out,
    output [5:0] exp,
    output extra_shift
);
    genvar i, j;
    // "Inverse", it is actually negation. If the input is negative, it must be negated later.
    wire inverse = operand[63];
    
    // Inverse operand if it is negative
    wire [63:0] detector_in_a = operand ^ {64{operand[63]}};
    
    // We shift the operand to the right and check 0.
    wire [63:0] detector_in_b = {1'b0, operand[63:1]};
    
    // The tree
    generate
        for (i = 0; i < 6; i = i + 1)
        begin: tree_gen
            // Note: we count from the right to avoid inversion when shifting.
            // This means the location of MSB is 000000.
            // Detected if there is an 1 present in the pair.
            wire presence_of_1_a [2 ** (5 - i) - 1:0];
            // If an 1 present on the left subtree, append an 0 to the MSB, otherwise 1. 
            wire [i:0] left_1_val[2 ** (5 - i) - 1:0];
            // Detected if there is a 1 present in the pair of shifted version.
            wire presence_of_1_b [2 ** (5 - i) - 1:0];
            // If a 0 present on the left subtree, append an 0 to the MSB, otherwise 1. 
            wire [i:0] right_1_val[2 ** (5 - i) - 1:0];
            for (j = 0; j < 2 ** (5 - i); j = j + 1)
            begin: layer_gen
                if (i == 0) begin
                    assign presence_of_1_a[j] = detector_in_a[2 * j] | detector_in_a[2 * j + 1];
                    assign presence_of_1_b[j] = detector_in_b[2 * j] | detector_in_b[2 * j + 1];
                end else begin
                    assign presence_of_1_a[j] = tree_gen[i - 1].presence_of_1_a[2 * j + 1] |
                        tree_gen[i - 1].presence_of_1_a[2 * j];
                    assign left_1_val[j][i - 1:0] = tree_gen[i - 1].presence_of_1_a[2 * j + 1] ?
                        tree_gen[i - 1].left_1_val[2 * j + 1] :
                        tree_gen[i - 1].left_1_val[2 * j];
                    assign presence_of_1_b[j] = tree_gen[i - 1].presence_of_1_b[2 * j + 1] |
                        tree_gen[i - 1].presence_of_1_b[2 * j];
                    assign right_1_val[j][i - 1:0] = tree_gen[i - 1].presence_of_1_b[2 * j] ?
                        tree_gen[i - 1].right_1_val[2 * j + 1] :
                        tree_gen[i - 1].right_1_val[2 * j];
                end
                assign left_1_val[j][i] = j % 2 == 0;
                assign right_1_val[j][i] = j % 2 == 0;
            end 
        end
    endgenerate
    
    // Output the location of the most significant set bit as the shift bits
    wire [5:0] nor_shift_bit = tree_gen[5].left_1_val;
    
    // ============ The following part is concurrently executed with the shifter =============
    // If all bits to the right of the leftmost 0 of a negative number is 0, we will
    // shift back 1 bit (add 1 at the beginning, see "Finalize" for equivalent implementation).
    assign extra_shift = ~|(tree_gen[5].left_1_val ^ tree_gen[5].right_1_val);
    
    // ============== shifter ===============
    wire [63:0] shifter_out;
    shifter (
        .shift(shifter ? shifter_bit : nor_shift_bit),
        .sl(1'b1),
        .extend_bit(1'b0),
        .in(detector_in_a),
        .out(shifter_out)
    );
    
    // ============ Finalize =================
    // If it is negative and inverse, replace it with 0b100000...
    assign out[62:0] = {63{~(extra_shift & inverse) & ~shifter}} & shifter_out[62:0];
    assign out[63] = extra_shift & inverse & ~shifter | shifter_out[63];
    assign exp = nor_shift_bit;
endmodule