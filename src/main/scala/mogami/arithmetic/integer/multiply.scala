import chisel3._
import chisel3.util._

// The multiple matrix
class Multiplier extends Module {
  val io = IO(new Bundle{
    val a = Input(UInt(64.W))
    val b = Input(SD4Port)
    val compensate = Input(Bool)
    val s = Output(UInt(128.W))
    val c = Output(UInt(128.W))
  })

  // Generate partial product
  
}
