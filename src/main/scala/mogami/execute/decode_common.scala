package mogami.execute

import chisel3._
import chisel3.util._

// The operand representation in decode pipeline
class DecodeOperand extends Bundle {
  val data = UInt(64.W)
  val present = Bool
}