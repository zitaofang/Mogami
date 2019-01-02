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

// The component
class DivSqrtSeed extends Module {
  val io = IO(new Bundle{
    val enable = Input(Bool)
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

  // Generate Unaligned, unshifted PP
  
}
