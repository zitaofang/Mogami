package mogami.arithmetic.fp

import chisel3._
import chisel3.util._
import mogami.arithmetic.FUPortIn
import mogami.arithmetic.FPPortOut
import mogami.arithmetic.integer.SimpleShifter

// classify the FP and set the corresponding auxiliary bits.
// This is not FCLASS implementation: for its implemention, see "single_cycle.scala".
// All function moving some numbers from anywhere beside an FP registers or
// functional units will need to go through this unit to fill in the flag field.
// flags[0] is 1 if double.
class FPAuxClass extends Module {
  val io = IO(new Bundle{
    val in = Input(new FUPortIn())
    val out = Output(new FPPortOut())
  })

  // Detect MSB for denorm
  val denorm_shamt = PriorityEncoder(Reverse(Mux(io.in.flags(0),
    Cat(io.in.operand1(51, 0), 0.U(12.W)),
    Cat(io.in.operand1(22, 0), 0.U(41.W))
  )))
  // Exponent special value
  val exp_0 = ~Mux(io.in.flags(0),
    io.in.operand1(62, 52).orR,
    io.in.operand1(30, 23).orR
  )
  val exp_1 = Mux(io.in.flags(0),
    io.in.operand1(62, 52).andR,
    io.in.operand1(30, 23).andR
  )
  // Fraction special value
  val fra_0 = ~Mux(io.in.flags(0),
    io.in.operand1(62, 52).andR,
    io.in.operand1(30, 23).andR
  )
  // Encode flags
  io.out.output1_fp := EncodeFlags(io.in.flags(0),
    exp_1 & ~fra_0,
    exp_1 & fra_0,
    exp_0 & fra_0,
    exp_0 & ~fra_0,
    denorm_shamt
  )

  // Shift the mantissa
  val denorm_en = exp_0 & ~fra_0
  val shamt = Fill(6, denorm_en) & denorm_shamt
  when (io.in.flags(0)) {
    io.out.output1(63, 52) := io.in.operand1(63, 52)
    io.out.output1(51, 0) :=
      SimpleShifter(io.in.operand1(51, 0), shamt, false.B)
  } .otherwise {
    io.out.output1(63, 32) := ~0.U(32.W)
    io.out.output1(31, 23) := io.in.operand1(31, 23)
    io.out.output1(22, 0) :=
      SimpleShifter(io.in.operand1(22, 0), shamt(4, 0), false.B)
  }

  // Pull other output
  io.out.output1_en := io.in.enable
  io.out.output2 := 0.U(64.W)
  io.out.output2_en := false.B
  io.out.output2_fp := 0.U(8.W)
  io.out.fflags := 0.U(5.W)
}
