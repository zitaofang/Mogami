package mogami.memory

import chisel3._
import chisel3.util._

// The load request port for virtual address
class LoadPortV extends Bundle {
  val en = Bool // a request is received
  val addr = UInt(64.W)
}

// The store request port for virtual address
class StorePortV extends Bundle {
  val en = Bool
  val addr = UInt(64.W)
  val data = UInt(64.W)
}
