package mogami.memory.reorder

import chisel3._
import chisel3.util._

// A cache that holding all pending store value. It is used to
// support bypassing and speculative loads.
// This cache is indexed by virtual address.
class PendingCache extends Module {
  val io = IO(new Bundle{
    val load = Input(LoadPortV)
    val store = Input(StorePortV)

    val load_data = Output(UInt(64.W))
    // Stall the reservation station if there is a store entry conflict
    // (two stores to different addresses with the same index)
    // or more than four pending stores for one address.
    val stall = Output(Bool)
    // Flush the pipeline if there is a speculative load conflict
    // (the address is read )
    val flush = Output(Bool)
  })
}
