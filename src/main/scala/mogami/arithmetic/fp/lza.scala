import chisel3._
import chisel3.util._

// The LZA module based on the following literature:
// Quinnell, Eric, Earl E. Swartzlander, and Carl Lemonds.
//    "Floating-point fused multiply-add architectures."
//    In Signals, Systems and Computers, 2007. ACSSC 2007.
//    Conference Record of the Forty-First Asilomar Conference on, pp. 331-337.
//    IEEE, 2007.
// See page 28 (Section 2.9) for more information.

def lza(a_in: UInt, b_in: UInt, c_in: UInt) = {
  // The comparison result will be used to select the result.
  val res = Vec(2, UInt(6.W))
  // The not yet encoded result.
  val res_unencoded = Vec(2, UInt(64.W))

  // The paper need the two bits higher than the MSB to calculate
  // indicators. Here is the augumented input with those two bits.
  val a = Cat(0.U(2.W), a_in)
  val b = Cat(0.U(2.W), b_in)
  val c = Cat(0.U(2.W), c_in)

  // See the paper for their meaning.
  val s = ~a & ~b & c
  val e = (~a & ~b & ~c) | ((a ^ b) & c)
  val t = a & b & ~c
  val w = a ^ b ^ c
  val x = (a & b) | ((a | b) & ~c)
  res_unencoded(0) := (e & (t >> 1)) | (w & (e >> 1)) | ((w >> 1) & (x >> 2))(63, 0)
  res_unencoded(1) := (s & ~(x >> 1)) | (~w & (t >> 1))(63, 0)

  res(0) := PriorityEncoder(res_unencoded(0))
  res(1) := PriorityEncoder(res_unencoded(1))

  res
}
