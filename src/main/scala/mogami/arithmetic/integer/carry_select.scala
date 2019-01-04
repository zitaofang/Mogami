import chisel3._
import chisel3.util._

class CompoundAdder(width: Int) extends Module {
  val io = IO(new Bundle{
    val a = Input(UInt(width.W))
    val b = Input(UInt(width.W))
    val s0 = Output(UInt(width.W))
    val s1 = Output(UInt(width.W))
  })


}
