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
// This module is based on the following literature but with minor modification in 
// the Goldschmidt's algorithm part so that uops can be used:
//
// Pineiro JA, Bruguera JD. High-speed double-precision computation of reciprocal, division, square root, and inverse square root.
//     IEEE Transactions on Computers. 2002 Dec;51(12):1377-88.
//
//////////////////////////////////////////////////////////////////////////////////

// Use to extract parameter
`define par_ind(len, i) len * i: len * i + len - 1

module fq_sqrt_divider(
    input clk,
    input enable,
    output valid_out,
    
    input is_sqrt,
    input [51:0] op,
    output [29:0] out1,
    output [29:0] out2
);
    // Decode the input and get coefficients.
    wire [63:0] mem_out;
    dist_mem_gen_0 lut(.a({is_sqrt, op[51:43]}), .spo(mem_out));
    wire op_not_zero_wire = |op[51:43];
    
    // Decode the exponent and shift accordingly.
    // The shifting control code is one-hot. op_zero will control the c0 shifter directly and
    // do a left shift if 1.
    // C2 coefficient from 0x3fe to 0x3fb; two-staged shifter is sufficient.
    // C1 coefficient from 0x3fe to 0x3fc. Also use a two-staged shifter.
    // The LUT: (OFFSET FOR RIGHT SHIFT!)
    wire [3:0] exp_table [0:7];
    assign exp_table[0] = 10'b0000;
    assign exp_table[1] = 10'b0100;
    assign exp_table[2] = 10'b0101;
    assign exp_table[3] = 10'b1001;
    assign exp_table[4] = 10'b0101;
    assign exp_table[5] = 10'b1001;
    assign exp_table[6] = 10'b1101;
    assign exp_table[7] = 10'b1110;
    wire [1:0] c2_shift_wire = exp_table[{is_sqrt, mem_out[63:62]}][3:2];
    wire [1:0] c1_shift_wire = exp_table[{is_sqrt, mem_out[63:62]}][1:0];
    
    // Inverse the MSB.
    wire [29:0] c0_wire = mem_out[29:0];
    wire [19:0] c1_wire = mem_out[49:30];
    wire [11:0] c2_wire = mem_out[61:50];
    
    // Squaring unit
    wire [15:0] s_r;
    wire [15:0] s_c;
    square_16b sq(
        .in(op[42:27]),
        .out(s_r),
        .out_c(s_c)
    );
    // Convert square result to SD4
    wire [7:0] sq_sign_wire;
    wire [7:0] sq_m_2_wire;
    wire [7:0] sq_m_1_wire; // NOT USED
    wire [7:0] sq_m_0_wire;
    cs2sd_16bit sq_converter(
        .c(s_c),
        .s(s_r),
        .sign(sq_sign_wire),
        .m_2(sq_m_2_wire),
        .m_1(sq_m_1_wire),
        .m_0(sq_m_0_wire)
    );
    // Convert X_{2} to SD4
    wire [11:0] x2_sign_wire;
    wire [11:0] x2_m_2_wire;
    wire [11:0] x2_m_1_wire; // NOT USED
    wire [11:0] x2_m_0_wire;
    tc2sd_24bit x2_converter(
        .in(op[42:19]),
        .sign(x2_sign_wire),
        .m_2(x2_m_2_wire),
        .m_1(x2_m_1_wire),
        .m_0(x2_m_0_wire)
    );
    
    // ===================== PIPELINE STAGE ======================
    reg [29:0] c0;
    reg [19:0] c1;
    reg [11:0] c2;
    reg [7:0] sq_sign;
    reg [7:0] sq_m_2;
    reg [7:0] sq_m_0;
    reg [11:0] x2_sign;
    reg [11:0] x2_m_2;
    reg [11:0] x2_m_0;
    reg op_not_zero;
    reg [1:0] c2_shift;
    reg [1:0] c1_shift;
    reg stage0_valid;
    always @ (posedge clk) begin
        c0 <= c0_wire;
        c1 <= c1_wire;
        c2 <= c2_wire;
        sq_sign <= sq_sign_wire;
        sq_m_2 <= sq_m_2_wire;
        sq_m_0 <= sq_m_0_wire;
        x2_sign <= x2_sign_wire;
        x2_m_2 <= x2_m_2_wire;
        x2_m_0 <= x2_m_0_wire;
        op_not_zero <= op_not_zero_wire;
        c2_shift <= c2_shift_wire;
        c1_shift <= c1_shift_wire;
        stage0_valid <= enable;
    end
    
    // Unaligned Generation
    wire [21:0] unaligned_c1_pp [0:11];
    wire [13:0] unaligned_c2_pp [0:7];
    wire [11:0] negation_carry_c1; // The +1 part for negation; we don't calculate the +1 but
    wire [7:0] negation_carry_c2; // distribute them in the tree.
    generate
        genvar i;
        for (i = 0; i < 12; i = i + 1)
        begin: c1_pp_gen
            wire [19:0] c1_with_zero = c1 & {20{~x2_m_0[i]}};
            wire [21:0] raw_c1_pp = x2_m_2[i] ? {~x2_sign[i], c1_with_zero, 1'b0} : {~x2_sign[i], 1'b0, c1_with_zero};
            assign unaligned_c1_pp[i] = raw_c1_pp ^ {1'b0, {21{x2_sign[i]}}};
            assign negation_carry_c1[i] = x2_sign[i];
        end
        for (i = 0; i < 8; i = i + 1)
        begin: c2_pp_gen
            wire [11:0] c2_with_zero = c2 & {12{~sq_m_0[i]}};
            wire [13:0] raw_c2_pp = sq_m_2[i] ? {~sq_sign[i], c2_with_zero, 1'b0} : {~sq_sign[i], 1'b0, c2_with_zero};
            assign unaligned_c2_pp[i] = raw_c2_pp ^ {1'b0, {13{sq_sign[i]}}};
            assign negation_carry_c2[i] = sq_sign[i];
        end
    endgenerate
    
    // The accumulation matrices. It will be shifted before going into the main matrix.
    // The recoder sometimes produce negative MSB, which requires adding c2 to the value with 
    // c2 left aligned to the MSB.
    // Normally, we leave a sign bit as zero there so that this won't happen, but the space is limited in this case.
    wire [11:0] c2_compensate = c2 & {12{sq_sign[7]}};
    wire [27:0] c2_matrix [0:7];
    assign c2_matrix[0] = {11'b0, c2_compensate[0], negation_carry_c2[7], ~negation_carry_c2[7], unaligned_c2_pp[0]};
    assign c2_matrix[1] = {9'b0, c2_compensate[2:1], 1'b1, unaligned_c2_pp[1], 1'b0, negation_carry_c2[0]};
    assign c2_matrix[2] = {7'b0, c2_compensate[4:3], 1'b1, unaligned_c2_pp[2], 1'b0, negation_carry_c2[1], 2'b0};
    assign c2_matrix[3] = {5'b0, c2_compensate[6:5], 1'b1, unaligned_c2_pp[3], 1'b0, negation_carry_c2[2], 4'b0};
    assign c2_matrix[4] = {3'b0, c2_compensate[8:7], 1'b1, unaligned_c2_pp[4], 1'b0, negation_carry_c2[3], 6'b0};
    assign c2_matrix[5] = {1'b0, c2_compensate[10:9], 1'b1, unaligned_c2_pp[5], 1'b0, negation_carry_c2[4], 8'b0};
    assign c2_matrix[6] = {c2_compensate[11], 1'b1, unaligned_c2_pp[6], 1'b0, negation_carry_c2[5], 10'b0};
    assign c2_matrix[7] = {unaligned_c2_pp[7], 1'b1, negation_carry_c2[6], 12'b0};
    wire [19:0] c1_compensate = c1 & {20{x2_sign[11]}};
    wire [43:0] c1_matrix [0:11]; 
    assign c1_matrix[0] = {19'b0, c1_compensate[0], negation_carry_c1[11], ~negation_carry_c1[11], unaligned_c1_pp[0]};
    assign c1_matrix[1] = {17'b0, c1_compensate[2:1], 1'b1, unaligned_c1_pp[1], 1'b0, negation_carry_c1[0]};
    assign c1_matrix[2] = {15'b0, c1_compensate[4:3], 1'b1, unaligned_c1_pp[2], 1'b0, negation_carry_c1[1], 2'b0};
    assign c1_matrix[3] = {13'b0, c1_compensate[6:5], 1'b1, unaligned_c1_pp[3], 1'b0, negation_carry_c1[2], 4'b0};
    assign c1_matrix[4] = {11'b0, c1_compensate[8:7], 1'b1, unaligned_c1_pp[4], 1'b0, negation_carry_c1[3], 6'b0};
    assign c1_matrix[5] = {9'b0, c1_compensate[10:9], 1'b1, unaligned_c1_pp[5], 1'b0, negation_carry_c1[4], 8'b0};
    assign c1_matrix[6] = {7'b0, c1_compensate[12:11], 1'b1, unaligned_c1_pp[6], 1'b0, negation_carry_c1[5], 10'b0};
    assign c1_matrix[7] = {5'b0, c1_compensate[14:13], 1'b1, unaligned_c1_pp[7], 1'b0, negation_carry_c1[6], 12'b0};
    assign c1_matrix[8] = {3'b0, c1_compensate[16:15], 1'b1, unaligned_c1_pp[8], 1'b0, negation_carry_c1[7], 14'b0};
    assign c1_matrix[9] = {1'b0, c1_compensate[18:17], 1'b1, unaligned_c1_pp[9], 1'b0, negation_carry_c1[8], 16'b0};
    assign c1_matrix[10] = {c1_compensate[19], 1'b1, unaligned_c1_pp[10], 1'b0, negation_carry_c1[9], 18'b0};
    assign c1_matrix[11] = {unaligned_c1_pp[11], 1'b1, negation_carry_c1[10], 20'b0};
    wire [30:0] c0_matrix;
    assign c0_matrix = op_not_zero ? {1'b0, c0} : {c0, 1'b0};
    
    // The tree using CSA
    // These are the size of each csa, and padding
    parameter [0:7 * 6 - 1] L1_CSA_SIZE = {6'd24, 6'd26, 6'd23, 6'd31, 6'd33, 6'd33, 6'd30};
    parameter [0:7 * 6 - 1] L1_CSA_PADDING = {6'd26, 6'd20, 6'd17, 6'd25, 6'd19, 6'd13, 6'd10};
    parameter [0:4 * 6 - 1] L2_CSA_SIZE = {6'd30, 6'd29, 6'd38, 6'd37};
    parameter [0:4 * 6 - 1] L2_CSA_PADDING = {6'd20, 6'd17, 6'd18, 6'd9};
    parameter [0:2 * 6 - 1] L3_CSA_SIZE = {6'd41, 6'd47};
    parameter [0:2 * 6 - 1] L3_CSA_PADDING = {6'd9, 6'd9};
    wire [0:56] l1_big_matrix [0:20];
    wire [0:56] l2_big_matrix [0:13];
    wire [0:56] l3_big_matrix [0:7];
    wire [0:56] l4_big_matrix [0:3];
    wire [0:56] tree_out [0:1];
    generate
        // Assign the big matrix
        for (i = 0; i < 8; i = i + 1)
        begin: c2_assign
            // Shift according to the coefficient exponent.
            // Insert 1 to the left if this is the 8th c2 partial product so that the extra 1 can be correctly propagated.
            wire shift_in = i == 7 ? 1'b1 :1'b0;
            // 2b shift
            wire [30:0] c2_shift_int = c2_shift[1] ? {{2{shift_in}}, c2_matrix[i], 1'b0} : {c2_matrix[i], 3'b0};
            // 1b shift
            wire [30:0] c2_shifted = c2_shift[0] ? {shift_in, c2_shift_int[30:1]} : c2_shift_int;
            assign l1_big_matrix[i] = {19'b0, c2_shifted, 7'b0};
        end
        // C0 terms accumulated along with c2 terms, so put it here. In the first stage, only the lower 11 bits are added.
        // However, the bits 12 and 13 that is inserted into l2 matrix is extract from original l1 matrix, so we need to put in the full c0 term.
        // This is to simplify the selection of bits to insert since c2 and c0 terms will be shifted according to their coefficient exponent.
        // Also note that c0_matrix has been shifted, so we don't need to shift again here.
        assign l1_big_matrix[8] = {c0_matrix, 26'b0};
        for (i = 0; i < 12; i = i + 1)
        begin: c1_assign
            // 2b shift
            wire [46:0] c1_shift_int = c1_shift[1] ? {2'b0, c1_matrix[i], 1'b0} : {c1_matrix[i], 3'b0};
            // 1b shift
            wire [46:0] c1_shifted = c1_shift[0] ? {1'b0, c1_shift_int[46:1]} : c1_shift_int;
            assign l1_big_matrix[i + 9] = {10'b0, c1_shifted}; // Now the matrix index starts from 9 for c1 terms.
        end
    
        for (i = 0; i < 7; i = i + 1)
        begin: l1_csa
            // The wires that hold the output: we need to adjust it later
            wire [0:56] l1_out [0:1];
            csa #(.INPUT_SIZE(L1_CSA_SIZE[`par_ind(6, i)])) csa_1 
            (
                .a(l1_big_matrix[3 * i][L1_CSA_PADDING[`par_ind(6, i)]:L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)] - 1]),
                .b(l1_big_matrix[3 * i + 1][L1_CSA_PADDING[`par_ind(6, i)]:L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)] - 1]),
                .c(l1_big_matrix[3 * i + 2][L1_CSA_PADDING[`par_ind(6, i)]:L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)] - 1]),
                .cin(1'b0),
                .r(l1_out[0][L1_CSA_PADDING[`par_ind(6, i)] - 1:L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)] - 1]),
                .cout(l1_out[1][L1_CSA_PADDING[`par_ind(6, i)] - 1:L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)] - 1])
            );
            // Fill in unused bit (they will be optimized out anyway, but they will save some debugging time)
            // Just fill in 57 zeros; we just need them to be zero and don't care the zeros thrown away for unfitted ports
            assign l1_out[0][0:L1_CSA_PADDING[`par_ind(6, i)] - 2] = 57'b0;
            if ((L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)]) <= 56)
                assign l1_out[0][L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)]:56] = 57'b0;
            assign l1_out[1][0:L1_CSA_PADDING[`par_ind(6, i)] - 2] = 57'b0;
            if ((L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)]) <= 56)
                assign l1_out[1][L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)]:56] = 57'b0;
            assign l2_big_matrix[2 * i] = l1_out[0];
            assign l2_big_matrix[2 * i + 1] = l1_out[1];
        end
        
        // For level 2, both csa3 and csa4 exist; we need two loops for each of them.
        for (i = 0; i < 2; i = i + 1)
        begin: l2_csa_3
            wire [0:56] l2_out [0:1];
            csa #(.INPUT_SIZE(L2_CSA_SIZE[`par_ind(6, i)])) csa_2 
            (
                .a(l2_big_matrix[3 * i][L2_CSA_PADDING[`par_ind(6, i)]:L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)] - 1]),
                .b(l2_big_matrix[3 * i + 1][L2_CSA_PADDING[`par_ind(6, i)]:L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)] - 1]),
                .c(l2_big_matrix[3 * i + 2][L2_CSA_PADDING[`par_ind(6, i)]:L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)] - 1]),
                .cin(1'b0),
                .r(l2_out[0][L2_CSA_PADDING[`par_ind(6, i)] - 1:L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)] - 1]),
                .cout(l2_out[1][L2_CSA_PADDING[`par_ind(6, i)] - 1:L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)] - 1])
            );
            // Fill in unused bit (they will be optimized out anyway, but they will save some debugging time)
            // Just fill in 57 zeros; we just need them to be zero and don't care the zeros thrown away for unfitted ports
            assign l2_out[0][0:L2_CSA_PADDING[`par_ind(6, i)] - 2] = 57'b0;
            if ((L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)]) <= 56)
                assign l2_out[0][L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)] :56] = 57'b0;
            assign l2_out[1][0:L2_CSA_PADDING[`par_ind(6, i)] - 2] = 57'b0;
            if ((L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)]) <= 56)
                assign l2_out[1][L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)]:56] = 57'b0;
            // Insert 1s to propagate the extra bit.
            // For i == 0, insert at (Padding) - 2 and (Padding) - 3.
            // For i == 1, insert from (Padding) - 4 to (Padding) - 1 as fixed part. The sliding part is inserted to (Padding) - 5 and (Padding) - 6
            // Then, put the second part of c0 into it, from (Padding) - 7 to (Padding) - 1.
            if (i == 0) begin
                assign l3_big_matrix[2 * i][0:L2_CSA_PADDING[`par_ind(6, i)] - 4] = l2_out[0][0:L2_CSA_PADDING[`par_ind(6, i)] - 4];
                assign l3_big_matrix[2 * i][L2_CSA_PADDING[`par_ind(6, i)] - 3:L2_CSA_PADDING[`par_ind(6, i)] - 2] = 2'b11;
                assign l3_big_matrix[2 * i][L2_CSA_PADDING[`par_ind(6, i)] - 1:56] = l2_out[0][L2_CSA_PADDING[`par_ind(6, i)] - 1:56];
                assign l3_big_matrix[2 * i + 1] = l2_out[1];
            end else begin
                assign l3_big_matrix[2 * i][0:L2_CSA_PADDING[`par_ind(6, i)] - 8] = l2_out[0][0:L2_CSA_PADDING[`par_ind(6, i)] - 8];
                assign l3_big_matrix[2 * i][L2_CSA_PADDING[`par_ind(6, i)] - 7] = ~(c1_shift[1] | c1_shift[0]);
                assign l3_big_matrix[2 * i][L2_CSA_PADDING[`par_ind(6, i)] - 6] = ~c1_shift[1];
                assign l3_big_matrix[2 * i][L2_CSA_PADDING[`par_ind(6, i)] - 5:L2_CSA_PADDING[`par_ind(6, i)] - 1] = 5'h1f;
                assign l3_big_matrix[2 * i][L2_CSA_PADDING[`par_ind(6, i)]:56] = l2_out[0][L2_CSA_PADDING[`par_ind(6, i)]:56];
                assign l3_big_matrix[2 * i + 1][0:L2_CSA_PADDING[`par_ind(6, i)] - 8] = l2_out[1][0:L2_CSA_PADDING[`par_ind(6, i)] - 8];
                assign l3_big_matrix[2 * i + 1][L2_CSA_PADDING[`par_ind(6, i)] - 7:L2_CSA_PADDING[`par_ind(6, i)] - 1] 
                    = l1_big_matrix[8][L2_CSA_PADDING[`par_ind(6, i)] - 7:L2_CSA_PADDING[`par_ind(6, i)] - 1];
                assign l3_big_matrix[2 * i + 1][L2_CSA_PADDING[`par_ind(6, i)]:56] = l2_out[1][L2_CSA_PADDING[`par_ind(6, i)]:56];
            end
        end
        
        for (i = 0; i < 2; i = i + 1)
        begin: l2_csa_4
            wire [0:56] l2_out [0:1];
            wire carry_out [0:1];
            // The default csa4 don't have carry out (for it is designed to used in the last step of multiplication)
            // So we need to extend one bit
            csa4 #(.INPUT_SIZE(L2_CSA_SIZE[`par_ind(6, (i + 2))])) csa_2 
            (
                .a(l2_big_matrix[4 * i + 6][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .b(l2_big_matrix[4 * i + 7][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .c(l2_big_matrix[4 * i + 8][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .d(l2_big_matrix[4 * i + 9][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .cin(2'b0),
                .r(l2_out[0][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .cout(l2_out[1][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1])
            );
            // Fill in unused bit (they will be optimized out anyway, but they will save some debugging time)
            // Just fill in 57 zeros; we just need them to be zero and don't care the zeros thrown away for unfitted ports
            assign l2_out[0][0:L2_CSA_PADDING[`par_ind(6, (i + 2))] - 1] = 57'b0;
            if ((L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))]) <= 56)
                assign l2_out[0][L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))]:56] = 57'b0;
            assign l2_out[1][0:L2_CSA_PADDING[`par_ind(6, (i + 2))] - 1] = 57'b0;
            if ((L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))]) <= 56)
                assign l2_out[1][L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))]:56] = 57'b0;
            assign l3_big_matrix[2 * i + 4] = l2_out[0];
            assign l3_big_matrix[2 * i + 5] = l2_out[1];
        end
        
        for (i = 0; i < 2; i = i + 1)
        begin: l3_csa
            wire [0:56] l3_out [0:1];
            csa4 #(.INPUT_SIZE(L3_CSA_SIZE[`par_ind(6, i)])) csa_3 
            (
                .a(l3_big_matrix[4 * i][L3_CSA_PADDING[`par_ind(6, i)]:L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)] - 1]),
                .b(l3_big_matrix[4 * i + 1][L3_CSA_PADDING[`par_ind(6, i)]:L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)] - 1]),
                .c(l3_big_matrix[4 * i + 2][L3_CSA_PADDING[`par_ind(6, i)]:L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)] - 1]),
                .d(l3_big_matrix[4 * i + 3][L3_CSA_PADDING[`par_ind(6, i)]:L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)] - 1]),
                .cin(2'b0),
                .r(l3_out[0][L3_CSA_PADDING[`par_ind(6, i)]:L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)] - 1]),
                .cout(l3_out[1][L3_CSA_PADDING[`par_ind(6, i)]:L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)] - 1])
            );
            // Fill in unused bit (they will be optimized out anyway, but they will save some debugging time)
            // Just fill in 57 zeros; we just need them to be zero and don't care the zeros thrown away for unfitted ports
            assign l3_out[0][0:L3_CSA_PADDING[`par_ind(6, i)] - 1] = 57'b0;
            if ((L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)]) <= 56)
                assign l3_out[0][L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)]:56] = 57'b0;
            assign l3_out[1][0:L3_CSA_PADDING[`par_ind(6, i)] - 1] = 57'b0;
            if ((L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)]) <= 56)
                assign l3_out[1][L3_CSA_PADDING[`par_ind(6, i)] + L3_CSA_SIZE[`par_ind(6, i)]:56] = 57'b0;
            // Manipulate the output
            if (i == 0) begin
                // Fill c0 into (Padding). Just one bit.
                assign l4_big_matrix[0][0:L3_CSA_PADDING[`par_ind(6, 1)]] = l1_big_matrix[8][0:L3_CSA_PADDING[`par_ind(6, 1)]];
                assign l4_big_matrix[0][L3_CSA_PADDING[`par_ind(6, 1)] + 1:56] = l3_out[0][L3_CSA_PADDING[`par_ind(6, 1)] + 1:56];
                assign l4_big_matrix[1] = l3_out[1];
            end else begin
                assign l4_big_matrix[2] = ~l3_out[0];
                assign l4_big_matrix[3] = ~l3_out[1];
            end
        end
        
        // finish with a full-width csa
        csa4 #(.INPUT_SIZE(57)) csa_4 
        (
            .a(l4_big_matrix[0][0:56]),
            .b(l4_big_matrix[1][0:56]),
            .c(l4_big_matrix[2][0:56]),
            .d(l4_big_matrix[3][0:56]),
            .cin(2'b11),
            .r(tree_out[0]),
            .cout(tree_out[1])
        );
    endgenerate
    
    // The out register
    reg [29:0] out1_reg;
    reg [29:0] out2_reg;
    reg stage1_valid;
    always @ (posedge clk) begin
        out1_reg <= tree_out[0][0:29];
        out2_reg <= tree_out[1][0:29];
        stage1_valid <= stage0_valid;
    end
    
    assign valid_out = stage1_valid;
    assign out1 = out1_reg;
    assign out2 = out2_reg;
endmodule

module cs2sd_16bit(
    input [15:0] c,
    input [15:0] s,
    output [7:0] sign,
    output [7:0] m_2,
    output [7:0] m_1,
    output [7:0] m_0
);
    wire [16:0] augument_c = {c, 1'b0};
    wire [16:0] augument_s = {s, 1'b0};
    wire carry_int[0:8];
    assign carry_int[0] = 1'b0;
    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1)
        begin: cell_gen
            booth_recoder_cs recoder(
                .c(augument_c[2 * i + 2:2 * i]),
                .s(augument_s[2 * i + 2:2 * i]),
                .cin(carry_int[i]),
                .cout(carry_int[i + 1]),
                .sign(sign[i]),
                .m_0(m_0[i]),
                .m_1(m_1[i]),
                .m_2(m_2[i])
            );
        end
    endgenerate
endmodule

module tc2sd_24bit(
    input [23:0] in,
    output [11:0] sign,
    output [11:0] m_2,
    output [11:0] m_1,
    output [11:0] m_0
);
    wire carry_int[0:12];
    assign carry_int[0] = 1'b0;
    generate
        genvar i;
        for (i = 0; i < 12; i = i + 1)
        begin: cell_gen
            booth_recoder_2c booth(
                .b(in[2 * i + 1:2 * i]),
                .cin(carry_int[i]),
                .cout(carry_int[i + 1]),
                .sign(sign[i]),
                .m_0(m_0[i]),
                .m_1(m_1[i]),
                .m_2(m_2[i])
            );
        end
    endgenerate
endmodule

// 16 bit squaring unit for dividing unit
// This module has not been verified independently since the original paper
// are unclear toward some property (i.e. the location of the extra one).
// In the future, it should be noticed that this 
module square_16b(
    input [15:0] in,
    output [15:0] out,
    output [15:0] out_c
);
    // lower csr has 15 bit width, include the first three layer (see below for involving bits)
    wire [14:0] lower_csr_level1_op1 = {15{in[15]}} & in[14:0];
    wire [14:0] lower_csr_level1_op2 = {in[15], 1'b0, {13{in[14]}} & in[13:1]};
    wire [14:0] lower_csr_level1_op3 = {2'b0, in[14], 1'b0, {11{in[13]}} & in[12:2]};
    
    // middle csr has 11 bit width.
    wire [10:0] middle_csr_level1_op1 = {in[13], 1'b0, {9{in[12]}} & in[11:3]};
    wire [10:0] middle_csr_level1_op2 = {2'b0, in[12], 1'b0, {7{in[11]}} & in[10:4]};
    wire [10:0] middle_csr_level1_op3 = {4'b0, in[11], 1'b0, {5{in[10]}} & in[9:5]};
    
    // upper csr has 5 bit width
    wire [4:0] upper_csr_level1_op1 = {in[10], 1'b0, {3{in[9]}} & in[8:6]};
    wire [4:0] upper_csr_level1_op2 = {2'b0, in[9], 1'b1, in[8] & in[7]};
    wire [4:0] upper_csr_level1_op3 = {4'b0, in[8]};
    
    // second lower csr has 16 bit width
    wire [15:0] lower_csr_level2_op1;
    wire [15:0] lower_csr_level2_op2;
    wire [15:0] lower_csr_level2_op3;
    
    // second upper csr has 12 bit
    wire [11:0] upper_csr_level2_op1;
    wire [11:0] upper_csr_level2_op2;
    wire [11:0] upper_csr_level2_op3;
    
    // third csr has 16 bit, 4 input.
    wire [15:0] csr_level3_op1;
    wire [15:0] csr_level3_op2;
    wire [15:0] csr_level3_op3;
    wire [15:0] csr_level3_op4;
    
    csa #(.INPUT_SIZE(15)) csa_level1_lower (
        .a(lower_csr_level1_op1),
        .b(lower_csr_level1_op2),
        .c(lower_csr_level1_op3),
        .cin(1'b0),
        .cout(lower_csr_level2_op1),
        .r(lower_csr_level2_op2)
    );
    
    csa #(.INPUT_SIZE(11)) csa_level1_middle (
        .a(middle_csr_level1_op1),
        .b(middle_csr_level1_op2),
        .c(middle_csr_level1_op3),
        .cin(1'b0),
        .cout(lower_csr_level2_op3[11:0]),
        .r(upper_csr_level2_op1)
    );
    assign lower_csr_level2_op3[15:12] = 4'b0;
    
    csa #(.INPUT_SIZE(5)) csa_level1_upper (
        .a(upper_csr_level1_op1),
        .b(upper_csr_level1_op2),
        .c(upper_csr_level1_op3),
        .cin(1'b0),
        .cout(upper_csr_level2_op2[5:0]),
        .r(upper_csr_level2_op3[5:0])
    );
    assign upper_csr_level2_op2[11:6] = 6'b0;
    assign upper_csr_level2_op3[11:6] = 6'b0;
    
    wire [1:0] truncated_bit;
    csa #(.INPUT_SIZE(16)) csa_level2_lower (
        .a(lower_csr_level2_op1),
        .b(lower_csr_level2_op2),
        .c(lower_csr_level2_op3),
        .cin(1'b0),
        .cout({truncated_bit[1], csr_level3_op1}), // simply throw out bit 16 which is impossible to be 1
        .r({truncated_bit[0], csr_level3_op2})
    );
    
    csa #(.INPUT_SIZE(12)) csa_level2_upper (
        .a(upper_csr_level2_op1),
        .b(upper_csr_level2_op2),
        .c(upper_csr_level2_op3),
        .cin(1'b0),
        .cout(csr_level3_op3[12:0]),
        .r(csr_level3_op4[12:0])
    );
    assign csr_level3_op3[15:13] = 3'b0;
    assign csr_level3_op4[15:13] = 3'b0;
    
    csa4 #(.INPUT_SIZE(16)) csa_level3 (
        .a(csr_level3_op1),
        .b(csr_level3_op2),
        .c(csr_level3_op3),
        .d(csr_level3_op4),
        .cin(2'b0),
        .r(out),
        .cout(out_c)
    );
endmodule