import chisel3._
import chisel3.util._

class CompoundAdder extends Module {
  val io = IO(new Bundle{
    val a = Input(UInt(64.W))
    val b = Input(UInt(64.W))
    val s0 = Output(UInt(64.W))
    val s1 = Output(UInt(64.W))
  })

  
}
