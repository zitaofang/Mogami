import chisel3._
import chisel3.util._

// The LZA module based on the following literature:
// Quinnell, Eric, Earl E. Swartzlander, and Carl Lemonds.
//    "Floating-point fused multiply-add architectures."
//    In Signals, Systems and Computers, 2007. ACSSC 2007.
//    Conference Record of the Forty-First Asilomar Conference on, pp. 331-337.
//    IEEE, 2007.
// See page 28 (Section 2.9) for more information.
