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
  val guard = Bool()
  val round = Bool()
  val sticky = Bool()
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

// Encoding exp format for computation into the internal format.
// This component will handle overflow and underflow.
object EncodeExp {
  class Result extends Bundle {
    val exp_field = UInt(11.W)
    val flag_exp = UInt(6.W)
    val overflow = Bool()
    val underflow = Bool()
    val denorm = Bool()
  }
  def apply(is_double: Bool, in: UInt) = {
    val res = new Result()

    // Detect overflow, underflow and denorm generation
    val bottom = Mux(is_double, -53.S(7.W).asUInt, -24.S(7.W).asUInt)
    val (lower_uf, _) = ComparatorBlock(in(5, 0), bottom(5, 0))
    // overflow if greater than 001111...11
    res.overflow := ~in(11) & (in(10) | in(9, 1).andR)
    // underflow if lower than -52 or -23
    res.underflow := (~in(9, 6).andR | lower_uf) & in(11) & ~in(10)
    res.denorm := in(11) & ((~in(10) & ~lower_uf) | ~in(9, 0).orR)

    // Encoding exponent
    res.exp_field := in(10, 0)
      ^ Cat(true.B, Fill(2, is_double), 0.U(7.W)) // Filp sign
      & Fill(11, ~(res.underflow & res.denorm)) // Clear all bits if underflow/denorm
      | Fill(11, res.overflow) // Set all bits if overflow
    res.flag_exp := ~in(5, 0) & Fill(6, res.denorm) | Cat(is_double, 0.U(5.W))
  }
}

// Encoding flags according to regular encoder format.
object EncodeFlags {
  def apply(is_double: Bool, nan: Bool, inf: Bool, zero: Bool, denorm: Bool,
    denorm_exp: UInt) = {
      val denorm_exp_shifted =
        Mux(is_double, denorm_exp, Cat(denorm_exp(4, 0), false.B))
      val out = Wire(UInt(8.W))
      val special_val = nan | inf | zero | denorm
      out(0) := special_val
      out(1) := denorm | nan | ~is_double & ~inf & ~zero
      out(2) := Mux(denorm & is_double, denorm_exp_shifted(0), is_double)
      out(3) := Mux(denorm, denorm_exp_shifted(1), ~is_double)
      out(7, 4) := Fill(4, denorm) & denorm_exp(5, 2)
      out
    }
}
