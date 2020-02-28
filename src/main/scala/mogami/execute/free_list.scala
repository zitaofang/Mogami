package mogami.execute

import chisel3._
import chisel3.util._

// The free entry list associated to each register bank
class FreeListBank extends Module {
  val io = IO(new Bundle() {
    val flush_req = Irrevocable(DontCare)
    val alloc_reg = Irrevocable(UInt(6.W))
    val free_reg = Flipped(Irrevocable(UInt(6.W)))
  })

  // Once the reset signal from the Rename Flush Controller
  // arrives, reset all state elements.
  withReset(reset.toBool() | io.flush_req.ready) {
    // Used for reset; If the list_reset is set, this list
    // has been reset, and it should supply the value of this counter
    // instead of the queue output
    val list_reset = RegInit(true.B)
    val (reset_counter, wrapped) = Counter(list_reset & io.alloc_reg.ready, 64)
    list_reset := ~wrapped & list_reset

    // The queue
    val queue_input = Flipped(Irrevocable(UInt(6.W)))
    queue_input <> io.free_reg
    val queue_output = Irrevocable(UInt(6.W))
    queue_output <> Queue.irrecovable(queue_input, 32)

    // Conect output
    // If list_reset is set, use the counter as the output and stop
    // removing data from the queue
    io.alloc_reg.bits := Mux(list_reset, reset_counter, queue_output.bits)
    io.alloc_reg.valid := list_reset | queue_output.valid
    queue_output.ready := ~list_reset & io.alloc_reg.ready

    // FLush the rename table if one queue become empty or full
    val flush_control = RegInit(false.B)
    flush_control := flush_control |
      ~(queue_output.valid | list_reset) | ~queue_input.ready
    io.flush_req.valid := flush_control
  }
}

// The free list
class FreeList extends Module {
  val io = IO(new Bundle() {
    val flush_req = Irrevocable(DontCare)
    val alloc_reg = Vec(4, Irrevocable(UInt(6.W)))
    val free_reg = Vec(4, Flipped(Irrevocable(UInt(6.W))))
  })

  // Simply connect all the ports to the banks
  val banks = List.fill(4)(Module(new FreeListBank()))
  for ((bank, index) <- banks.zipWithIndex) {
    bank.io.flush_req <> io.flush_req;
    bank.io.alloc_reg <> io.alloc_reg(index)
    bank.io.free_reg <> io.free_reg(index)
  }
}
