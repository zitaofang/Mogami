`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/01 18:21:13
// Design Name: 
// Module Name: fp_diff_shifter
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

module fp_diff_shifter_test();
    logic [63:0] exp_in;
    logic [63:0] man_in;
    logic [2:0] rm;
    logic is_double;
    logic [63:0] out;
    logic [63:0] expected_out;
    
    encoder_experiment(
        .exp(exp_in),
        .man(man_in),
        .rm(rm),
        .is_double(is_double),
        .out(out)
    );

    // This component has four inputs, and two of the inputs are for control purposes (rm and is_double). 
    // For every normal test case, we have two versions, one with is_double set and another with is_double cleared.
    // We have three special test cases for three invalid value of rm.
    
    // Here is the list of possible variable, with possible variations in brackets:
    // (Note that we will move the rounding mechanism to another list)
    // sign(2), special value flag(4), exp overflow (2), exp underflow(2)
    // Exponent has the following type:
    // 0111...111 (NaN/inf), positive biased exp, 0000...000, negative biased exp (in range), negative biased exp (underflow)
    // Mantissa has the following type:
    // normal mantissa, 000...000
    
    // Rounding hardware is not tested in these cases. 
    
    // Case 0: Overflow and underflow
    // This is a illegal input that can only be caused by hardware malfunction. We should detect a NMI.
    
    //  Case 1: Overflow/underflow and inf/NaN/zero
    // When the special value is inf/NaN, overflow and underflow flags are ignored since we don't know
    // what is in a noncanonical NaN.
    
    // Case 2: Overflow, normal number
    // In this case, the hardware should round to inf, regardless of the exponent.
    
    // Case 3: Underflow, normal number 
    // In this case, the hardware should round to 0.
    
    // Case 4: Exponent 11111...1, overflow not set, normal number
    // This is a special case of overflow. The overflow bit won't be set since it only detect arithmetic
    // overflow in exponent addition, and adding to 111...1 doesn't overflow. Nevertheless, it is a FP overflow
    // and mantissa bit should be cleared.
    
    // Case 5: Denorm number
    // Denorms should be shifted and round (not tested here) correctly. 
    
    // Case 6: Denorm underflow for double, underflow flag not set
    // Sometimes the exponent will be less than the minimum exponent in normalized internal form. 
    
    // Case 7: mantissa 0, normal number flag
    // Adder hardware won't notify the encoder by setting zero flag when it subtract and get a zero.
    
    // Case 8: denormalized mantissa
    // Mantissa not in normalized form is not possible in the internal representation. An NMI must be raised.
    
    // Case 9: Normal number encoding for double
    
    // Case 10: Normal number encoding for single
    
    // Case 11: Single encoding, denorm underflow
    // Denorm underflow threshold is different for single and double.
    
    // Case 12: Single encoding, exponent overflow
    // Single can only represent 8 bits exponent.
    
    // Case 13: rounding overflow
    // An edge case, rounding up when mantissa and exponent are already the maximum normal value.
    
    // ==============================================
    
    // Converter test cases
    // Converter has different thresholds and out-of-range representation, but most of the test case 
    // can be reused after slight modification.
    
    // Case 0: Overflow and underflow
    // This is a illegal input that can only be caused by hardware malfunction. We should detect a NMI.
    
    // Case 1: Overflow flag, normal number
    // In this case, the hardware should round to inf, regardless of the exponent.
    
    // Case 2: Underflow flag, normal number 
    // In this case, the hardware should round to 0.
    
    // Case 3: NaN (negative)
    // NaN should be treated in the same way as inf, regardless of the sign.
    
    // Case 4: inf (both negative and positive)
    // It should be pull to 0 or 1 depending on the signedness.
    
    // Case 5: denorm
    // denorm will be treated as 0.
    
    // Case 6: normal number, exp less than 0
    // Pull to 0 as usual.
    
    // Case 7: normal number, exponent overflow (test both length)
    // Pull to 1 according to the signedness.
    
    // Case 8: Exponent = 64 when converting to 64b signed
    // A edge case that should be treated as overflow.
    
    // Case 9: negative sign, convert to unsigned
    // Treat as 0 per the specs.
    
    // Case 10: negative zero, flag, mantissa not 0, to signed
    // Test if it can correctly handle this tricky value.
    
    // Case 11: normal value
    
    // Case 12: rounding overflow
    // An edge case, rounding up when mantissa and exponent are already the maximum normal value.
endmodule
