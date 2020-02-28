`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/19 15:56:59
// Design Name: 
// Module Name: fp_dvsq_test
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

// Use to extract parameter
`define par_ind(len, i) len * i: len * i + len - 1

// The overflow correction constant - add it to the result matrix to correct overflow 


// A util function that normailize the number
class normalize_wrapper #(parameter SIZE = 24);
    static function int normalize_function(input bit [SIZE-1:0] in);
        automatic int exp = 0;
        automatic bit [SIZE-1:0] in_copy = in;
        for (int i = 0; i < SIZE; i++)
        begin
            if (in_copy[SIZE-1])
                break;
            in_copy <<= 1;
            exp++;
        end
        return exp;
    endfunction
endclass

// The collection of tasks that reproduce real values from the bits
// Note: the data from the LUT has a leading one that needed to be removed: that's
// why we take one bit away. 
// Also, the c2 and c1 have their MSB inversed, but it doesn't matter here 
// since they are thrown away.
function real tree_out_to_real(input bit [56:0] in);
    bit [63:0] tree_out;
    bit [56:0] tree_man;
    int tree_exp;
    tree_exp = normalize_wrapper#(57)::normalize_function(in);
    tree_man = in << tree_exp;
    tree_out[63:52] = 12'h3ff - tree_exp;
    tree_out[51:0] = tree_man[55:4];
    return $bitstoreal(tree_out);
endfunction
function real c2_to_real(input bit [11:0] c2, input bit [1:0] c2_off);
    bit [63:0] c2_recovered;
    c2_recovered[63:52] = 12'h3fe - c2_off;
    c2_recovered[51:41] = c2[10:0];
    c2_recovered[40:0] = 41'b0;
    return $bitstoreal(c2_recovered);
endfunction
function real c1_to_real(input bit [19:0] c1, input bit [1:0] c1_off);
    bit [63:0] c1_recovered;
    c1_recovered[63:52] = 12'hbfe - c1_off;
    c1_recovered[51:33] = c1[18:0];
    c1_recovered[32:0] = 33'b0;
    return $bitstoreal(c1_recovered);
endfunction
function real c0_to_real(input bit [29:0] c0, input bit c0_off);
    bit [63:0] c0_recovered;
    c0_recovered[63:52] = 12'h3ff - c0_off;
    c0_recovered[51:23] = c0[28:0];
    c0_recovered[22:0] = 23'b0;
    return $bitstoreal(c0_recovered);
endfunction
function real x2_sq_to_real(input bit [15:0] x2_sq);
    bit [63:0] x2_sq_recovered;
    bit [15:0] x2_sq_man;
    int x2_sq_exp;
    x2_sq_exp = normalize_wrapper#(16)::normalize_function(x2_sq);
    x2_sq_man = x2_sq << x2_sq_exp;
    x2_sq_recovered[63:52] = 12'h3eb - x2_sq_exp;
    x2_sq_recovered[51:37] = x2_sq_man[14:0];
    x2_sq_recovered[36:0] = 37'b0;
    return $bitstoreal(x2_sq_recovered);
endfunction
function real x2_to_real(input bit [23:0] x2);
    bit [63:0] x2_recovered;
    bit [23:0] x2_man;
    int x2_exp;
    x2_exp = normalize_wrapper#(24)::normalize_function(x2);
    x2_man = x2 << x2_exp;
    x2_recovered[63:52] = 12'h3f5 - x2_exp;
    x2_recovered[51:29] = x2_man[22:0];
    x2_recovered[28:0] = 28'b0;
    return $bitstoreal(x2_recovered);
endfunction
// Round full-length x2 ** 2
function real round_x2_sq(input real x2_sq);
    // round to 16 bits
    bit [63:0] sq_bit;
    bit [63:0] tmp;
    int exp;
    sq_bit = $realtobits(x2_sq);
    
    exp = 12'h3ec - sq_bit[63:52];
    tmp[63:52] = sq_bit[63:52];
    tmp[51:0] = ((sq_bit[51:0] >> exp) & {~15'b0, 37'b0}) << exp;
    
    /*
    tmp[63:36] = sq_bit[63:36];
    tmp[35:0] = 36'b0;
    */
    
    return $bitstoreal(tmp);
endfunction
// Goldschmidt's simulator
function real goldschmidt(input bit mode, input real in, input real tree_out);
    if (mode)  // inv sqrt
        return (1.0 - tree_out * tree_out * in) * tree_out / 2.0 + tree_out;
    else // recip
        return (1.0 - tree_out * in) * tree_out + tree_out;
endfunction

// function that calculate the value through real operation
task verify_table(input bit [11:0] c2, input bit [19:0] c1, input bit [29:0] c0,
    input bit [1:0] c2_off, input bit [1:0] c1_off, input bit c0_off,
    input bit [15:0] x2_sq, input bit [23:0] x2, input bit [51:0] op,
    input bit [56:0] aligned_accumulated_res, input bit [15:0] x2_sq_naive, input bit [56:0] test_result);
    real op_real;
    real res;
    // Product Using full length square
    real full_length_res;
    // The inverse of input
    real expected;
    // final result
    //real final_res;
    // A variable holding some random value
    real tmp;
    
    // result bit conversion
    bit [63:0] result_fp_form;
    int result_exp;
    bit [56:0] result_man;
    
    // Calculate the number
    res = x2_sq_to_real(x2_sq_naive) * c2_to_real(c2, c2_off) + 
        x2_to_real(x2) * c1_to_real(c1, c1_off) + 
        c0_to_real(c0, c0_off);
    full_length_res = round_x2_sq(x2_to_real({x2[23:8], 8'b0}) ** 2) * c2_to_real(c2, c2_off) + 
                x2_to_real(x2) * c1_to_real(c1, c1_off) + 
                c0_to_real(c0, c0_off);
    op_real = $bitstoreal({12'h3ff, op});
    expected = 1.0 / $sqrt(op_real);
    //$write("Table verification result: %f\n", res);
    $write("expected: %x; full length res: %x; res: %x\n", $realtobits(expected), $realtobits(full_length_res), 
    $realtobits(res));
    
    // Test the result
    result_exp = normalize_wrapper#(57)::normalize_function(aligned_accumulated_res);
    result_man = aligned_accumulated_res << result_exp;
    result_fp_form[63:52] = 12'h3ff - result_exp;
    result_fp_form[51:0] = result_man[55:4];
    if (res != result_fp_form)
        $write("Table verification for aligned accumulated failed: got %x\n", result_fp_form);
    
    // Testing statement for full-length calculation
    //res = full_length_res;
    // cut away some bits
    
    
    // This is...really weird. Let's check if the model in the paper is coorect.
    // It is correct, but a complete 24*24 matrix is too expensive. We will run the Goldschmidt twice instead.
    /*res = (1.0 - res * op_real) * res + res;
    final_res = (1.0 - res * op_real) * res + res;*/
    //res = (1.0 - res * res * op_real) * res / 2.0 + res;
    /*final_res = (1.0 - res * res * op_real) * res / 2.0 + res;
    $write("final res: %x, tree res:%x\n", $realtobits(final_res), test_result);*/
endtask

// Verify the accumulation tree
// We will only verify the C2 term now. If it produce the correct result, apply the 
// similar technique to C1 term.
task verify_tree_c2(input bit [11:0] c2, input bit [1:0] c2_off,
    input bit [15:0] x2_sq, input [56:0] c2_term_res);
    real expected;
    real got;
    bit [63:0] expected_bits;
    int c2_term_exp;
    bit [63:0] c2_fp_encoding;
    bit [56:0] c2_term_man;
    /*
    bit [63:0] debug_x2_sq;
    debug_x2_sq = $realtobits(x2_sq_to_real(x2_sq));
    */
    expected = x2_sq_to_real(x2_sq) * c2_to_real(c2, c2_off);
    expected_bits = $realtobits(expected);
    c2_term_exp = normalize_wrapper#(57)::normalize_function(c2_term_res);
    c2_term_man = c2_term_res << c2_term_exp;
    c2_fp_encoding[63:52] = 12'h3ff - c2_term_exp;
    c2_fp_encoding[51:0] = c2_term_man[55:4];
    got = $bitstoreal(c2_fp_encoding);
    if (c2_fp_encoding != /* == */ expected_bits) begin
        /*
        $write("x2_sq: %x, x2_sq_raw:%x\n", debug_x2_sq, x2_sq);
        */
        $write("C2 Tree Verification failed: expected %x, got %x\n", expected_bits, c2_fp_encoding);
        $write("c2_term_exp: %d; c2_term_res:%x\n", c2_term_exp, c2_term_res);
    end
endtask
task verify_tree_c1(input bit [19:0] c1, input bit [1:0] c1_off,
    input bit [23:0] x2, input [56:0] c1_term_res);
    real expected;
    real got;
    bit [63:0] expected_bits;
    int c1_term_exp;
    bit [63:0] c1_fp_encoding;
    bit [56:0] c1_term_man;
    expected = x2_to_real(x2) * c1_to_real(c1, c1_off);
    expected_bits = $realtobits(expected);
    c1_term_exp = normalize_wrapper#(57)::normalize_function(c1_term_res);
    c1_term_man = c1_term_res << c1_term_exp;
    c1_fp_encoding[63:52] = 12'hbff - c1_term_exp;
    c1_fp_encoding[51:0] = c1_term_man[55:4];
    got = $bitstoreal(c1_fp_encoding);
    if (c1_fp_encoding != expected_bits) begin
        $write("C1 Tree Verification failed: expected %x, got %x\n", expected_bits, c1_fp_encoding);
        $write("c1_term_exp: %d; c1_term_res:%x\n", c1_term_exp, c1_term_res);
    end
endtask
task verify_tree_c0(input bit [29:0] c0, input bit c0_off,
    input [56:0] c0_term_res);
    real expected;
    real got;
    bit [63:0] expected_bits;
    int c0_term_exp;
    bit [63:0] c0_fp_encoding;
    bit [56:0] c0_term_man;
    expected = c0_to_real(c0, c0_off);
    expected_bits = $realtobits(expected);
    c0_term_exp = normalize_wrapper#(57)::normalize_function(c0_term_res);
    c0_term_man = c0_term_res << c0_term_exp;
    c0_fp_encoding[63:52] = 12'h3ff - c0_term_exp;
    c0_fp_encoding[51:0] = c0_term_man[55:4];
    got = $bitstoreal(c0_fp_encoding);
    if (c0_fp_encoding != expected_bits) begin
        $write("C0 Tree Verification failed: expected %x, got %x\n", expected_bits, c0_fp_encoding);
        $write("c0_term_exp: %d; c0_term_res:%x\n", c0_term_exp, c0_term_res);
    end
endtask

// Verify the accumulation tree, with no alignment (so that the tree itself can be tested)
// We will only verify the C2 term now. If it produce the correct result, apply the 
// similar technique to C1 term.
task verify_tree_unaligned_c2(input bit [11:0] c2,
    input bit [15:0] x2_sq, input [27:0] c2_term_res);
    bit [27:0] expected;
    expected = c2 * x2_sq;
    if (c2_term_res != expected)
        $write("Unaligned Tree Verification failed: expected %x, got %x\n", expected, c2_term_res);
endtask
task verify_tree_unaligned_c1(input bit [19:0] c1,
    input bit [23:0] x2, input bit [43:0] c1_term_res);
    bit [43:0] expected;
    expected = c1 * x2;
    if (c1_term_res != expected)
        $write("Unaligned Tree Verification failed: expected %x, got %x\n", expected, c1_term_res);
endtask

// Test the tree accumulation 
module acc_tree_test(
    input is_sqrt,
    input [51:0] op,
    output [29:0] out,
    
    input clk, // For table testing
    input halt
);
    // Decode the input and get coefficients.
    wire [63:0] mem_out;
    dist_mem_gen_0 lut(.a({is_sqrt, op[51:43]}), .spo(mem_out));
    wire op_not_zero = |op[51:43];
    
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
    wire [1:0] c2_shift = exp_table[{is_sqrt, mem_out[63:62]}][3:2];
    wire [1:0] c1_shift = exp_table[{is_sqrt, mem_out[63:62]}][1:0];
    
    // Inverse the MSB.
    wire [29:0] c0 = mem_out[29:0];
    wire [19:0] c1 = mem_out[49:30];
    wire [11:0] c2 = mem_out[61:50];
    
    // Squaring unit
    wire [15:0] s_r;
    wire [15:0] s_c;
    square_16b sq(
        .in(op[42:27]),
        .out(s_r),
        .out_c(s_c)
    );
    // Convert square result to SD4
    wire [7:0] sq_sign;
    wire [7:0] sq_m_2;
    wire [7:0] sq_m_1;
    wire [7:0] sq_m_0;
    cs2sd_16bit sq_converter(
        .c(s_c),
        .s(s_r),
        .sign(sq_sign),
        .m_2(sq_m_2),
        .m_1(sq_m_1),
        .m_0(sq_m_0)
    );/*
    wire [31:0] sq_sim = op[42:27] * op[42:27];
    cs2sd_16bit sq_converter(
        .c(16'b0),
        .s(sq_sim[31:16]),
        .sign(sq_sign),
        .m_2(sq_m_2),
        .m_1(sq_m_1),
        .m_0(sq_m_0)
    );*/
    // Convert X_{2} to SD4
    wire [11:0] x2_sign;
    wire [11:0] x2_m_2;
    wire [11:0] x2_m_1;
    wire [11:0] x2_m_0;
    tc2sd_24bit x2_converter(
        .in(op[42:19]),
        .sign(x2_sign),
        .m_2(x2_m_2),
        .m_1(x2_m_1),
        .m_0(x2_m_0)
    );
    
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
    
    // Testing facility
    // Naive squaring test
    wire [15:0] naive_out;
    suqaring_naive_sum naive(
        .in(op[42:27]),
        .out(naive_out)
    );
    // =========== C2 Accumulation =============
    wire [27:0] unaligned_tmp_c2 [0:8];
    assign unaligned_tmp_c2[0] = 28'b0;
    generate
        for (i = 0; i < 8; i = i + 1)
        begin: unaligned_c2_tree_test
            assign unaligned_tmp_c2[i + 1] = unaligned_tmp_c2[i] + c2_matrix[i];
        end
    endgenerate
    // POSITION test
    // 2b shift
    wire [30:0] c2_shift_int = c2_shift[1] ? {2'b0, unaligned_tmp_c2[8], 1'b0} : {unaligned_tmp_c2[8], 3'b0};
    // 1b shift
    wire [30:0] c2_position_test = c2_shift[0] ? {1'b0, c2_shift_int[30:1]} : c2_shift_int;
    // =========== C1 Accumulation =============
    wire [43:0] unaligned_tmp_c1 [0:12];
    assign unaligned_tmp_c1[0] = 44'b0;
    generate
        for (i = 0; i < 12; i = i + 1)
        begin: unaligned_c1_tree_test
            assign unaligned_tmp_c1[i + 1] = unaligned_tmp_c1[i] + c1_matrix[i];
        end
    endgenerate
    // POSITION test
    // 2b shift
    wire [46:0] c1_shift_int = c1_shift[1] ? {2'b0, unaligned_tmp_c1[12], 1'b0} : {unaligned_tmp_c1[12], 3'b0};
    // 1b shift
    wire [46:0] c1_position_test = c1_shift[0] ? {1'b0, c1_shift_int[46:1]} : c1_shift_int;
    
    wire [56:0] aligned_accumulated_res = {19'b0, c2_position_test, 7'b0} - {10'b0, c1_position_test} + {c0_matrix, 26'b0};
    // END Testing facility
    
    // The tree using CSA
    // WARNING: COPIED CODE! CHANGE NOTHING OR CHANGE ALL!
    // These are the size of each csa, and padding means 
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
                .r(l1_out[0][L1_CSA_PADDING[`par_ind(6, i)] - 2:L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)] - 1]),
                .cout(l1_out[1][L1_CSA_PADDING[`par_ind(6, i)] - 2:L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)] - 1])
            );
            // Fill in unused bit (they will be optimized out anyway, but they will save some debugging time)
            // Just fill in 57 zeros; we just need them to be zero and don't care the zeros thrown away for unfitted ports
            assign l1_out[0][0:L1_CSA_PADDING[`par_ind(6, i)] - 2] = 57'b0;
            if ((L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)]) <= 56)
                assign l1_out[0][L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)]:56] = 57'b0;
            assign l1_out[1][0:L1_CSA_PADDING[`par_ind(6, i)] - 2] = 57'b0;
            if ((L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)]) <= 56)
                assign l1_out[1][L1_CSA_PADDING[`par_ind(6, i)] + L1_CSA_SIZE[`par_ind(6, i)]:56] = 57'b0;
            // Inject c0[12] into the matrix and assign the temporary l1_out to the actual matrix. It is extracted from c1.
            /*if (i == 2) begin
                assign l2_big_matrix[2 * i][0:L1_CSA_PADDING[`par_ind(6, i)] - 1] = l1_out[0][0:L1_CSA_PADDING[`par_ind(6, i)] - 1];
                assign l2_big_matrix[2 * i][L1_CSA_PADDING[`par_ind(6, i)]] = l1_big_matrix[8][L1_CSA_PADDING[`par_ind(6, i)]];
                assign l2_big_matrix[2 * i][L1_CSA_PADDING[`par_ind(6, i)] + 1:56] = l1_out[0][L1_CSA_PADDING[`par_ind(6, i)] + 1:56];
            end else*/
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
                .r(l2_out[0][L2_CSA_PADDING[`par_ind(6, i)] - 2:L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)] - 1]),
                .cout(l2_out[1][L2_CSA_PADDING[`par_ind(6, i)] - 2:L2_CSA_PADDING[`par_ind(6, i)] + L2_CSA_SIZE[`par_ind(6, i)] - 1])
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
            csa4 #(.INPUT_SIZE(L2_CSA_SIZE[`par_ind(6, (i + 2))] + 1)) csa_2 
            (
                .a(l2_big_matrix[4 * i + 6][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .b(l2_big_matrix[4 * i + 7][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .c(l2_big_matrix[4 * i + 8][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .d(l2_big_matrix[4 * i + 9][L2_CSA_PADDING[`par_ind(6, (i + 2))]:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .cin(2'b0),
                .r(l2_out[0][L2_CSA_PADDING[`par_ind(6, (i + 2))] - 1:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1]),
                .cout(l2_out[1][L2_CSA_PADDING[`par_ind(6, (i + 2))] - 1:L2_CSA_PADDING[`par_ind(6, (i + 2))] + L2_CSA_SIZE[`par_ind(6, (i + 2))] - 1])
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
                //assign l4_big_matrix[0][0:L3_CSA_PADDING[`par_ind(6, 1)] - 1] = l3_out[0][0:L3_CSA_PADDING[`par_ind(6, 1)] - 1];
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
        // Fill in unused bit (they will be optimized out anyway, but they will save some debugging time)
        // Just fill in 57 zeros; we just need them to be zero and don't care the zeros thrown away for unfitted ports
        // For tree_out[0], put the rest of the c0 term in
        /*assign tree_out[0][0:L4_CSA_PADDING] = l1_big_matrix[8][0:L4_CSA_PADDING];
        if ((L4_CSA_PADDING + L4_CSA_SIZE) <= 56)
            assign tree_out[0][L4_CSA_PADDING + L4_CSA_SIZE:56] = 57'b0;
        // Fill in 1s here as the higher sign bits
        assign tree_out[1][0:L4_CSA_PADDING - 1] = {L4_CSA_PADDING{1'b0}};
        if ((L4_CSA_PADDING + L4_CSA_SIZE) <= 56)
            assign tree_out[1][L4_CSA_PADDING + L4_CSA_SIZE:56] = 57'b0;*/
    endgenerate
    
    // Debugging used: Remove after problem is solved. (CSA DEBUG)
    // Here we test the output of first level csa, c1 term.
    generate
        wire [1:0] c1_oneshift = 2'b11 << (2 - c1_shift);
    
        wire [56:0] csa_test_c2_level1 [0:6];
        assign csa_test_c2_level1[0] = {l1_big_matrix[8][0:16], 40'b0} + {{19{1'b1}}, 38'b0};
        for (i = 0; i < 6; i = i + 1)
        begin: csa_test_level1_loop2
            assign csa_test_c2_level1[i + 1] = csa_test_c2_level1[i] + l2_big_matrix[i];
        end
        wire [56:0] csa_test_c2_level2 [0:4];
        assign csa_test_c2_level2[0] = {l1_big_matrix[8][0:9], 47'b0} + {{10{1'b1}}, ~(2'b11 >> c1_shift), 45'b0};
        for (i = 0; i < 4; i = i + 1)
        begin: csa_test_level2_loop2
            assign csa_test_c2_level2[i + 1] = csa_test_c2_level2[i] + l3_big_matrix[i];
        end
        wire [56:0] csa_test_c2_level3 [0:2];
        assign csa_test_c2_level3[0] = {l1_big_matrix[8][0:8], 48'b0} + {{10{1'b1}}, ~(2'b11 >> c1_shift), 45'b0};
        for (i = 0; i < 2; i = i + 1)
        begin: csa_test_level3_loop2
            assign csa_test_c2_level3[i + 1] = csa_test_c2_level3[i] + l4_big_matrix[i];
        end
        
        wire [56:0] csa_test_c1_level1 [0:8];
        assign csa_test_c1_level1[0] = {~10'b0, c1_oneshift, 45'b0};
        for (i = 0; i < 8; i = i + 1)
        begin: csa_test_level1_loop1
            assign csa_test_c1_level1[i + 1] = csa_test_c1_level1[i] + l2_big_matrix[i + 6];
        end
        wire [56:0] csa_test_c1_level2 [0:4];
        assign csa_test_c1_level2[0] = {~10'b0, c1_oneshift, 45'b0};
        for (i = 0; i < 4; i = i + 1)
        begin: csa_test_level2_loop1
            assign csa_test_c1_level2[i + 1] = csa_test_c1_level2[i] + l3_big_matrix[i + 4];
        end
    endgenerate
    // Test the entire matrix
    // WARNING: disable C2[8] extension before enabling this
    generate
        wire [56:0] c2_mat_sum [0:8];
        assign c2_mat_sum[0] = {{19{1'b1}}, 38'b0};
        for (i = 0; i < 8; i = i + 1)
        begin: great_c2
            assign c2_mat_sum[i + 1] = c2_mat_sum[i] + l1_big_matrix[i];
        end
        wire [56:0] c1_mat_sum [0:12];
        assign c1_mat_sum[0] = {{10{1'b1}}, c1_oneshift, 45'b0};
        for (i = 0; i < 12; i = i + 1)
        begin: great_c1
            assign c1_mat_sum[i + 1] = c1_mat_sum[i] + l1_big_matrix[i + 9];
        end
        wire [56:0] mat_sum = c2_mat_sum[8] - c1_mat_sum[12] + l1_big_matrix[8];
        
        // The test sum of l3 matrix
        wire [56:0] l3_mat_sum [0:8];
        assign l3_mat_sum[0] = {l1_big_matrix[8][0:9], 47'b0};
        for (i = 0; i < 8; i = i + 1)
        begin: great_l3
            if (i < 4) assign l3_mat_sum[i + 1] = l3_mat_sum[i] + l3_big_matrix[i];
            else assign l3_mat_sum[i + 1] = l3_mat_sum[i] - l3_big_matrix[i];
        end
        wire [56:0] l4_mat_sum [0:4];
        assign l4_mat_sum[0] = {l1_big_matrix[8][0:8], 48'b10};
        for (i = 0; i < 4; i = i + 1)
        begin: great_l4
            assign l4_mat_sum[i + 1] = l4_mat_sum[i] + l4_big_matrix[i];
        end
    endgenerate
    
    // Shift unaligned
    wire [30:0] _c2_shift_int = c2_shift[1] ? {2'b0, unaligned_tmp_c2[8], 1'b0} : {unaligned_tmp_c2[8], 3'b0};
    // 1b shift
    wire [30:0] c2_shifted = c2_shift[0] ? {1'b0, _c2_shift_int[30:1]} : _c2_shift_int;
    // End Shift
    
    always @ (negedge clk) begin
        if (!halt) begin
            automatic real op_real = $bitstoreal({12'h3ff, op});
            automatic real full_sq_out = round_x2_sq(x2_to_real({op[42:27], 8'b0}) ** 2) * c2_to_real(c2, c2_shift) + c0_to_real(c0, op_not_zero) + x2_to_real(op[42:19]) * c1_to_real(c1, c1_shift);
            automatic real tree_res = tree_out_to_real(tree_out[0] + tree_out[1]);
            automatic real v1 = tree_out_to_real({19'b0, c2_position_test, 7'b0} + {c0_matrix, 26'b0} - {10'b0, c1_position_test});
            automatic real v2 = x2_sq_to_real(s_r + s_c) * c2_to_real(c2, c2_shift) + c0_to_real(c0, op_not_zero) + x2_to_real(op[42:19]) * c1_to_real(c1, c1_shift);
            automatic real fuckv1 = tree_out_to_real({19'b0, c2_position_test, 7'b0});
            automatic real fuckv2 = x2_sq_to_real(s_r + s_c) * c2_to_real(c2, c2_shift);
            // Normalize the tree result
            automatic bit [63:0] normalized = {tree_out[0] + tree_out[1], 7'b0};
            verify_table(c2, c1, c0
                    , c2_shift, c1_shift, op_not_zero,
                    s_r + s_c, op[42:19], op, aligned_accumulated_res, naive_out, tree_out[0] + tree_out[1]);
            
            
            
            /*verify_tree_c2(c2, c2_shift, s_r + s_c, {20'b0, c2_position_test, 6'b0});
            verify_tree_unaligned_c2(c2, s_r + s_c, unaligned_tmp_c2[8]);
            $write("c2_position_test: %x\n", c2_position_test);
            $write("Unaligned: %x\n", unaligned_tmp_c2[8]);
            
            verify_tree_c1(c1, c1_shift, op[42:19], {10'b0, c1_position_test});
            verify_tree_unaligned_c1(c1, op[42:19], unaligned_tmp_c1[12]);
            $write("c1_position_test: %x\n", c1_position_test);
            $write("Unaligned: %x\n", unaligned_tmp_c1[12]);
            
            verify_tree_c0(c0, op_not_zero, {c0_matrix, 26'b0});*/
            
            $write("pair: (%f, %f) = (%x, %x)\n", v1, v2, $realtobits(v1), $realtobits(v2));
            $write("fuck_pair: (%e, %e) = (%x, %x)\n", fuckv1, fuckv2, $realtobits(fuckv1), $realtobits(fuckv2));
            $write("div reference: (%e, %e) = (%x, %x)\n", v2, 1 / op_real, $realtobits(v2), $realtobits(1 / op_real));
            $write("sqrt reference: (%e, %e) = (%x, %x)\n", v2, 1 / $sqrt(op_real), $realtobits(v2), $realtobits(1 / $sqrt(op_real)));
           
            // Debugging used: Remove after problem is solved. (CSA DEBUG).
            /*$write("C2+0 expected: %x\n", {19'b0, c2_position_test, 7'b0} + {c0_matrix, 26'b0});
            // Compare c1 terms accumulation.
            $write("C2+0: CSA L1: %x, CSA L2: %x, CSA L3: %x\n", csa_test_c2_level1[6], csa_test_c2_level2[4], csa_test_c2_level3[2]);
            $write("C1 expected: %x\n", {10'b0, c1_position_test});
            // Compare c1 terms accumulation.
            $write("C1: CSA L1: %x, CSA L2: %x, CSA L4: %x\n", csa_test_c1_level1[8], csa_test_c1_level2[4],
                -(l4_big_matrix[2] + l4_big_matrix[3] + 57'b10 + {9'b0, 3'b100 >> c1_shift, 45'b0}));
            // Print the l4 matrix
            $write("L4 0: %x, L4 1: %x\n", l4_big_matrix[0], l4_big_matrix[1]);
            $write("L3: %x, L4: %x\n", l3_mat_sum[8], l4_mat_sum[4]);*/
                
            /*$write("C2 Mat Sum: %x, C2 Ref Sum: %x\n", c2_mat_sum[8], {19'b0, c2_position_test, 7'b0});
            $write("C1 Mat Sum: %x, C1 Ref Sum: %x\n", c1_mat_sum[12], {10'b0, c1_position_test});
            $write("C0 Mat Sum: %x, C0 Ref Sum: %x\n", l1_big_matrix[8], {c0_matrix, 26'b0});*/
            $write("Mat Sum: %x, Ref Sum: %x\n", mat_sum, {19'b0, c2_position_test, 7'b0} + {c0_matrix, 26'b0} - {10'b0, c1_position_test});
                
            // Highlight those with
            $write("C2 shift arg: %b, C1 shift arg: %b, C0 shift arg: %b\n", c2_shift, c1_shift, op_not_zero);
            //$write("tree_sum: %x, tree_out: %x\n", $realtobits(tree_out_to_real(mat_sum)), $realtobits(tree_out_to_real(tree_out[0] + tree_out[1])));
            
            $write("tree output:%x\n", tree_out[0] + tree_out[1]);
            $write("Tree fp rep: %x\n", $realtobits(tree_res));
            // Run Goldschmidt.
            $write("Goldschmidt: %x\n", $realtobits(goldschmidt(is_sqrt, op_real, tree_res)));
            
            // Debugging facility for 3:2 CSA
            /*for (int i = 0; i < 2; i++)
            begin: testing
                automatic bit[56:0] v1 = l2_big_matrix[3 * i] + l2_big_matrix[3 * i + 1] + l2_big_matrix[3 * i + 2];
                automatic bit[56:0] v2 = l3_big_matrix[2 * i] + l3_big_matrix[2 * i + 1];
                if (v1 != v2) begin
                    $write("testing %d! v1: %x, v2:%x\n", i, v1, v2);
                    $write("in: %x, %x, %x; out: %x, %x\n", l2_big_matrix[3 * i], l2_big_matrix[3 * i + 1], l2_big_matrix[3 * i + 2]
                        , l3_big_matrix[2 * i], l3_big_matrix[2 * i + 1]);
                end
            end*/
            // Debugging facility for 4:2 CSA
            /*for (int i = 0; i < 1; i++)
            begin: testing2
                automatic bit[56:0] v1 = l3_big_matrix[3 * i] + l3_big_matrix[3 * i + 1] + l3_big_matrix[3 * i + 2] + l3_big_matrix[3 * i + 3];
                automatic bit[56:0] v2 = l4_big_matrix[2 * i] + l4_big_matrix[2 * i + 1];
                if (v1 != v2) begin
                    $write("testing2 %d! v1: %x, v2:%x\n", i, v1, v2);
                    $write("in: %x, %x, %x, %x; out: %x, %x\n", l3_big_matrix[3 * i], l3_big_matrix[3 * i + 1], l3_big_matrix[3 * i + 2]
                        , l3_big_matrix[3 * i + 3], l4_big_matrix[2 * i], l4_big_matrix[2 * i + 1]);
                end
            end*/
            
            $write("===========\n");
        end
    end
endmodule

module fp_dvsq_test();
    // Build test cases
    class dvsq;
        rand bit [51:0] in;
        function integer expected_value();
            real real_in = $bitstoreal({12'h3ff, in});
            real real_expected = 1 / real_in;
            bit [63:0] full_expected = $realtobits(real_expected);
            // since real_in is in [1, 2), the real_expected is in (0.5, 1], so exp is -1
            bit [29:0] res = {2'b01, full_expected[51:25]};
            return res;
        endfunction
        function void print_value();
            real real_in = $bitstoreal({12'h3ff, in});
            $write("Floating point value: %f\n", real_in);
        endfunction
    endclass
    
    logic [51:0] op;
    logic [29:0] out1;
    logic [29:0] out2;

    logic [29:0] expected;
    
    logic [3:0] counter;
    bit halt;
    bit is_sqrt;
    dvsq value;
    initial begin
        $write("Division/square root testing begin\n");
        counter <= 0;
        halt <= 0;
        is_sqrt <= 1'b0;
        value = new();
    end
    
    // op buffer
    logic [51:0] op_buf[0:1];
    
    bit clk;
    always #2.5 clk <= ~clk;
    always @ (posedge clk) begin
        if (!halt) begin
            // Read the output
            automatic real op_real = $bitstoreal({12'h3ff, op_buf[1]});
            automatic real tree_res = tree_out_to_real({out1 + out2, 27'b0});
            $write("div reference: %x\n", $realtobits(1 / op_real));
            $write("sqrt reference: %x\n", $realtobits(1 / $sqrt(op_real)));
            $write("Goldschmidt: %x\n", $realtobits(goldschmidt(is_sqrt, op_real, tree_res)));
            $write("===========\n");
            // Load the input
            value.randomize();
            op <= value.in;
            counter <= counter + 1;
            expected <= value.expected_value();
            op_buf[0] <= op;
            op_buf[1] <= op_buf[0];
            // Lock if done
            if (counter == 16) begin
                is_sqrt <= 1'b1;
                $write("++++++++++++++++++++\n");
            end else if (counter == 32)
                halt <= 1'b1;
        end 
    end
    
    // The target
    fq_sqrt_divider target_object(.enable(~halt),.valid_out(), .*);
endmodule
