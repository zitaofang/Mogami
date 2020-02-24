package mogami.arithmetic.fp

import chisel3._
import chisel3.util._
import mogami.arithmetic.FPPortIn
import mogami.arithmetic.FPPortOut

// The complete FMA unit exposed to the pipeline, with multiple entrances.
class FMA extends Module {
  val io = IO(new Bundle() {
    // Multiplication / FMA entrance
    val fma_mul_in = Input(new FPPortIn())
    val fma_mul_busy = Output(Bool())
    // FP add entrances
    val fadd_in = Input(new FPPortIn())
    val fadd_busy = Output(Bool())
    // Int add entrances
    val intadd_in = Input(new FPPortIn())
    val intadd_busy = Output(Bool())
    // output
    val out = Output(new FPPortOut())
  })


}
