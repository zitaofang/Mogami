import chisel3._
import chisel3.util._

// The 64 bits SD4 interface
class SD4Port extends Module {
  val sign = UInt(32.W)
  val nonzero = UInt(32.W)
  val shift = UInt(32.W)
}

// The multiple matrix
class Multiplier extends Module {
  val io = IO(new Bundle{
    val a = Input(UInt(64.W))
    val b = Input(SD4Port)
    val s = Output(UInt(128.W))
    val c = Output(UInt(128.W))
  })

  // 
}

// SD4 Recoder Core
class SD4RecoderCore extends Module {
  val io = IO(new Bundle{

  })
}

// SD4 2's complement recoder

// SD4 carry-save recoder
