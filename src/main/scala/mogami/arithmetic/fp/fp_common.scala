package mogami.arithemetic.fp

import chisel3._
import chisel3.util._

// Detect if a FP is an NaN.
object IsNaN {
  def apply(is_double: Bool, in: UInt, in_fp: UInt) = {
    val d_nan = in(62) & (in_fp(1) | in_fp(4))
    val s_nan = ~in(62) | in_fp(2) | in(30) & in_fp(1)
    Mux(is_double, d_nan, s_nan)
  }
}

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


// Calculating the absolute different of exponents
class AbsDiff extends Module with BaseComparator {
  val io = IO(new Bundle{
    val a = Input(UInt(12.W))
    val b = Input(UInt(12.W))
    val lt = Output(Bool)
    val out = Output(UInt(12.W))
  })

  // Comparing
  val width_exp = 4
  val padding = pow(2, width_exp).intValue - width
  def comp_op1 = Cat(io.a, 0.U(padding.W))
  def comp_op2 = Cat(io.b, 0.U(padding.W))
  io.lt := lt

  // Subtracting

}
object AbsDiff {
  def apply(a: UInt, b: UInt) = {
    val core = Module(new AbsDiff(a.getWidth))
    core.io.a := a
    core.io.b := b
    (core.io.lt, core.io.out)
  }
}
