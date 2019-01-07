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
    val in = Input(UInt(52.W))
    val out_s = Output(UInt(30.W))
    val out_c = Output(UInt(30.W))
  })

  // Read the memory (2 cycle delay)
  val lut = Module(new CoeffLUT())
  lut.io.clk := Module.clock
  lut.io.a := Cat(is_sqrt, in(51, 43))
  val mem_out = lut.io.spo

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
  val exp_table = VecInit(
    "b0000".U(4.W),
    "b0100".U(4.W),
    "b0101".U(4.W),
    "b1001".U(4.W),
    "b0101".U(4.W),
    "b1001".U(4.W),
    "b1101".U(4.W),
    "b1110".U(4.W)
  )
  val (c2_shamt, c1_shamt) = exp_table(Cat(io.is_sqrt, mem_out(63, 62)))
  val c0_shamt = io.in(51, 43).orR.asUInt

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

  // Shift
  // Here, the propagation tail is shifted in
  val raw_pos_pp =
    ((c2_pp zip (0 until 8)) map Cat(0.U(19.W),
      ShifterBlock(_, c2_shamt, true.B, (_ == 7).B)._1,
    0.U(7.U))) ++
    Cat(ShifterBlock(c0_pp, c0_shamt, true.B, false.B)._1, 0.U(26.W))
  val neg_pp =
    (c1_pp map Cat(0.U(10.W), ShifterBlock(_, c1_shamt, true.B, false.B)._1))

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
// Note: flags[0] specify if it is sqrt or div (1 if sqrt)
class DivSqrtSeed extends Module {
  val io = IO(new Bundle() {
    val in = Input(new FPPortIn())
    val out = Output(new FPPortOut())
  })

  // Sign
  val out_sign = io.in.operand1(63) ^ io.in.operand2(63)
  // Exponent
  // TODO implement this
  val out_exp = 0

  val core = Module(new DivSqrtSeedMantissa())
  core.io.is_sqrt := io.in.flags(0)
  core.io.in := Cat(true.B, io.in.operand2(51, 0))

  // The output of this component has a special format - see the code below
  // for more information.
  
}
