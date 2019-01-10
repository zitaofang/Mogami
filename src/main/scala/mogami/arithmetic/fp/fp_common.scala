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

// Detect if a FP is a zero.
object IsZero {
  def apply(is_double: Bool, in: UInt, in_fp: UInt) = {
    val exp_msb = Mux(is_double, in(62), in(30))
    (in_fp(0) & ~in_fp(1) & ~exp_msb)
  }
}

// Detect if a FP is an inf.
object IsInf {
  def apply(is_double: Bool, in: UInt, in_fp: UInt) = {
    val exp_msb = Mux(is_double, in(62), in(30))
    (in_fp(0) & in_fp(1) & ~exp_msb)
  }
}

// The common data type for rounding bits
class RoundingBits extends Bundle {
  val guard = Bool
  val round = Bool
  val sticky = Bool
}

// Extracting exponent from the internal representation; 1 must be added to
// its output to recover the original value.
// This function always output in 2's complement format instead of biased.
object ExtractExp {
  def apply(is_double: Bool, in: UInt, in_fp: UInt) = {
    // Align it to 12-bit field so that denorms can be represented
    val d_normal_2c = Cat(Fill(2, ~in(62)), in(61, 52))
    val s_normal_2c = Cat(Fill(5, ~in(30)), in(29, 23))
    val d_denorm_2c = Cat("b'111111".U(6.W), ~in_fp(7, 2))
    val s_denorm_2c = Cat("b'1111111".U(7.W), ~in_fp(7, 3))

    val exp_msb = Mux(is_double, in(62), in(30))
    val is_denorm = in_fp(0) & in_fp(1) & ~exp_msb

    Mux(is_denorm,
      Mux(is_double, d_normal_2c, s_normal_2c),
      Mux(is_double, d_denorm_2c, s_denorm_2c)
    )
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
