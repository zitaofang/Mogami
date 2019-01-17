package mogami.execute

import chisel3._
import chisel3.util._

// Register file bank, (32 * (64 + 8) bits) * 2
// One bank support 4 read port and 1 write port.
// It has two sections and can switch between them. This is used
// during the Rename Table Flush. The same machenism can be used
// to achieve bank switching, but RISC-V does not support it at this time.
// (Actually there is four copies of the data in one bank)
class RegFileBank extends Module {
  val io = IO(new Bundle() {
    val read_bank = UInt(1.W)
    val read_addr = Vec(4, Valid(UInt(6.W)))
    val read_data = Output(UInt(72.W))
    val write = Valid(new Bundle() {
      val bank = UInt(1.W)
      val addr = UInt(6.W)
      val data = UInt(72.W)
    })
  })

  val mems = (0 until 4) map SyncReadMem(64, UInt(72.W))
  (mems zip io.read_addr) map (m, r) => {
    // Set up register read
    io.read_data := m.read(Cat(io.read_bank, r.bits), r.valid)
    // Write
    m.write(Cat(io.write.bank, io.write.addr), io.write.data)
  }
}

// The associated free entry list
class RegBankFreeList extends Module {
  val io = IO(new Bundle() {
    val flush_req = Irrevocable(DontCare)
    val alloc_reg = Irrevocable(UInt(6.W))
    val free_reg = Filpped(Irrevocable(UInt(6.W)))
  })

  // Once the reset signal from the Rename Flush Controller
  // arrives, reset all state elements.
  withReset(reset.toBool | io.flush_req.ready) {
    // Used for reset; If the MSB (bit 6) is not set, this list
    // has been reset, and it should supply the value of this counter
    // instead of the queue output
    val list_reset = Wire(Bool)
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
