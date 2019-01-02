package mogami.arithemetic.fp

import chisel3._
import chisel3.util._

// Common component used to check the NaN Boxing
def isNaNBoxed(in: UInt(64.W)) =
  in(63:32).andR

// The common data type for rounding bits
class RoundingBits extends Bundle {
  val guard = Bool
  val round = Bool
  val sticky = Bool
}
