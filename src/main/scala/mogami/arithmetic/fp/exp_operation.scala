package mogami.arithmetic.fp

import chisel3._
import chisel3.util._

// This file implements two exponent operations used in the
// FPU: Add/subtract and divide by 2.

// Add and subtract of FP number.
class ExpAdder extends Module {
  val io = IO(new Bundle() {
    val is_double = Input(Bool)
    val subtract = Input(Bool)
    val a = Input(UInt(12.W))
    val b = Input(UInt(12.W))
    val out = Output(UInt(12.W))
    val of = Output(Bool)
    val uf = Output(Bool)
    val denorm = Output(Bool)
  })

  // Here, a 16-bit adder is used to add two exponent.
  val adder = Module(new Adder(2))
  adder.io.a := Cat(io.a, 0.U(4.W))
  adder.io.b := Cat(io.b ^ Fill(12, io.subtract), 0.U(4.W))

  // At the same time, determine if a carry-in is needed.
  adder.io.cin := ~io.subtract
  val out = adder.io.s
  io.out := out

  // Detect overflow, underflow and denorm generation
  val adder_overflow = adder.io.cout ^ adder.io.sign_c
  val bottom = Mux(is_double, -53.S(7.W).asUInt, -24.S(7.W).asUInt)
  val (lower_uf, _) = ComparatorBlock(out(5, 0), bottom(5, 0))
  io.of := ~out(11) & (out(10) | out(9, 1).andR) | // greater than 001111...11
    adder_overflow & out(11) // Arithmetic overflow to negative
  io.denorm := out(11) & (~out(10) | ~out(9, 0).orR)
  io.uf := (~out(9, 6).andR | lower_uf) & out(11) & ~out(10) | // lower than -52 or -23
    adder_overflow & ~out(11) // Arithmetic overflow to positive
}

// Divided by 2: used by subtract
class ExpDiv2 extends Module {
  val io = IO(new Bundle() {
    val in = Input(UInt(12.W))
    val out = Output(UInt(12.W))
    val sqrt_2 = Output(Bool)
  })
  // sqrt_2 = ~LSB, for the encoding is (2's complement) - 1
  // The exponent is odd if LSB is 0
  io.sqrt_2 := ~io.in(0)
  // Arithmetic right shift one bit
  val shift_res = Cat(io.in(11), io.in(11, 1))
  // Subtract 1 if the number is positive, and its original LSB is 0
  io.out := ~QuickPlusOne(~shift_res, ~io.in(11) & ~io.in(0))
}

// Calculating the absolute different of exponents
class AbsDiff extends Module {
  val io = IO(new Bundle{
    val a = Input(UInt(12.W))
    val b = Input(UInt(12.W))
    val lt = Output(Bool)
    val out = Output(UInt(12.W))
  })

  // Comparing
  val lt = ComparatorBlock(io.a, io.b)._1
  io.lt := lt

  // Subtracting
  val adder = Module(new CompoundAdder())
  adder.io.a = Cat(a, 0.U(4.W))
  adder.io.b = Cat(b, 0.U(4.W))
  io.out := Mux(lt, ~adder.io.s1, adder.io.s0)
}
object AbsDiff {
  def apply(a: UInt, b: UInt) = {
    val core = Module(new AbsDiff(a.getWidth))
    core.io.a := a
    core.io.b := b
    (core.io.lt, core.io.out)
  }
}
