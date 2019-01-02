package mogami.arithmetic.fp.fma

import chisel3._
import chisel3.util._

// Shift and CSA stage
class OPShiftCSA extends Module {
  val io = IO(new Bundle{
    val m = Input(CarrySave(106))
    val a = Input(UInt(53.W))
    val out = Output(CarrySave(161))
    val negated = Output(CarrySave(161))
    val rounding = Output(RoundingBits)
    // Control bits
    val exp_diff = Input(UInt(7.W))
    val exp_comp = Input(Bool) // True if matrix output is greater
  })

  // Shift the operand
  
}
