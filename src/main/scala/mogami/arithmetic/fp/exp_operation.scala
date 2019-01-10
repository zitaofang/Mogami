package mogami.arithmetic.fp

import chisel3._
import chisel3.util._

// This file provide some common exponent operation.
object ExpSubtract {
  def apply(a: UInt, b: UInt) = {
    val core = Module(new Adder(2))
    core.io.a := Cat(a(11), a(10, 0), 0.U(4.W))
    core.io.b := Cat(~b(11), ~b(10, 0), 0.U(4.W))
    core.io.cin := true.B

    val adder_overflow = core.io.s(15) ^ core.io.s(14)

    // (result, overflow, underflow)
    (core.io.s, adder_overflow & core.io.s(15), adder_overflow & ~core.io.s(15))
  }
}

// Divided by 2: used by subtract
object ExpDiv2 {
  def apply(a: UInt) = {
    val res = Wire(UInt(12.W))
    // Shift one bit
    res(8, 0) := a(9, 1)
    // If not denorm (a[11] set), then shift the inverse of a(10) in; otherwise, 0
    res(9) := ~a(11) & ~a(10)
    // If denorm, clear bit 10; otherwise, keep the original value
    res(10) := ~a(11) & a(10)
    // If denorm, sqrt makes it no longer subnormal; if not denorm, bit 11 is 0.
    res(11) := false.B

    res
  }
}

// Detect underflow
object UnderflowDetect {
  def apply(is_double: Bool, exp: UInt) = {
    val bottom = Mux(is_double, -53.S(6.W).asUInt, -24.S(6.W).asUInt)
    // Check the upper half.
    // If a
  }
}
