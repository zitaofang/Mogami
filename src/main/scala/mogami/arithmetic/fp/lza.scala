import chisel3._
import chisel3.util._

// The LZA module based on the following literature:
// Quinnell, Eric, Earl E. Swartzlander, and Carl Lemonds.
//    "Floating-point fused multiply-add architectures."
//    In Signals, Systems and Computers, 2007. ACSSC 2007.
//    Conference Record of the Forty-First Asilomar Conference on, pp. 331-337.
//    IEEE, 2007.
// See page 28 (Section 2.9) for more information.

def lza(a_in: UInt, b_in: UInt) = {
  // Prepare
  val t = io.a_in ^ io.b_in
  val g = io.a_in & io.b_in
  val z = ~io.a_in & ~io.b_in

  // Calculate
  val raw_f = Wire(UInt(64.W))
  raw_f := (t << 1) & (g & ~(z >> 1) | z & ~(g >> 1)) |
    ~(t << 1) & (z & ~(z >> 1) | g & ~(g >> 1))
  val f = Cat(raw_f(63, 1), ~t(0) & t(1))

  // Encode and return
  PriorityEncoder(Reverse(f))
}
