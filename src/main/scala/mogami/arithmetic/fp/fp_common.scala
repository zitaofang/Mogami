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

// Extracting exponent from the internal representation.
//
object ExtractExp {
  def apply(in: UInt, flag: UInt) = {
    // Check the flag first: if the denorm bit is enabled,
    // use the denorm value; otherwise, use the default exponent.
    Mux(flag(1, 0).andR, Cat(16, 0))
  }
}
