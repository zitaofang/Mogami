`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2018 12:17:17 PM
// Design Name: 
// Module Name: fpu
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


module fpu(
    input [63:0] a, // can be an integer
    input [63:0] b,
    input [63:0] c,
    input fused,
    input [1:0] fused_funct,
    input [4:0] funct5,
    input [1:0] fmt,
    input [2:0] rm,
    input [2:0] rm_fcsr,
    output [31:0] fcsr,
    output [63:0] r, // can be an integer
    
    // Connect to the LUT ROM
    output [8:0] lut_address,
    input [29:0] c1,
    input [19:0] c2,
    input [11:0] c3
);  

    // Output Mux
    wire [63:0] output_mux [0:7];

    // Exception wire
    wire [4:0] nv;
    wire dz;
    wire [4:0] of;
    wire uf;
    wire nx;

    // Control unit
    wire is_s;
    wire is_sqrt;
    wire is_subtract;
    wire fused_negate;
    wire conv_int_32bit;
    wire conv_int_signed;
    wire [1:0] round_sel;
    wire is_int_conversion;
    wire [2:0] rm_used;
    wire [1:0] sign_inject_op;
    wire is_min;
    wire replace_NaN;
    wire [2:0] output_sel;
    fp_control(
        .fused(fused),
        .fused_funct(fused),
        .funct5(funct5),
        .fmt(fmt),
        .rm(rm),
        .rm_fcsr(rm_fcsr),
        .fcsr(fcsr),
        .nv(|nv),
        .is_s(is_s)
    );
    
    // Decode F1
    wire sign_a;
    wire [11:0] exponent_a;
    wire [52:0] mantissa_a;
    fp_decoder(
        .in(a),
        .is_s(is_s),
        .sign(sign_a),
        .exponent(exponent_a),
        .mantissa(mantissa_a),
        .exception(nv[0])
    );
    // Decode F2
    wire sign_b;
    wire [11:0] exponent_b;
    wire [52:0] mantissa_b;
    fp_decoder(
        .in(b),
        .is_s(is_s),
        .sign(sign_b),
        .exponent(exponent_b),
        .mantissa(mantissa_b),
        .exception(nv[1])
    );
    // Decode F3
    wire sign_c;
    wire [11:0] exponent_c;
    wire [52:0] mantissa_c;
    fp_decoder(
        .in(c),
        .is_s(is_s),
        .sign(sign_c),
        .exponent(exponent_c),
        .mantissa(mantissa_c),
        .exception(nv[2])
    );
    
    // Mux for fp result and integer conversion rounding
    wire fp_round_mux_sign[0:3];
    wire [11:0] fp_round_mux_exponent[0:3];
    wire [52:0] fp_round_mux_mantissa[0:3];
    wire fp_round_mux_guard[0:3];
    wire fp_round_mux_round[0:3];
    wire fp_round_mux_sticky[0:3];
    wire [11:0] to_int_exponent;
    wire [52:0] to_int_mantissa;
    wire to_int_guard;
    wire to_int_round;
    wire to_int_sticky;
    
    // Div/sqrt LUT unit
    wire [29:0] divsqrt_seed;
    divsqrt_approx(
        .is_sqrt(is_sqrt),
        .mantissa(is_sqrt ? mantissa_a : mantissa_b),
        .seed(divsqrt_seed),
        // Connect to the LUT ROM
        .lut_address(lut_address),
        .c1(c1),
        .c2(c2),
        .c3(c3)
    );
    
    // Div/sqrt unit
    fp_divsqrt(
        .is_sqrt(is_sqrt),
        .sign_a(sign_a),
        .exponent_a(exponent_a),
        .mantissa_a(mantissa_a),
        .sign_b(sign_b),
        .exponent_b(exponent_b),
        .mantissa_b(mantissa_b),
        .sign_r(fp_round_mux_sign[0]),
        .exponent_r(fp_round_mux_exponent[0]),
        .mantissa_r(fp_round_mux_mantissa[0]),
        .guard_r(fp_round_mux_guard[0]),
        .round_r(fp_round_mux_round[0]),
        .sticky_r(fp_round_mux_sticky[0]),
        .overflow(of[0]),
        .div_by_0(dz),
        .seed_b(divsqrt_seed)
    );
    
    // Multiplier unit
    wire mult_r_sign;
    wire [11:0] mult_r_exp;
    wire [52:0] mult_r_man;
    wire mult_r_guard, mult_r_round, mult_r_sticky;
    fp_multiplier(
        .sign_a(sign_a),
        .exponent_a(exponent_a),
        .mantissa_a(mantissa_a),
        .sign_b(sign_b),
        .exponent_b(exponent_b),
        .mantissa_b(mantissa_b),
        .sign_r(mult_r_sign),
        .exponent_r(mult_r_exp),
        .mantissa_r(mult_r_man),
        .guard_r(mult_r_guard),
        .round_r(mult_r_round),
        .sticky_r(mult_r_sticky),
        .overflow(of[1])
    );
    assign fp_round_mux_sign[1] = mult_r_sign;
    assign fp_round_mux_exponent[1] = mult_r_exp;
    assign fp_round_mux_mantissa[1] = mult_r_man;
    assign fp_round_mux_guard[1] = mult_r_guard;
    assign fp_round_mux_round[1] = mult_r_round;
    assign fp_round_mux_sticky[1] = mult_r_man;
    
    // Addition unit
    wire adder_r_sign;
    fp_adder(
        .sign_a(fused ? mult_r_sign : sign_a),
        .exponent_a(fused ? mult_r_exp : exponent_a),
        .mantissa_a(fused ? mult_r_man : mantissa_a),
        .guard_a(fused & mult_r_guard),
        .round_a(fused & mult_r_round),
        .sticky_a(fused & mult_r_sticky),
        .sign_b(is_subtract ^ (fused ? sign_c : sign_b)),
        .exponent_b(fused ? exponent_c : exponent_b),
        .mantissa_b(fused ? mantissa_c : mantissa_b),
        .sign_r(adder_r_sign),
        .exponent_r(fp_round_mux_exponent[2]),
        .mantissa_r(fp_round_mux_mantissa[2]),
        .guard_r(fp_round_mux_guard[2]),
        .round_r(fp_round_mux_round[2]),
        .sticky_r(fp_round_mux_sticky[2]),
        .overflow(of[2])
    );
    assign fp_round_mux_sign[2] = adder_r_sign ^ fused_negate;
    
    // Conversion to FP
    to_fp(
        .int_32bit(conv_int_32bit),
        .int_signed(conv_int_signed),
        .float_s(is_s),
        .int(a),
        .sign_r(fp_round_mux_sign[3]),
        .exponent_r(fp_round_mux_exponent[3]),
        .mantissa_r(fp_round_mux_mantissa[3]),
        .guard_r(fp_round_mux_guard[3]),
        .round_r(fp_round_mux_round[3]),
        .sticky_r(fp_round_mux_sticky[3])
    );
    
    // Rounding
    wire sign_rounded;
    wire [11:0] exp_rounded;
    wire [52:0] man_rounded;
    rounder(
        .mod(rm_used),
        .is_s(is_s),
        .guard(is_int_conversion ? to_int_guard : fp_round_mux_guard[round_sel]),
        .round(is_int_conversion ? to_int_round : fp_round_mux_round[round_sel]),
        .sticky(is_int_conversion ? to_int_sticky : fp_round_mux_sticky[round_sel]),
        .sign(is_int_conversion ? sign_a : fp_round_mux_sign[round_sel]),
        .exponent(is_int_conversion ? to_int_exponent : fp_round_mux_exponent[round_sel]),
        .mantissa(is_int_conversion ? to_int_mantissa : fp_round_mux_mantissa[round_sel]),
        .sign_out(sign_rounded),
        .exponent_out(exp_rounded),
        .mantissa_out(man_rounded),
        .overflow(of[3]),
        .round_occurred(nx)
    );
    
    // Encode
    fp_encoder(
        .out(output_mux[0]),
        .underflow(uf),
        .overflow(of[4]),
        .is_s(is_s),
        .sign(sign_rounded),
        .exponent(exp_rounded),
        .mantissa(man_rounded) // This should be rounded before entering the encoder
    );
    
    // sign injection
    sign_injection(
        .op(sign_inject_op),
        .is_s(is_s),
        .raw_a(a),
        .raw_b(b),
        .raw_out(output_mux[1])
    );
    
    // Classifier
    fp_classifier(
        .is_s(is_s),
        .a(a),
        .res(output_mux[2])
    );
    
    // Compare
    wire comp_lt, comp_eq;
    fp_comparator(
        .is_s(is_s),
        .a(a),
        .b(b),
        .lt(comp_lt),
        .eq(comp_eq),
        .exception(nv[3])
    );
    assign output_mux[3] = {63'b0, comp_lt};
    assign output_mux[4] = {63'b0, comp_eq};
    assign output_mux[5] = {63'b0, ~comp_lt};
    
    // Min/max
    wire [63:0] minmax_res = (comp_lt ^ is_min) ? a : b;
    wire a_NaN = &exponent_a & mantissa_a[52];
    wire b_NaN = &exponent_b & mantissa_b[52];
    assign output_mux[6] = replace_NaN ? {1'b0, 12'hFFF, 51'b0} : (a_NaN ? b : (b_NaN ? a : minmax_res));
    
    // Conversion to integer
    to_int(
        .int_32bit(conv_int_32bit),
        .int_signed(conv_int_signed),
        .float_s(is_s),
        .int(output_mux[7]),
        .sign(sign_a),
        .exponent(exponent_a),
        .mantissa(mantissa_a),
        .exception(nv[4]),
        // Connect the ports below to the rounder
        .guard(to_int_guard),
        .round(to_int_round), 
        .sticky(to_int_sticky),
        .exp_for_round(to_int_exponent),
        .mantissa_unrounded(to_int_mantissa),
        .mantissa_rounded(man_rounded),
        // connect to exponent_out[0]; if it is 1, exponent > 32 or 64,
        // it overflows
        .round_overflow(exp_rounded[0])
    );
    
    assign r = output_mux[output_sel];
endmodule

module fp_control(
    input fused,
    input [1:0] fused_funct,
    input [4:0] funct5,
    input [1:0] fmt,
    input [2:0] rm,
    input [2:0] rm_fcsr,
    output [31:0] fcsr,
    
    input nv,
    input dz,
    input of,
    input uf,
    input nx,
    
    output is_s
);

endmodule

// ======== basic arithmetic circuits =========

module configurable_adder #(parameter BIT = 64) (
    input carry_in,
    input [BIT - 1:0] a,
    input [BIT - 1:0] b,
    output carry_out,
    output sign_carry_in,
    output [BIT - 1:0] r
);
    wire intermediate [0:BIT];
    assign intermediate[0] = carry_in;
    assign carry_out = intermediate[BIT];
    assign sign_carry_in = intermediate[BIT - 1];
    
    genvar i;
    generate
        for (i = 0; i < BIT; i = i + 1)
        begin: adder_gen
            single_adder(.a(a[i]), .b(b[i]), .r(r[i]),
                .carry_in(intermediate[i]), .carry_out(intermediate[i + 1]));
        end
    endgenerate
endmodule

module configurable_comp #(parameter LEVEL = 6) (
    input [2 ** LEVEL - 1:0] a,
    input [2 ** LEVEL - 1:0] b,
    input sign,
    output lt
);
    // swap the sign bit of a and b when they are signed
    wire [2 ** LEVEL - 1:0] signed_a;
    wire [2 ** LEVEL - 1:0] signed_b;
    assign signed_a[2 ** LEVEL - 1] = sign ? b[2 ** LEVEL - 1] : a[2 ** LEVEL - 1];
    assign signed_b[2 ** LEVEL - 1] = sign ? a[2 ** LEVEL - 1] : b[2 ** LEVEL - 1];
    
    // generate a mux from which the result will be selected
    wire a_unpacked[0:2 ** LEVEL - 1];
    genvar i;
    generate
        // If level == 0, the only bit is treated as sign bit
        if (LEVEL != 0)
        begin
            assign signed_a[2 ** LEVEL - 2:0] = a[2 ** LEVEL - 2:0];
            assign signed_b[2 ** LEVEL - 2:0] = b[2 ** LEVEL - 2:0];
        end
        for (i = 0; i < 2 ** LEVEL; i = i + 1)
        begin: unpack_a
            assign a_unpacked[i] = signed_a[i];
        end
    endgenerate
    
    // Compare each bit and get the most significant bit that is different
    wire [2 ** LEVEL - 1:0] comp_res = signed_a ^ signed_b;
    wire [LEVEL - 1:0] msbd;
    wire equal;
    sbs #(.OUT_BIT(LEVEL), .IS_MSBS(1)) (
        .in(comp_res), .out(msbd), .indeterminate(equal)
    );
    
    // If equal, 0; if there is a different bit, select "a" at that bit as the result
    assign lt = equal ? 0 : ~a_unpacked[msbd];
endmodule

// Align the fp input so that they has the same exponent.
// The number with smaller exponent will be shifted.
// This module does not handle any special value: they will be handled in the main
// circuit, and the values calculated with those special values will overwrite
// this value.
module fp_align(
    input [11:0] exponent_a,
    input [52:0] mantissa_a,
    
    input [11:0] exponent_b,
    input [52:0] mantissa_b,
    
    output [52:0] mantissa_a_out,
    output [52:0] mantissa_b_out,
    
    output is_b,
    output guard,
    output round,
    output sticky
);
    wire[11:0] exp_diff_raw;
    wire carry_out, sign_carry_in;
    configurable_adder #(.BIT(12)) (
        .carry_in(1),
        .a(exponent_a),
        .b(~exponent_b),
        .carry_out(carry_out),
        .sign_carry_in(sign_carry_in),
        .r(exp_diff_raw)
    );
    
    // Detect overflow: If overflow happens, the number cannot be represented with current precision.
    // this will only happens if they have different signs.
    // In this case, just check the sticky bit. 
    wire normal_sticky;
    assign sticky = (carry_out ^ sign_carry_in) ? (exponent_a[11] ? mantissa_b[52] : mantissa_a[52]) : normal_sticky;
    
    // See if the difference is negative; if yes, negate it
    wire [11:0] exp_diff;
    assign is_b = ~exp_diff_raw[11];
    assign exp_diff = exp_diff_raw[11] ? ~exp_diff_raw + 1 : exp_diff_raw;
    wire [52:0] shift_mantissa = is_b ? mantissa_b : mantissa_a;
    
    // If diff[11:6] is not all 0, just check the sticky bit
    // Compare the least set bit and exp_diff; if LSBS is smaller, set the sticky bit
    wire [5:0] lsbs;
    // if all bits are 0, the number is a 0, and we don't need to handle it
    sbs #(.OUT_BIT(6), .IS_MSBS(0)) (
        .in({9'b0, shift_mantissa, 2'b0}), // So that it won't count the guard and round bits
        .out(lsbs)
    );
    configurable_comp #(.LEVEL(3)) (
        .a({exp_diff[5:0], 2'b0}),
        .b({lsbs}),
        .sign(0),
        .lt(normal_sticky)
    );
    
    // shift
    wire [63:0] shift_res;
    wire [52:0] res_mantissa;
    shifter (
        .shift(exp_diff[5:0]),
        .sr(1),
        .extend_bit(0),
        .in({shift_mantissa, 11'b0}),
        .out(shift_res)
    );
    
    // extract guard, round and sticky bit
    assign res_mantissa = shift_res[63:11];
    assign guard = shift_res[10];
    assign round = shift_res[9];
    // TODO: modify shifter to get the bit shifted out
    assign normal_sticky = |shift_res[8:0];
    
    assign mantissa_a_out = is_b ? mantissa_a : res_mantissa;
    assign mantissa_b_out = is_b ? mantissa_b : res_mantissa;
endmodule

// The module for the generation of initial estimation for div/sqrt.
module divsqrt_approx(
    input is_sqrt,
    input [52:0] mantissa,
    output [29:0] seed,
    
    // Connect to the LUT ROM
    output [8:0] lut_address,
    input [29:0] c1,
    input [19:0] c2,
    input [11:0] c3
);

endmodule

// =========== floating point decode, encode and round ===========
// NOTE: Sign-injection instructions don't go through decode and encode unit

// This is the internal format used in the FPU: {
// exponent[11:0]
// mantissa[52:0]
// sign
// }
// For denorms, exponent = (leading 1 location(left aligned)) - 1. e.g. for 2^-127, exp = 0.
// If exponent is all 0 and mantissa[52] is 0, it is a 0; otherwise, it is a denorms (see above).
// If exponent is all 1 and mantissa[52] is 0, it is an infinity.
// If exponent is all 1 and mantissa[52] is 1, it is a NaN:
//    - If the decoder discover a singling NaN, fire an exception immediately. The NaN will
//      be treated as an quiet NaN and continue propagation.
//    - FMIN and FMAX are annoying. The control unit will suppress the exception if the
//      instruction is one of them. Also, if there is a signaling NaN, the control unit
//      will replace both operands with quiet NaN.
//    - All NaNs will be canonicalized when encoding.

module fp_decoder(
    input [63:0] in,
    input is_s,
    output sign,
    output [11:0] exponent,
    output [52:0] mantissa,
    output exception
);
    wire [11:0] exponent_mux[0:3];
    wire [52:0] mantissa_mux[0:3];
    // Detect special value
    wire exp_0 = (is_s ? &(~in[30:23]) : &(~in[62:52]));
    wire exp_1 = (is_s ? &in[30:23] : &in[62:52]);
    wire fra_non_0 = (is_s ? |in[22:0] : |in[51:0]);
    // Truth table:
    // exp_1    fra_non_0   type
    // 0        0           00:zero / normal
    // 0        1           01:denorms / normal
    // 1        0           10:inf
    // 1        1           11:NaN
    wire [1:0] sel = {exp_1, fra_non_0 & exp_1};
    
    // If this is a NaN, check if it is a singling NaN and fire an exception if needed.
    assign exception = &sel & (is_s ? in[22] : in[51]);
    
    // Convert single precision exponent for normal exponent
    // We don't need to add the bias to convert the exponent...we can add
    // some bits before it according to the msb.
    wire [10:0] s_exp_raw = {(4'b0111 ^ in[30]) & {4{~exp_0}} | {4{exp_1}}, in[29:23]};
    wire [10:0] exp_raw = is_s ? s_exp_raw: in[62:52];
    
    // Convert single precision mantissa
    wire [52:0] mantissa_raw;
    assign mantissa_raw[51:0] = is_s ? {in[22:0], 29'b0} : in[51:0];
    assign mantissa_raw[52] = ~exp_0;
    
    wire [11:0] exponent_normal;
    wire [52:0] mantissa_normal;
    
    fp_exp_unpack(
        .exponent_r(exp_raw),
        .mantissa_r(mantissa_raw),
        .exponent(exponent_normal),
        .mantissa(mantissa_normal)
    );
    
    // Initialize value for special values
    assign exponent_mux[0] = exponent_normal;
    assign mantissa_mux[0] = mantissa_normal;
    assign exponent_mux[1] = exponent_normal;
    assign mantissa_mux[1] = mantissa_normal;
    assign exponent_mux[2] = 12'hfff; // Inf
    assign mantissa_mux[2] = 53'b0; // Inf
    assign exponent_mux[3] = 12'hfff; // NaN
    assign mantissa_mux[3] = {1'b0, 52'b0};// NaN
    
    assign sign = is_s ? in[31] : in[63];
    assign exponent = exponent_mux[sel];
    assign mantissa = mantissa_mux[sel];
endmodule

module fp_encoder(
    output [63:0] out,
    output underflow,
    output overflow,
    input is_s,
    input sign,
    input [11:0] exponent,
    input [52:0] mantissa // This should be rounded before entering the encoder
);
    // Handle special value (just copy the code from the decoder with minor changes)
    wire [10:0] exponent_r;
    wire [52:0] mantissa_r;
    wire exp_1 = &exponent;
    // Table:
    // exp_1    type
    // 0        zero / denorms / normal
    // 1        inf / NaN
    wire pack_underflow;
    fp_exp_pack(
        .exponent(exponent),
        .mantissa(mantissa),
        .exponent_r(exponent_r),
        .mantissa_r(mantissa_r),
        .underflow(pack_underflow)
    );
    // Detect underflow for single precision. The threshold is -22 (0xFFEA).
    wire underflow_s;
    configurable_comp #(.LEVEL(4)) (
        .a({{5{exponent[11]}}, exponent}),
        .b(16'hFFEA),
        .sign(1),
        .lt(underflow_s)
    );
    assign underflow = (~exp_1 & pack_underflow) | (is_s & underflow_s);
    // Only single precision will overflow here
    assign overflow = is_s & (|exponent[10:8] & ~exponent[11]);
    
    wire [63:0] out_mux[0:1];
    assign out_mux[0][51:0] = mantissa_r[51:0] & {52{~(overflow | underflow)}};
    assign out_mux[1][22:0] = mantissa_r[51:29] & {23{~(overflow | underflow)}};
    assign out_mux[0][62:52] = exponent_r[10:0] | {11{overflow}} & {11{~underflow}};
    // The same bit trick to change the bias
    assign out_mux[1][30:23] = {exponent[11], exponent_r[6:0]} | {8{overflow}} & {8{~underflow}};
    assign out_mux[0][63] = sign;
    assign out_mux[1][31] = sign;
    
    assign out = out_mux[is_s];
endmodule

module fp_exp_unpack(
    input [10:0] exponent_r,
    input [52:0] mantissa_r,
    output [11:0] exponent,
    output [52:0] mantissa
);
    wire denorm = mantissa_r[52];
    wire indeterminate;
    wire [5:0] shift_bit_rev; // The NOT value should be used since the msbs counts from the right
    
    // To avoid addition, the highest bit in the fraction is omitted so that the msbs can be put
    // into exponent directly. You may try converting 2^-128 into the internal format we use to
    // see how it works. 
    sbs #(.OUT_BIT(6), .IS_MSBS(1)) (
        .in({mantissa_r[50:0], 14'b0}),
        .out(shift_bit_rev),
        .indeterminate(indeterminate)
    );
    // If mantissa_r[51] is set or the number is zero, set exponent to 0. mantissa[52] is 0 iff the number
    // is 0, and the arthmetic unit won't even look at the exponent.
    // Otherwise, sign-extend the msbs result and put it in.
    wire [11:0] denorms_exponent = (mantissa_r[51] | indeterminate) ? 12'b0 : {6'h3f, shift_bit_rev};
    // We shift one additional bit to compansate the omitted mantissa_r[51].
    // If mantissa_r[51] is set, omit the msbs
    wire [5:0] shift_bit = {6{~mantissa_r[51]}} & ~shift_bit_rev;
    wire [63:0] shift_result;
    shifter (
        .shift(shift_bit),
        .sr(0),
        .extend_bit(0),
        .in({mantissa_r, 11'b0}),
        .out(shift_result)
    );
    
    assign mantissa = denorm ? shift_result[62:10] : {mantissa, 1'b0};
    assign exponent = denorm ? denorms_exponent : {1'b0, exponent_r};
endmodule

module fp_exp_pack(
    input [11:0] exponent,
    input [52:0] mantissa,
    output [10:0] exponent_r,
    output [52:0] mantissa_r,
    output underflow
);
    // If mantissa[52] is 0, the number is a 0.
    // The number needs normalization if the exponent (internal format) is negative or 0 (for exp = -1023).
    wire is_zero = mantissa[52];
    wire unnormalized = ~|exponent | exponent[11];
    
    // Detect underflow: Any exponent (in internal format) less than -49 (0xFFCF) is an underflow.
    // Since exponent -1023 is represented by 0 in internal format.
    // All overflows will be detected in the arthimetic unit.
    configurable_comp #(.LEVEL(4)) (
        .a({{5{exponent[11]}}, exponent}),
        .b(16'hFFCF),
        .sign(1),
        .lt(underflow)
    );
    
    // Shift the mantissa.It is the inverse of lower 6 bits + 1.
    // See the unpack part for the exponent format.
    wire [5:0] shift_bit = ~exponent[5:0];
    wire [63:0] shift_res;
    shifter (
        .shift(shift_bit),
        .sr(1),
        .extend_bit(0),
        .in({mantissa, 11'b0}),
        .out(shift_res)
    );
    wire [52:0] denorm_mantissa;
    assign denorm_mantissa[52] = 1'b0;
    // If underflow, treat the number as a 0, which means the (raw) exponent is all 0.
    assign denorm_mantissa[51:0] = shift_res[62:10] & {52{~underflow}};
    
    assign exponent_r = exponent & {11{~unnormalized}};
    assign mantissa_r = unnormalized ? denorm_mantissa : mantissa;
endmodule

// Rounding module.
// This module doesn't care if the input is normalize; but the computation
// modules should normalize the result before emitting it to the rounder. 
module rounder(
    input [2:0] mode,
    input is_s,
    input guard,
    input round,
    input sticky,
    
    input sign,
    input [11:0] exponent,
    input [52:0] mantissa,
    
    output sign_out,
    output [11:0] exponent_out,
    output [52:0] mantissa_out,
    
    output overflow,
    output round_occurred
);
    wire round_bit[0:7];
    // Round to Nearest, ties to Even
    // mantissa[29]/0 is the last bit
    assign round_bit[0] = ((sticky | round) & guard) ? (is_s ? mantissa[29] : mantissa[0]) : guard;
    // Round towards Zero
    assign round_bit[1] = 0;
    // Round Down (towards -inf)
    assign round_bit[2] = (guard | (sticky | round)) & sign;
    // Round Up (towards +inf)
    assign round_bit[3] = (guard | (sticky | round)) & ~sign;
    // Round to Nearest, ties to Max Magnitude
    assign round_bit[4] = ((sticky | round) & guard) ? 1 : guard;
    assign round_bit[5] = 0; // Invalid
    assign round_bit[6] = 0; // Invalid
    assign round_bit[7] = 0; // Invalid
    
    // Add the round bit to the operand
    wire [52:0] mantissa_add_operand = is_s ? {29'b0, mantissa[52:29]} : mantissa;
    wire [52:0] man_adder_out;
    wire man_carry_out;
    constant_1bit_adder #(.BIT(53), .CONST_BIT(0)) (
        .a(mantissa_add_operand),
        .carry_out(man_carry_out),
        .r(man_adder_out)
    );
    wire [52:0] man_out = is_s ? {man_adder_out[23:0], 29'b0} : man_adder_out;
    // Handle exponent: 1 will be added to it if the carry out of mantissa is 1
    wire exp_add_1 = is_s ? man_adder_out[23] : man_carry_out;
    wire [11:0] exp_adder_out;
    // There will never be a carry_out in this case; but if exp[10:0] become all 1, overflow occurred
    constant_1bit_adder #(.BIT(12), .CONST_BIT(0)) (
        .a(exponent),
        .r(exp_adder_out)
    );
    assign overflow = &exp_adder_out[10:0];
    
    // wrap up
    assign round_occurred = round_bit[mode];
    assign sign_out = sign;
    // If it is overflow, the value become inf, and exp[11] meeds to be 1
    assign exponent_out = (round_bit[mode] & exp_add_1) ? {overflow, 11'b0} | exp_adder_out : exponent;
    // If exponent needs an additional 1, shift the mantissa back by 1
    assign mantissa_out = round_bit[mode] ? (exp_add_1 ? {1'b1, man_out[52:1]} : man_out) : mantissa;
endmodule

// ======== non-fp computing circuit ========

// Sign-injection module
module sign_injection(
    input [1:0] op,
    input is_s,
    input [63:0] raw_a,
    input [63:0] raw_b,
    output [63:0] raw_out
);
    wire sign_b = is_s ? raw_b[31] : raw_b[63];
    wire sign_mux[0:3];
    assign sign_mux[0] = sign_b;
    assign sign_mux[1] = ~sign_b;
    assign sign_mux[2] = (is_s ? raw_a[31] : raw_a[63]) ^ sign_b;
    assign sign_mux[3] = 0; // Invalid, never used
    assign raw_out = sign_mux[op];
endmodule

// Convert a floating point to an integer
// Note: Some ports must be connected to the rounder in order to function
// correctly. The sign for the rounder should be the same with the sign
// come into this module.
module to_int(
    input int_32bit,
    input int_signed,
    input float_s,
    output [63:0] int,
    input sign,
    input [11:0] exponent,
    input [52:0] mantissa,
    
    output exception,
    
    // Connect the ports below to the rounder
    output guard,
    output round, 
    output sticky,
    output [11:0] exp_for_round,
    output [52:0] mantissa_unrounded,
    
    input [52:0] mantissa_rounded,
    // connect to exponent_out[0]; if it is 1, exponent > 32 or 64,
    // it overflows
    input round_overflow
);
    // Align
    // If the number being aligned is b, the number is larger than what can
    // be represented and it's an overflow
    wire align_overflow, guard_d, round_d, sticky_d;
    fp_align(
        .exponent_a(exponent),
        .mantissa_a(mantissa),
        
        .exponent_b(int_32bit ? 11'd32 : 11'd64),
        .mantissa_b(53'b0),
        
        .mantissa_a_out(mantissa_unrounded),
        .mantissa_b_out(),
        
        .is_b(align_overflow),
        .guard(guard_d),
        .round(round_d),
        .sticky(sticky_d)
    );
    
    // Prepare for the rounder
    assign guard = guard_d | (mantissa_rounded[27] & float_s);
    assign round = round_d | (mantissa_rounded[26] & float_s);
    assign sticky = sticky_d | (|mantissa_rounded[25:0] & float_s);
    
    // Adjust the mantissa for single precision
    wire [63:0] adjusted_man = float_s ? {mantissa_rounded[52:28], 40'b0} : {mantissa_rounded, 11'b0};
    
    // handle overflow and special value
    // Table:
    // signedness   overflow_direction    out
    // 0            0                   11...1
    // 0            1                   00...0
    // 1            0                   01...1
    // 1            1                   10...0
    assign exception = align_overflow | round_overflow |        // value overflow
        (int_signed & adjusted_man[63]) | (~int_signed & sign); // signedness overflow
    wire overflow_sign = sign & (&exponent & |mantissa); // For NaNs, always treat them as positive overflow
    wire [63:0] overflow_man = {~overflow_sign ^ int_signed, {63{~overflow_sign}}};
    
    // wrap up
    wire [63:0] out_int = exception ? overflow_man : adjusted_man;
    assign int = int_32bit ? {32'b0, out_int[31:0]} : out_int;
endmodule

// Convert a floating point to an integer
module to_fp(
    input int_32bit,
    input int_signed,
    input float_s,
    input [63:0] int,
    output sign,
    output [11:0] exponent,
    output [52:0] mantissa,
    output guard,
    output round,
    output sticky
);
    assign sign = int_signed & (int_32bit ? int[31] : int[63]);
    // Find the msbs as the leading 1. If there isn't, it is a 0.
    wire [63:0] normalized_int = int_32bit ? {int[31] & ~int_signed, int[30:0], 32'b0} :
        {int[63] & ~int_signed, int[62:0]};
    wire [5:0] msbs;
    wire zero;
    sbs #(.OUT_BIT(6), .IS_MSBS(1)) (
        .in(normalized_int),
        .out(msbs),
        .indeterminate(zero)
    );
    
    // shift the mantissa
    wire [63:0] shifted_man;
    shifter (
        .shift(~msbs),
        .sr(0),
        .extend_bit(1),
        .in(normalized_int),
        .out(shifted_man)
    );
    
    // Round
    assign guard = float_s ? shifted_man[40] : shifted_man[11];
    assign round = float_s ? shifted_man[39] : shifted_man[10];
    assign sticky = float_s ? |shifted_man[38:0] : |shifted_man[9:0];
    
    // wrap up
    assign exponent = {6'b0, msbs};
    assign mantissa = shifted_man[63:11];
endmodule

// A improved module for fp comparation
// It accepts two raw fp.
// If any of the operands is NaN, fire an exception anyway. The control unit will
// decide whether or not to suppress the exception. But it will still output a 0.
// FEQ, FMIN and FMAX will suppress the exception. 
// FMIN and FMAX will ignore the output from this module if any of the operand is
// NaN. 
module fp_comparator (
    input is_s,
    input [63:0] a,
    input [63:0] b,
    output lt,
    output eq,
    output exception
);
    // Left-aligned single precision
    wire [63:0] left_align_a = is_s ? {a[31:0], 32'b0} : a;
    wire [63:0] left_align_b = is_s ? {b[31:0], 32'b0} : b;

    // Detect NaN
    wire a_exp_1 = is_s ? &a[30:23] : &a[62:52];
    wire b_exp_1 = is_s ? &b[30:23] : &b[62:52];
    wire a_man_non_0 = is_s ? |a[22:0] : |a[51:0];
    wire b_man_non_0 = is_s ? |b[22:0] : |b[51:0];
    assign exception = (a_exp_1 & a_man_non_0) | (b_exp_1 & b_man_non_0);
    
    // Detect 0: +0 == -0
    wire [63:0] a_aug = {left_align_a[63] & |left_align_a[62:0], left_align_a[62:0]};
    wire [63:0] b_aug = {left_align_b[63] & |left_align_b[62:0], left_align_b[62:0]};
    
    // Compare
    wire comp_lt;
    comparator(
        .a(a_aug),
        .b(b_aug),
        .sign(1),
        .lt(comp_lt)
    );
    
    // wrap up
    assign lt = ~exception & comp_lt;
    assign eq = ~exception & ~|(a_aug ^ b_aug);
endmodule

// This module accept IEEE FP instead of FP in the internal format.
// The format RISC-V uses is easy to implement; just read the code.
module fp_classifier(
    input is_s,
    input [63:0] a,
    output [63:0] res
);
    wire is_NaN_mux[0:1];
    assign is_NaN_mux[0] = &a[62:52] | |a[51:0];
    assign is_NaN_mux[1] = &a[30:23] | |a[22:0];
    wire is_NaN = is_NaN_mux[is_s];
    wire quiet_bit[0:1];
    assign quiet_bit[0] = a[51];
    assign quiet_bit[1] = a[22];
    
    wire sign_bit[0:1];
    assign sign_bit[0] = a[63];
    assign sign_bit[1] = a[31];
    wire [2:0] res_normal[0:1];
    assign res_normal[0][2] = 1;
    assign res_normal[1][2] = 1;
    assign res_normal[0][1] = |a[62:52]; // Is exponent not all 0?
    assign res_normal[1][1] = |a[30:23];
    assign res_normal[0][0] = (|a[51:0]) ^ res_normal[0][1]; // (Is fraction not all 0) ^ (...)
    assign res_normal[1][0] = (|a[22:0]) ^ res_normal[1][1];
    
    wire[3:0] res_short;
    assign res_short[3] = is_NaN;
    assign res_short[2:1] = {2{~is_NaN}} & (res_normal[is_s][2:1] ^ {2{sign_bit[is_s]}});
    assign res_short[0] = is_NaN | (res_normal[is_s][0] ^ sign_bit[is_s]);
    
    assign res = {60'b0, res_short};
endmodule

// ========= FP computation ==========

module fp_adder(
    input sign_a,
    input [11:0] exponent_a,
    input [52:0] mantissa_a,
    input guard_a,
    input round_a,
    input sticky_a,
    
    input sign_b,
    input [11:0] exponent_b,
    input [52:0] mantissa_b,
    
    output sign_r,
    output [11:0] exponent_r,
    output [52:0] mantissa_r,
    output guard_r,
    output round_r,
    output sticky_r,
    
    output overflow
);
    // Handle special values 
    // For NaN, output a canocial NaN
    wire exp_a_1 = &exponent_a;
    wire exp_b_1 = &exponent_b;
    wire exp_a_inf = exp_a_1 & ~mantissa_a[52];
    wire exp_b_inf = exp_b_1 & ~mantissa_b[52];
    wire is_NaN = (exp_a_1 & mantissa_a[52]) | (exp_b_1 & mantissa_b[52]) | // NaN propagation
        ((sign_a ^ sign_b) & exp_a_inf & exp_b_inf); // inf subtraction
    wire sign_NaN_mux[0:1];
    wire [11:0] exponent_NaN_mux [0:1];
    wire [52:0] mantissa_NaN_mux [0:1];
    assign sign_NaN_mux[1] = 0;
    assign exponent_NaN_mux[1] = 12'hFFF;
    assign mantissa_NaN_mux[1] = {1'b1, 52'b0};
    
    assign sign_r = sign_NaN_mux[is_NaN];
    assign exponent_r = exponent_NaN_mux[is_NaN];
    assign mantissa_r = mantissa_NaN_mux[is_NaN];
    // For inf, output the inf
    wire sign_inf_mux[0:1];
    wire [11:0] exponent_inf_mux [0:1];
    wire [52:0] mantissa_inf_mux [0:1];
    wire is_inf = exp_a_inf | exp_b_inf;
    assign sign_inf_mux[1] = exp_a_inf ? sign_a : sign_b;
    assign exponent_inf_mux[1] = 12'hFFF;
    assign mantissa_inf_mux[1] = 53'b0;
    
    assign sign_NaN_mux[0] = sign_inf_mux[is_inf];
    assign exponent_NaN_mux[0] = exponent_inf_mux[is_inf];
    assign mantissa_NaN_mux[0] = mantissa_inf_mux[is_inf];
    // For 0, output another operand
    wire sign_zero_mux[0:1];
    wire [11:0] exponent_zero_mux [0:1];
    wire [52:0] mantissa_zero_mux [0:1];
    wire a_0 = ~mantissa_a[52] & exponent_a[0];
    wire b_0 = ~mantissa_b[52] & exponent_b[0];
    wire is_0 = a_0 | b_0;
    assign sign_zero_mux[1] = a_0 ? sign_b : sign_a;
    assign exponent_zero_mux[1] = a_0 ? exponent_b : exponent_a;
    assign mantissa_zero_mux[1] = a_0 ? mantissa_b : mantissa_a;
    
    assign sign_inf_mux[0] = sign_zero_mux[is_0];
    assign exponent_inf_mux[0] = exponent_zero_mux[is_0];
    assign mantissa_inf_mux[0] = mantissa_zero_mux[is_0];
    
    // A flag that indicate if there is special value.
    // If it is set, guard, round, sticky and overflow will be cleared.
    wire special_val = is_NaN | is_inf | is_0;
    
    // align
    wire guard_align, round_align, sticky_align;
    wire b_shifted;
    wire [52:0] a_aligned;
    wire [52:0] b_aligned;
    fp_align(
        .exponent_a(exponent_a),
        .mantissa_a(mantissa_a),
        
        .exponent_b(exponent_b),
        .mantissa_b(mantissa_b),
        
        .mantissa_a_out(a_aligned),
        .mantissa_b_out(b_aligned),
        
        .is_b(b_shifted),
        .guard(guard_align),
        .round(round_align),
        .sticky(sticky_align)
    );
    
    // Process rounding bits
    wire guard_a_com = b_shifted ? guard_a : guard_align;
    wire round_a_com = b_shifted ? round_a : round_align;
    wire sticky_a_com = b_shifted ? sticky_a : sticky_align;
    wire guard_b_com = b_shifted & guard_align;
    wire round_b_com = b_shifted & round_align;
    wire sticky_b_com = b_shifted & sticky_align;
    
    // add
    // If they have different signs, treat it as (a-b), use the sign from a
    wire [57:0] adder_res;
    configurable_adder #(.BIT(58)) (
        .carry_in(sign_a ^ sign_b),
        .a({2'b0, a_aligned, guard_a_com, round_a_com, sticky_a_com}),
        .b({58{sign_a ^ sign_b}} ^
            {2'b0, b_aligned, guard_b_com, round_b_com, sticky_b_com}),
        .r(adder_res)
    );
    
    // Handle the sign
    // if the sign bit is 1, negate the result, then inverse the sign bit
    assign sign_r = sign_a ^ adder_res[57];
    wire [57:0] const_adder_res;
    constant_1bit_adder #(.BIT(58), .CONST_BIT(0)) (
        .a({58{adder_res[57]}} ^ adder_res),
        .r(const_adder_res)
    );
    wire [57:0] mantissa_aug_r = adder_res[57] ? const_adder_res : adder_res;
    
    // Handle overflow
    // We use an additional bit to buffer the mantissa overflow. If bit 56 is 1, we must add 1
    // to the exponent.
    wire [11:0] exponent_used = b_shifted ? exponent_a : exponent_b;
    wire [11:0] exp_adder_out;
    // There will never be a carry_out in this case; but if exp[10:0] become all 1, overflow occurred
    constant_1bit_adder #(.BIT(12), .CONST_BIT(0)) (
        .a(exponent_used),
        .r(exp_adder_out)
    );
    assign overflow = &exp_adder_out[10:0] & ~special_val;
    assign exponent_r = mantissa_aug_r[56] ? exp_adder_out : exponent_used;
    // If overflow, it becomes infinity
    assign mantissa_r = {53{~overflow}} &
        (mantissa_aug_r[56] ? mantissa_aug_r[56:4] : mantissa_aug_r[55:3]);
    assign guard_r = ~overflow & ~special_val &
        (mantissa_aug_r[56] ? mantissa_aug_r[3] : mantissa_aug_r[2]);
    assign round_r = ~overflow & ~special_val &
        (mantissa_aug_r[56] ? mantissa_aug_r[2] : mantissa_aug_r[1]);
    assign sticky_r = ~overflow & ~special_val &
        (mantissa_aug_r[56] ? mantissa_aug_r[1] | mantissa_aug_r[0] : mantissa_aug_r[0]);
endmodule

module fp_multiplier(
    input sign_a,
    input [11:0] exponent_a,
    input [52:0] mantissa_a,
    
    input sign_b,
    input [11:0] exponent_b,
    input [52:0] mantissa_b,
    
    output sign_r,
    output [11:0] exponent_r,
    output [52:0] mantissa_r,
    output guard_r,
    output round_r,
    output sticky_r,
    
    output overflow
);
    // Handle special values 
    // For NaN, output a canocial NaN
    wire exp_a_1 = &exponent_a;
    wire exp_b_1 = &exponent_b;
    wire exp_a_inf = exp_a_1 & ~mantissa_a[52];
    wire exp_b_inf = exp_b_1 & ~mantissa_b[52];
    wire is_NaN = (exp_a_1 & mantissa_a[52]) | (exp_b_1 & mantissa_b[52]) | // NaN propagation
        (~(mantissa_a[52] | mantissa_b[52]) & (exp_a_inf | exp_b_inf)); // inf mult 0
    wire [11:0] exponent_NaN_mux [0:1];
    wire [52:0] mantissa_NaN_mux [0:1];
    assign exponent_NaN_mux[1] = 12'hFFF;
    assign mantissa_NaN_mux[1] = {1'b1, 52'b0};
    
    assign exponent_r = exponent_NaN_mux[is_NaN];
    assign mantissa_r = mantissa_NaN_mux[is_NaN];
    // For inf, output the inf
    wire [11:0] exponent_inf_mux [0:1];
    wire [52:0] mantissa_inf_mux [0:1];
    wire is_inf = exp_a_inf | exp_b_inf;
    assign exponent_inf_mux[1] = 12'hFFF;
    assign mantissa_inf_mux[1] = 53'b0;
    
    assign exponent_NaN_mux[0] = exponent_inf_mux[is_inf];
    assign mantissa_NaN_mux[0] = mantissa_inf_mux[is_inf];
    // For 0, output 0
    wire [11:0] exponent_zero_mux [0:1];
    wire [52:0] mantissa_zero_mux [0:1];
    wire a_0 = ~mantissa_a[52] & exponent_a[0];
    wire b_0 = ~mantissa_b[52] & exponent_b[0];
    wire is_0 = a_0 | b_0;
    assign exponent_zero_mux[1] = 12'b0;
    assign mantissa_zero_mux[1] = 53'b0;
    
    assign exponent_inf_mux[0] = exponent_zero_mux[is_0];
    assign mantissa_inf_mux[0] = mantissa_zero_mux[is_0];
    
    // A flag that indicate if there is special value.
    // If it is set, guard, round, sticky and overflow will be cleared.
    wire special_val = is_NaN | is_inf | is_0;
    
    // First we have to subtract the bias, 1023, from the exponent.
    wire [11:0] b_unbiased_int;
    constant_1bit_adder #(.BIT(12), .CONST_BIT(0)) (
        .a(exponent_b),
        .r(b_unbiased_int)
    );
    wire [11:0] b_unbiased;
    assign b_unbiased[9:0] = b_unbiased_int[9:0];
    configurable_adder #(.BIT(2)) (
        .carry_in(0),
        .a(2'b11),
        .b(b_unbiased_int[11:10]),
        .carry_out(),
        .sign_carry_in(),
        .r(b_unbiased_int[11:10])
    );
    
    // Then, add the exponent together
    wire [11:0] exponent_add_res;
    wire adder_overflow;
    configurable_adder #(.BIT(12)) (
        .carry_in(0),
        .a(exponent_a),
        .b(b_unbiased),
        .carry_out(adder_overflow),
        .sign_carry_in(),
        .r(exponent_add_res)
    );
    // If overflow, set to inf
    assign exponent_zero_mux[0] = {12{adder_overflow}} | exponent_add_res;
    
    // Determine the sign
    assign sign_r = ~is_NaN & (sign_a ^ sign_b);
    
    // Multiply the mantissa
    // TODO use the smaller configurable multiplier
    wire [127:0] tmp_mult_out;
    multiplier (
        .sign(0),
        .a({mantissa_a, 11'b0}),
        .b({mantissa_b, 11'b0}),
        .h(tmp_mult_out[127:64]),
        .l(tmp_mult_out[63:0])
    );
    
    // Determine result
    assign mantissa_zero_mux[0] = {53{~adder_overflow}} & tmp_mult_out[127:75];
    assign overflow = ~special_val & adder_overflow;
    assign guard_r = ~adder_overflow & tmp_mult_out[74] & ~special_val;
    assign round_r = ~adder_overflow & tmp_mult_out[73] & ~special_val;
    assign sticky_r = ~adder_overflow & |tmp_mult_out[72:0] & ~special_val;
endmodule

// This module is based on the following literature but with minor modification in 
// the Goldschmidt's algorithm part so that uops can be used:
//
// Pineiro JA, Bruguera JD. High-speed double-precision computation of reciprocal, division, square root, and inverse square root.
//     IEEE Transactions on Computers. 2002 Dec;51(12):1377-88.
//
module fp_divsqrt(
    input is_sqrt,

    input sign_a,
    input [11:0] exponent_a,
    input [52:0] mantissa_a,
    
    input sign_b,
    input [11:0] exponent_b,
    input [52:0] mantissa_b,
    
    output sign_r,
    output [11:0] exponent_r,
    output [52:0] mantissa_r,
    output guard_r,
    output round_r,
    output sticky_r,
    
    output overflow,
    output div_by_0,
    
    // Connect these to the lookup table
    input [29:0] seed_b
);

endmodule

module squaring(
    input [15:0] in,
    output [15:0] out,
    output [15:0] out_c
);
    // The value to be accumulate (not on the diagonal)
    wire [15:0] accumulate [0:7];
    // The diagonal value
    wire [15:0] diagonal;
    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1)
        begin: acc_gen
            wire [15:0] acc_tmp;
            assign acc_tmp[14 - 2 * i:0] = in[14 - 2 * i:0] & {(15 - 2 * i){in[15 - i]}};
            assign acc_tmp[15:15 - 2 * i] = {(1 + 2 * i){1'b0}};
            // A special case: for accumulate[7], we add an 1 specified by the algorithm at bit 2
            if (i == 7)
                assign accumulate[i] = {acc_tmp[15:2], 1'b1, acc_tmp[0]};
            else
                assign accumulate[i] = {acc_tmp[15:0]}; 
            
            assign diagonal[2 * i + 1] = 1'b0;
            assign diagonal[2 * i] = in[15 - i];
        end
    endgenerate
    
    // accumulate it using a tree
    // level 0
    wire [15:0] acc_level0 [0:5];
    csa #(.INPUT_SIZE(16)) (
        .a(accumulate[0]),
        .b(accumulate[1]),
        .c(accumulate[2]),
        .cin(1'b0),
        .cout(acc_level0[0]),
        .r(acc_level0[1])
    );
    csa #(.INPUT_SIZE(16)) (
        .a(accumulate[3]),
        .b(accumulate[4]),
        .c(accumulate[5]),
        .cin(1'b0),
        .cout(acc_level0[2]),
        .r(acc_level0[3])
    );
    csa #(.INPUT_SIZE(16)) (
        .a(accumulate[6]),
        .b(accumulate[7]),
        .c(diagonal),
        .cin(1'b0),
        .cout(acc_level0[4]),
        .r(acc_level0[5])
    );
    
    // level 1
    wire [15:0] acc_level1[0:3];
    csa #(.INPUT_SIZE(16)) (
        .a(acc_level0[0]),
        .b(acc_level0[1]),
        .c(acc_level0[2]),
        .cin(1'b0),
        .cout(acc_level1[0]),
        .r(acc_level1[1])
    );
    csa #(.INPUT_SIZE(16)) (
        .a(acc_level0[3]),
        .b(acc_level0[4]),
        .c(acc_level0[5]),
        .cin(1'b0),
        .cout(acc_level1[2]),
        .r(acc_level1[3])
    );
    
    // level 2
    csa4 #(.INPUT_SIZE(16)) (
        .a(acc_level1[0]),
        .b(acc_level1[1]),
        .c(acc_level1[2]),
        .d(acc_level1[3]),
        .cin(2'b0),
        .r(out),
        .cout(out_c)
    );
endmodule

// This recoder is based on the following literature:
// Lyu CN, Matula DW. Redundant binary booth recoding. InComputer Arithmetic, 1995.,
//      Proceedings of the 12th Symposium on 1995 Jul 19 (pp. 50-57). IEEE.
module booth_recoder_core(
    input l,
    input r_2m,
    input r_1s,
    input r_1m,
    input cin,
    output sign,
    output m_2,
    output m_1,
    output m_0,
    output cout
);
    assign sign = r_2m ^ r_1s;
    assign cout = ~(l | r_1s);
    assign m_1 = r_1m ^ cin;
    wire m_int = sign ^ r_1m;
    assign m_2 = ~(~m_int | m_1);
    assign m_0 = ~(m_int | m_1);
endmodule

module booth_recoder_2c(
    input [1:0] b,
    input cin,
    output cout,
    output sign,
    output m_0,
    output m_1,
    output m_2
);
    booth_recoder_core(
        .l(~b[1]),
        .r_2m(b[1]),
        .r_1s(1'b0),
        .r_1m(b[0]),
        .cin(cin),
        .sign(sign),
        .m_2(m_2),
        .m_1(m_1),
        .m_0(m_0),
        .cout(cout)
    );
endmodule

module booth_recoder_cs(
    input [2:0] c,
    input [2:0] s,
    input cin,
    output cout,
    output sign,
    output m_0,
    output m_1,
    output m_2
);
    wire [3:0] int = {~(c[2] ^ s[2]), ~(c[1] | s[1]), ~(c[1] ^ s[1]), ~(c[0] | s[0])};
    booth_recoder_core(
        .l(~(int[3] & ~int[2])),
        .r_2m(int[3] ^ int[2]),
        .r_1s(~(int[1] | ~int[0])),
        .r_1m(int[1] ^ int[0]),
        .cin(cin),
        .sign(sign),
        .m_2(m_2),
        .m_1(m_1),
        .m_0(m_0),
        .cout(cout)
    );
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
            booth_recoder_cs(
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
            booth_recoder_cs(
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