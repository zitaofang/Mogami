package mogami.execute

import chisel3._
import chisel3.util._

// The data bundle of reg read address in internal representation.
// It contains a index field so that it can be unfolded after
// reading data.
class ReadAddr extends Bundle {
  val addr = UInt(6.W)
  val ind = UInt(4.W)
}
object ReadAddr {
  def apply(addr: UInt, ind: UInt) = {
    val res = Wire(new ReadAddr())
    res.addr := addr
    res.ind := ind
    res
  }
  def empty = apply(0.U(6.W), 0.U(4.W))
}
// The definition of queue entry of the read request queue
type QueueEntry = Valid[Vec[ReadAddr]]
object QueueEntry {
  def apply() = Valid(Vec(3, new ReadAddr()))
  def apply(valid: Bool(), bits: Vec[ReadAddr]) = {
    val res = Valid(Vec(3, new ReadAddr()))
    res.valid := valid
    res.bits := bits
    res
  }
  def empty = apply(false.B, VecInit(List().padTo(3, ReadAddr.empty)))
}

// =======================

// Register file bank, (32 * (64 + 8) bits) * 2
// One bank support 4 read port and 1 write port.
// It has two sections and can switch between them. This is used
// during the Rename Table Flush. The same machenism can be used
// to achieve bank switching, but RISC-V does not support it at this time.
// (Actually there is four copies of the data in one bank)
class RegFileRawRAM extends Module {
  val io = IO(new Bundle() {
    val read_bank = UInt(1.W)
    val read_addr = Vec(4, Flipped(Valid(UInt(6.W))))
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
// The bank control circuit
class RegFileRAM(i: Int) extends Module {
  val io = IO(new Bundle() {
    // The global ready bit: it depends on other banks' states
    // rather than the RegFile input.
    val global_ready = Input(Bool())
    // The local ready bits.
    val local_ready = Output(Bool())
    val read_in = Vec(4, Vec(3, Flipped(Valid(new Operand()))))

  })

  val core = Module(new RegFileRawRAM())

  // ===========================
  // Read address control

  // Concatenate read_in into one-dimension array
  val read_in_cat = (io.read_in flatMap _).zipWithIndex

  val filtered = read_in_cat map (req, ind) => {
    // To keep the interface simple, I will still use Operand class
    // here, but there will be some modification:
    // 1. "present" bit is now the valid bits.
    // 2. The lower 6 bits of "value" field is now the register
    // address (without the bank address part).
    // 3. "tag" is now holding the index of the current value in
    // "read_in" vector.
    val filtered_val = Wire(new Operand())

    // Check the following to get rid of invalid read:
    // 1. the bank address doesn't match.
    // 2. the data bundle itself is invalid. (see "valid" bit)
    // 3. "present" is 0 (waiting for other inst) or tag(9) is 0
    // (an immediate).
    val valid = req.valid & req.bits.tag(7, 6) === i.U(2.W) &
      req.bits.present & req.bits.tag(9)

    // copy value to the new result, following the encoding above
    filtered_val.present := valid
    filtered_val.tag := Cat(0.U(6.W), ind.U(4.W))
    filtered_val.value := Cat(0.U(58.W), req.bits.tag(5, 0))
    filtered_val.fp_flag := 0.U(8.W)

    // Output, with a copy of valid bit
    (valid, filtered_val)
  }

  // Compress accesses
  val compress_out = CompressValid(filtered, FillZero(new Operand()))
  // Grouped compressor output into 3 groups so that it can
  // fit into the queue
  val grouped_compressed = (compress_out grouped 4) map g => {
    val ret = Wire(Valid(Vec(4, new Operand())))
    // Reduce-or all valid bits in this group as the entry valid bit
    ret.valid := (g map _._1) reduceLeft (_ | _)
    // Extract the ReadAddr
    ret.bits := g map _._2

    ret
  }

  // The queue with 3 entries
  val addr_queue = Vec(3, RegInit(
    FillZero(Vec(4, Valid(new Operand())))
  ))
  // If Entry 1 or 2 is valid, stall the fetch
  io.local_ready := ~addr_queue(2).valid & ~addr_queue(1).valid

  when (io.global_ready) {
    // If the queue has something inside, shift it
    addr_queue(2) := FillZero(Valid(Vec(4, new Operand())))
    addr_queue(1) := addr_queue(2)
    addr_queue(0) := addr_queue(1)
  } .otherwise {
    // Put the compressed data into the queue
    (addr_queue zip grouped_compressed) map _ := _
  }

  // connect addresses to the RAM
  (core.io.read_addr zip addr_queue(0)) map (ra, q) => {
    ra.valid := q.valid
    ra.bits := q.bits
  }

  // Send the queue entry valid bits to the read data control stage
  val valid_reg = RegNext(VecInit(addr_queue map _.valid).reverse)
  // Also, save the current entry to replace in the next step
  val current_entry = RegNext(addr_queue(0))

  // ===========================================
  // Read data control

  // The read data queue
  val data_queue = RegInit(FillZero(Valid(Vec(4, new Operand()))))

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

// The register file component
class RegFile extends Module {
  val io = IO(new Bundle() {
    val ready = Output(Bool())
    val read_in = Vec(4, Vec(3, Flipped(Valid(new Operand()))))
    val read_out = Vec(4, Vec(3, Valid(new Operand())))
    val write = Vec(4, Flipped(Valid(new WritePack())))
  })

  val banks = (0 until 4) map Module(new RegFileBank())
  val free_lists = (0 until 4) map Module(new RegBankFreeList())
  // A global ready bit
  val ready_bits = Wire(Vec(4, Bool()))
  val ready = ready_bits.orR

  for (i <- 0 until 4) {

  }

}
