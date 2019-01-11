package mogami.arithmetic.fp

import chisel3._
import chisel3.util._

// This module is based on the following literature but with minor modification in
// the Goldschmidt's algorithm part so that uops can be used:
//
// Pineiro JA, Bruguera JD. High-speed double-precision computation of reciprocal, division, square root, and inverse square root.
//     IEEE Transactions on Computers. 2002 Dec;51(12):1377-88.

// The squaring unit
class Square extends Module {
  val io = IO(new Bundle{
    val in = Input(UInt(16.W))
    val out_s = Output(UInt(16.W))
    val out_c = Output(UInt(16.W))
  })

  // Arrange the input
  // This have already been tested in verilog code and should work
  val mat_in = List(
    Cat(false.B, Fill(15, io.in(15)) & in(14, 0)),
    Cat(false.B, io.in(15), false.B, Fill(13, io.in(14)) & io.in(13, 1)),
    Cat(0.U(3.W), io.in(14), false.B, Fill(11, io.in(13)) & io.in(12, 2)),
    Cat(0.U(5.W), io.in(13), false.B, Fill(9, io.in(12)) & io.in(11, 3)),
    Cat(0.U(7.W), io.in(12), false.B, Fill(7, io.in(11)) & io.in(10, 4)),
    Cat(0.U(9.W), io.in(11), false.B, Fill(5, io.in(10)) & io.in(9, 5)),
    Cat(0.U(11.W), io.in(10), false.B, Fill(3, io.in(9)) & io.in(8, 6)),
    Cat(0.U(13.W), io.in(9), true.B, io.in(8) & io.in(7)),
    Cat(0.U(15.W), io.in(8))
  )

  // Tree
  (io.out_s, io.out_c) := csa_tree(16)(mat_in)
}

// The Black box for the LUT
class CoeffLUT extends BlackBox {
  val io = IO(new Bundle{
    val clk = Input(Clock())
    val a = Input(UInt(10.W))
    val spo = Output(UInt(64.W))
  })
}

// The Mantissa component
class DivSqrtSeedMantissa extends Module {
  val io = IO(new Bundle{
    val is_sqrt = Input(Bool)
    val sqrt_2 = Input(Bool)
    val in = Input(UInt(52.W))
    val out_s = Output(UInt(30.W))
    val out_c = Output(UInt(30.W))
  })

  // Read the memory (2 cycle delay)
  val div_lut = Module(new CoeffLUT(0))
  div_lut.io.clk := Module.clock
  div_lut.io.a := in(51, 43)
  val div_mem_out = div_lut.io.spo
  val sqrt_lut = Module(new CoeffLUT(1))
  sqrt_lut.io.clk := Module.clock
  sqrt_lut.io.a := in(51, 43)
  val sqrt_mem_out = sqrt_lut.io.spo
  val sqrt2_lut = Module(new CoeffLUT(2))
  sqrt2_lut.io.clk := Module.clock
  sqrt2_lut.io.a := in(51, 43)
  val sqrt2_mem_out = sqrt2_lut.io.spo

  // Select the output
  val is_sqrt_reg = RegNext(RegNext(io.is_sqrt))
  val sqrt_2_reg = RegNext(RegNext(io.sqrt_2_reg))
  val mem_out = Mux(is_sqrt_reg,
    Mux(sqrt_2_reg, sqrt2_mem_out, sqrt_mem_out),
  div_mem_out)

  // Squaring unit (1 cycle delay)
  val square = Module(new Square())
  square.io.in := io.in(42, 27)
  val square_out_s = RegNext(square.io.out_s)
  val square_out_c = RegNext(square.io.out_c)

  // Carry-save recode (1 cycle delay)
  // (It can be done within the squaring cycle, but we still need to wait
  // for the LUT)
  val sq_recode = Module(new SD4RecoderSC(16))
  sq_recode.io.in_s := square_out_s
  sq.recode.io.in_c := square_out_c
  val sq_recode_out = RegNext(sq_recode.io.out)
  val sq_recode_cout = RegNext(sq_recode.io.carry_out)

  // Another recode for x_2, 1 cycle, and delay another cycle
  val x2_recode = Module(new SD4Recoder2C(24))
  x2_recode.io.in := io.in(42, 19)
  val x2_recode_out = RegNext(RegNext(x2_recode.io.out))
  val x2_recode_cout = RegNext(RegNext(x2_recode.io.carry_out))

  // Look up the exponent and shift the coefficient
  // This can be found in the log file generated by the LUT generator.
  // The base exponents (in biased) are: 3FE for C2, 3FE for C1, and 3FF for C0.
  // The table below contains the offset (shamt to the right) of the number.
  val exp_table = VecInit(
    "b0000".U(4.W),
    "b0100".U(4.W),
    "b0101".U(4.W),
    "b1001".U(4.W),
    "b0000".U(4.W),
    "b0000".U(4.W),
    "b0000".U(4.W),
    "b0000".U(4.W),
    "b0101".U(4.W),
    "b1001".U(4.W),
    "b1101".U(4.W),
    "b1110".U(4.W),
    "b0101".U(4.W),
    "b1001".U(4.W),
    "b1010".U(4.W),
    "b1110".U(4.W)
  )
  // In the "sqrt of 2" case, the exponents of C2 and C1 change four times,
  // which cannot be encoded in a 2-bit number we used here. The final case will
  // be wrapped around to zero.
  // Therefore, I use the MSB of the input to distinguish the two cases encoded
  // aso 00. By the way, the last case requires a 4-bit shift on C2 and a
  // 2-bit shift on C1 (which means the C1 offset "01" in the "00" entry above
  // needs to be inverted).
  val additional_state = io.is_sqrt & io.sqrt_2 & ~mem_out(63, 62).orR
  val (c2_shamt, c1_shamt) = exp_table(Cat(Cat(io.is_sqrt, io.sqrt_2),
    mem_out(63, 62))) ^ Cat(0.U(2.W), Fill(2, additional_state))
  // Regarding c0: exponent of c0 is almost always 3FE except when the 9 most
  // significant bits are all 0 (which means the divisor is approximately 1),
  // and it is not in the sqrt of 2 (odd input exponent) case.
  val c0_shamt = (io.in(51, 43).orR | io.sqrt_2).asUInt

  // Generate Unaligned, unshifted PP
  val c2_pp = PPGenerate(mem_out(61, 50), sq_recode_out, sq_recode_cout)
  val c1_pp = PPGenerate(mem_out(49, 30), x2_recode_out, x2_recode_cout)
  val c0_pp = mem_out(29, 0)

  // Propagation bit:
  // In this matrix, there are always overflows from the
  // matrix summations of c2 and c1. The c2 matrix will be negated
  // at the last step, so the c1 overflow becomes a "hole". The bits
  // below help propagate the c2 overflow to the c1 hole to correct
  // the result.
  // The propagate bits have three parts: the head aligned with c1 MSB,
  // the body, and the tail aligned with c2 MSB.
  val p_head = "b'11".U(2.W) >> c1_shamt

  // The function to shift the operand
  val shift_func = (a, i) => Mux(additional_state,
    Cat(Fill(4, (i == 7).B), a),
    ShifterBlock(Cat(a, 0.U(4.W)), c2_shamt, true.B, (i == 7).B)._1
  )
  // Shift
  // Here, the propagation tail is shifted in
  val raw_pos_pp =
    ((c2_pp zip (0 until 8)) map Cat(0.U(19.W),
      shift_func(_, _)
    0.U(6.U))) ++
    Cat(ShifterBlock(c0_pp, c0_shamt, true.B, false.B)._1, 0.U(26.W))
  val neg_pp =
    (c1_pp map Cat(0.U(10.W),
      ShifterBlock(Cat(_, 0.U(3.W)), c1_shamt, true.B, false.B)._1)
    )

  // Add the propagation bit in
  val pos_pp = raw_pos_pp.slice(0, 7) :+
    Cat(0.U(10.W), p_head, "b'1111111".U(7.W), raw_pos_pp(7)(36, 0))

  // Wallace tree
  val (pos_s, pos_c) = csa_tree(56)(pos_pp)
  val (neg_s, neg_c) = csa_tree(56)(neg_pp)
  // Then, flip neg_s and _c and add them together
  // Since I need two carry-ins to negate them, I manually set the csa as the
  // csa_tree doesn't allow carry in
  val (int_s, int_c) = csa(56)(pos_s, pos_c, ~neg_s, true.B)
  val (res_s, res_c) = csa(56)(int_s(56, 0), int_c(56, 0), ~neg_c, true.B)

  // Trim the result
  (out_s, out_c) := (res_s(55, 26), res_c(55, 26))
}

// The component exposed to the pipeline
// Notes on flags:
// flags[0] specify if it is sqrt or div (1 if sqrt)
// flags[1] specify if this is a single or double precision (0 if single)
class DivSqrtSeed extends Module {
  val io = IO(new Bundle() {
    val in = Input(new FPPortIn())
    val out = Output(new FPPortOut())
  })

  val sign1 = Mux(io.in.flags(1), io.in.operand1(63), io.in.operand1(31))
  val sign2 = Mux(io.in.flags(1), io.in.operand2(63), io.in.operand2(31))

  // Sign
  val out_sign = sign1 ^ sign2
  // Exponent
  val op1_exp = ExtractExp(io.in.flags(1), io.in.operand1, io.in.operand1_fp)
  val op2_exp = ExtractExp(io.in.flags(1), io.in.operand2, io.in.operand2_fp)
  val div_exp_core = Module(new ExpAdder())
  div_exp_core.io.is_double := io.in.flags(1)
  div_exp_core.io.subtract := true.B
  div_exp_core.io.a := op1_exp
  div_exp_core.io.b := op2_exp
  val sqrt_exp_core = Module(new ExpDiv2())
  sqrt_exp_core.io.in := op1_exp
  val exp_res = Mux(io.in.flags(0), sqrt_exp_core.io.out, div_exp_core.io.out)
  // Special value, ordered by their priority: (D means DIV, S means SQRT)
  // (D + S) If any operand is NaN, NaN. Exception if signaling.
  // (S) If op1 is negative and zero, zero (negative).
  // ==================
  // (D) If op2 is zero, inf. Exception if op1 is not inf.
  // (S) If op1 is negative, NaN. Exception.
  // ==================
  // (D) If op1 is infinity, and op2 is also infinity, NaN. Exception.
  // (D) If op2 is infinity, zero.
  // ==================
  // (D + S) If op1 is zero, zero.
  // (D + S) If op1 is infinity, infinity.
  val nan1 = IsNaN(io.in.flags(1), io.in.operand1, io.in.operand1_fp)
  val nan2 = IsNaN(io.in.flags(1), io.in.operand2, io.in.operand2_fp)
  val zero1 = IsZero(io.in.flags(1), io.in.operand1, io.in.operand1_fp)
  val zero2 = IsZero(io.in.flags(1), io.in.operand2, io.in.operand2_fp)
  val inf1 = IsInf(io.in.flags(1), io.in.operand1, io.in.operand1_fp)
  val inf2 = IsInf(io.in.flags(1), io.in.operand2, io.in.operand2_fp)
  val signaling1 = nan1 &
    ~Mux(io.in.flags(1), io.in.operand1(51), io.in.operand1(22))
  val signaling2 = nan2 &
    ~Mux(io.in.flags(1), io.in.operand2(51), io.in.operand2(22))

  // This field does not cover the case of signaling NaNs.
  val invalid_op = (io.in.flags(0) & ~zero1 & sign1) | // sqrt(-x)
    (~io.in.flags(0) & inf1 & inf2) // inf / inf.
  val nan_generate = nan1 | nan2 | invalid_op
  val inf_generate = ((zero2 & ~io.in.flags(0)) | // x / 0.
    (~io.in.flags(0) & div_exp_core.io.of) | // Exponent-generated
    inf1) & ~nan_generate // op1 = inf
  val zero_generate = ((zero1 & io.in.flags(0)) | // sqrt(0)
    (~io.in.flags(0) & div_exp_core.io.uf) | // exponent_generated
    (inf2 & ~io.in.flags(0))) & ~nan_generate // 0 / x.
  val denorm_generate = div_exp_core.io.denorm & ~io.in.flags(0) &
    ~nan_generate & ~inf_generate & ~zero_generate

  // Exception detection
  io.out.fflags(4) := invalid_op | signaling1 | signaling2 // NV
  io.out.fflags(3) := zero2 & ~io.in.flags(0) & ~inf1 & ~inf2 // DV
  io.out.fflags(2) := false.B // Not possible for DIV/SQRT
  io.out.fflags(1) := uf
  io.out.fflags(0) := 0 // Not known yet

  // Encoding

  val flag_field_enable = nan_generate | inf_generate | zero_generate |
    denorm_generate
  val special_val_flags = Wire(UInt(7.W))
  // Correspond to flags(1)
  special_val_flags(0) :=

  val core = Module(new DivSqrtSeedMantissa())
  core.io.is_sqrt := io.in.flags(0)
  core.io.sqrt_2 := io.in.
  core.io.in := Cat(true.B, io.in.operand2(51, 0))

  // The output of this component has a special format.
  // See the docs/fp_internal_repr.md for more information.
  io.out.output1(63, 59) := Cat(out_sign, out_exp(10, 7))
  io.out.output1(58, 30) := core.io.out_s(28, 0)
  io.out.output1(29) := core.io.out_c(29) | core.io.out_s(29)
  io.out.output1(28, 0) := core.io.out_c(28, 0)
  io.operand1_fp(0) := fpflags_enable
  io.operand1_fp(7, 1) := Mux(fpflags_enable, special_val_flags, out_exp(6, 0))
}
