import chisel3._
import chisel3.util._

// classify the FP and set the corresponding auxiliary bits.
// This is not FCLASS implementation: for its implemention, see "logic_gate.scala".
// All function moving some numbers from anywhere beside an FP registers or
// functional units will need to go through this unit to fill in the
class FPAuxClass extends Module {
  val io = IO(new Bundle{
    val input = Input(FPPortIn)
    val output = Output(FPPortOut)
  })
  // Now, the temporary internal encoding for FP consist of two parts:
  // the flags field (8 bits) and the IEEE encoding field (64 bits),
  // except for denorm: for denorm, the mantissa follows the
  // normalized number encoding, and the exponent is 0.
  // The actual exponent is stored in the flag field.

}
