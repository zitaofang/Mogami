import chisel3._
import chisel3.util._

// The standard port definition for functional units
class FUPortIn extends Bundle {
  // Enable bit
  val enable = Bool
  // Operand #1
  val operand1 = UInt(64.W)
  // Operand #2
  val operand2 = UInt(64.W)
  // flags
  val flags = UInt(4.W)
}
class FUPortOut extends Bundle {
  // Output #1
  val output1 = UInt(64.W)
  // Output #1 enable
  val output1_en = Bool
  // Output #2 (optional)
  val output2 = UInt(64.W)
  // Output #2 enable
  val output2_en = Bool
  // Busy
  val busy = Bool
  // exception
}
// Extended FP ports
class FPPortIn extends FUPortIn {
  // FP rounding mode input
  val rm_dynamic = UInt(3.W)
  // FP extra encoding info
  val operand1_fp = UInt(8.W)
  val operand2_fp = UInt(8.W)
}
class FPPortOut extends FUPortOut {
  // FP extra encoding info
  val output1_fp = UInt(8.W)
  val output2_fp = UInt(8.W)
  // fflags CSR output
  val fflags = UInt(5.W)
}
