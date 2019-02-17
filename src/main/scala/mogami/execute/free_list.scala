package mogami.execute

import chisel3._
import chisel3.util._

// The free entry list associated to each register bank
class FreeListBank extends Module {
  val io = IO(new Bundle() {
    val flush_req = Irrevocable(DontCare)
    val alloc_reg = Irrevocable(UInt(6.W))
    val free_reg = Filpped(Irrevocable(UInt(6.W)))
  })

  // Once the reset signal from the Rename Flush Controller
  // arrives, reset all state elements.
  withReset(reset.toBool() | io.flush_req.ready) {
    // Used for reset; If the MSB (bit 6) is not set, this list
    // has been reset, and it should supply the value of this counter
    // instead of the queue output
    val list_reset = Wire(Bool())
    val (reset_counter, wrapped) = Counter(~list_reset, 64)
    list_reset := wrapped

    // The queue
    val queue_input = Filpped(Irrevocable(UInt(6.W)))
    queue_input <> io.free_reg
    val queue_output = Irrevocable(UInt(6.W))
    queue_output <> Queue.irrecovable(queue_input, 32)

    // FLush the rename table if one queue become empty or full
    io.flush_req.valid := ~queue_output.valid | queue_input.ready
  }
}

// The free list
class FreeList extends Module {
  val io = IO(new Bundle() {
    val flush_req = Irrevocable(DontCare)
    val alloc_reg = Vec(4, Irrevocable(UInt(6.W)))
    val free_reg = Vec(4, Filpped(Irrevocable(UInt(6.W))))
  })


}
