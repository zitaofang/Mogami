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

// The register file component
class RegFile extends Module {
  val io = IO(new Bundle() {
    val read_in = Vec(4, Vec(3, Flipped(Irrevocable(new Operand()))))
    val read_out = Vec(4, Vec(3, Valid(new Operand())))
    val write = Vec(4, Flipped(Valid(new WritePack())))
  })

  val banks = (0 until 4) map Module(new RegFileBank())
  val free_lists = (0 until 4) map Module(new RegBankFreeList())

  // The index is also zipped into the compressor input so that
  // it can be recover after read
  class Compressed extends Bundle {
    val addr = UInt(6.W)
    val ind = UInt(4.W)
  }
  object Compressed {
    def apply(addr: UInt, ind: UInt) = {
      val res = Wire(new Compressed())
      res.addr := addr
      res.ind := ind
      res
    }
    def empty = apply(0.U(6.W), 0.U(4.W))
  }
  // Group the access to each bank
  val read_in_cat = (io.read_in flatMap _).zipWithIndex
  val bank_access = (0 until 4) map i => read_in_cat map (req, j) => {
    val valid = req.valid & req.bits.tag(7, 6) === i.U(2.W) &
      req.bits.present
    (valid, Compress(req.bits.tag(5, 0), j.U(4.W)))
  }
  // Compress accesses
  val compressed = bank_access map CompressValid(_, Compressed.empty)

  // The queue with 3 entries
  // First, the entry
  class QueueEntry extends Bundle {
    val valid = Bool
    val bits = Vec(3, new Compressed())
  }
  object QueueEntry {
    def apply(valid: Bool, bits: Vec[Compressed]) = {
      val res = Wire(new QueueEntry())
      res.valid := valid
      res.bits := bits
      res
    }
    def empty = apply(false.B, VecInit(List().padTo(3, Compressed.empty)))
  }
  // Then, the queue itself
  val queue = List().padTo(3, RegInit(Vec(4, new QueueEntry())))
  // If Entry 1 or 2 is valid, stall the fetch
  val ready = ~VecInit((queue(2) ++ queue(1)) map _.valid).orR
  io.read_in map (_ map (_.ready := ready))

  when (ready) {
    // If the queue has something inside, shift it
    queue(2) := QueueEntry.empty
    queue(1) := queue(2)
    queue(0) := queue(1)
  } .otherwise {
    // Put the compressed data into the queue
  }

}
