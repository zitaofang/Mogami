package mogami.execute

import chisel3._
import chisel3.util._
import mogami.FillZero
import mogami.util.CompressValid
import mogami.util.DecompressValid

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
object RegFileUtil {
  type QueueEntry = Valid[Vec[ReadAddr]]
  object QueueEntry {
    def apply() = Valid(Vec(3, new ReadAddr()))
    def apply(valid: Bool, bits: Vec[ReadAddr]) = {
      val res = Valid(Vec(3, new ReadAddr()))
      res.valid := valid
      res.bits := bits
      res
    }
    def empty = apply(false.B, VecInit(List.fill(3)(ReadAddr.empty)))
  }
}

// =======================

// Register file bank, (32 * (64 + 8) bits) * 2
// One bank support 4 read port and 1 write port.
// It has two sections and can switch between them. This is used
// during the Rename Table Flush. The same machenism can be used
// to achieve bank switching, but RISC-V does not support it at this time.
// (Actually there is four copies of the data in one bank)
class RegFileRAM extends Module {
  val io = IO(new Bundle() {
    val read_bank = UInt(1.W)
    val read_addr = Input(Vec(4, new Operand()))
    val read_data = Output(Vec(4, new Operand()))
    val write = Valid(new Bundle() {
      val bank = UInt(1.W)
      val addr = UInt(6.W)
      val data = UInt(72.W)
    })
  })

  val mems = List.fill(4)(SyncReadMem(64, UInt(72.W)))
  (mems zip io.read_addr zip io.read_data) map (_ match { case ((m, r), o) => {
    // Set up register read
    // Special encoding of Operand() is used. See the top of the page
    // for comments.
    Cat(o.value, o.fp_flag) :=
      m.read(Cat(io.read_bank, r.value(5, 0)), r.present)

    // Fill in the rest of the structure
    o.present := r.present
    o.tag := r.tag

    // =======================================

    // Write.
    m.write(Cat(io.write.bits.bank, io.write.bits.addr), io.write.bits.data)
  }})
}
// The bank control circuit
class RegFileBank(i: Int) extends Module {
  val io = IO(new Bundle() {
    // The global ready bit: it depends on other banks' states
    // rather than the RegFile input.
    val global_ready = Input(Bool())
    // The local ready bits.
    val local_ready = Output(Bool())
    val read_in = Vec(4, Vec(3, Flipped(Valid(new Operand()))))
    val read_out = Vec(4, Vec(3, Valid(new Operand())))

    val write_in = Flipped(Valid(new RegWritePack()))
  })

  val core = Module(new RegFileRAM())

  // Setting up bank and flush


  // ===========================
  // Read address control

  // Concatenate read_in into one-dimension array
  val read_in_cat = (io.read_in flatMap (a => a)).zipWithIndex

  val filtered = read_in_cat map (_ match { case (req, ind) => {
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
  }})

  // Compress accesses
  val compress_out = CompressValid(filtered, FillZero(new Operand()))
  // Grouped compressor output into 3 groups so that it can
  // fit into the queue
  val grouped_compressed = (compress_out grouped 4) map (g => {
    val ret = Wire(Valid(Vec(4, new Operand())))
    // Reduce-or all valid bits in this group as the entry valid bit
    ret.valid := (g map _._1) reduceLeft (_ | _)
    // Extract the ReadAddr
    ret.bits := g map _._2

    ret
  })

  // The queue with 3 entries
  val addr_queue = Vec(3, RegInit(
    FillZero(Vec(4, Valid(new Operand())))
  ))
  // If Entry 1 or 2 is valid, stall the fetch
  io.local_ready := ~addr_queue(2).valid & ~addr_queue(1).valid

  when (~io.global_ready) {
    // If the queue has something inside, shift it
    addr_queue(2) := FillZero(Valid(Vec(4, new Operand())))
    addr_queue(1) := addr_queue(2)
    addr_queue(0) := addr_queue(1)
  } .otherwise {
    // Put the compressed data into the queue
    (addr_queue zip grouped_compressed) map ((a, b) => a := b)
  }

  // Mask bit: when a read request that is served within 1 cycle is
  // following a 3-cycle read request, the queue entry 2 and 1 should
  // not be read.
  // The mask should only be updated if the queue is filled with new
  // data.
  val mask_bit = RegEnable(grouped_compressed map (b => b.valid),
    io.global_ready)
  // Data queue pointer: mark the next entry of data queue after the
  // RAM is read.
  val data_queue_p = RegInit(1.U(3.W))
  when (~io.global_ready) {
    data_queue_p := data_queue_p << 1
  } .otherwise {
    data_queue_p := 1.U(3.W)
  }

  // ===========================================
  // RAM read

  // connect addresses to the RAM
  (core.io.read_addr zip addr_queue(0)) map (_ match { case (ra, q) => {
    ra.valid := q.valid
    ra.bits := q.bits
  }})

  // ===========================================
  // Read data control

  // The read data queue
  // The output of RAM will be put into the entry the pointer pointing to
  val data_queue = (0 until 3) map
    (i => RegEnable(core.io.read_data, data_queue_p(i)))
  // Decompress the output based on the index in the tag field
  // First, mask the tag field, and extract index
  val (masked_data, data_index) = ((data_queue flatMap (a => a)) map (c => {
    val md = Wire(Valid(new Operand()))
    val id = Wire(UInt(4.W))
    md.valid := c.valid
    md.bits.value := c.bits.value
    md.bits.fp_flag := c.bits.fp_flag
    md.bits.present := true.B
    md.bits.tag := UInt(10.W)
    id := c.bits.tag(3, 0)
    (md, id)
  })).unzip
  // Then, run through decompressor
  val decompressed = DecompressValid(masked_data, data_index)
  // and assign them to the io ports
  io.read_out <> RegNext(VecInit((decompressed grouped 4) map VecInit.apply))

  // ==========================================
  // Write control
  core.io.write.bits.addr := write_in.bits.addr
  core.io.write.bits.data := write_in.bits.value
  core.io.write.valid := write_in.valid & write_in.bits.write_en
}

// The register file component
class RegFile extends Module {
  val io = IO(new Bundle() {
    val ready = Output(Bool())
    val read_in = Vec(4, Vec(3, Flipped(Valid(new Operand()))))
    val read_out = Vec(4, Vec(3, Valid(new Operand())))
    val write = Vec(4, Flipped(Valid(new RegWritePack())))
  })

  val banks = List.fill(4)(Module(new RegFileBank()))

  // A global ready bit
  val local_ready = Wire(Vec(4, Bool()))
  val ready = local_ready.orR
  io.ready := ready
  // Connect ready bits
  (bank zip local_ready) map (_ match { case (b, r) => {
    r := b.io.local_ready
    b.io.global_ready := ready
  }})

  // Connect the read ports
  val bank_read_out = banks map (b => {
    b.io.read_in <> io.read_in
    b.io.read_out
  })
  // Mux the bank output
  val reg_read_out = Mux1H(bank_read_out map (o => (o.valid, o.bits)))

  // Masked those input operands that reqires a register read so
  // that it will not be selected at the end of the reg read
  val present_in = io.read_in map (in => {
    val read_en = in.valid & in.bits.present & in.bits.tag(9)
    Mux(read_en, FillZero(Valid(new Operand())), in)
  })
  // Delay the masked input until the operands from the RAM are ready
  val delayed_present_in = present_in map (p => Pipe(ready, p, 3))
  // Now, if the entry in present_in is valid, use the current value
  // otherwise, select the corresponding register read output
  for (i <- 0 until 12) {
    io.read_out(i) := Mux(delayed_present_in(i).valid,
      delayed_present_in(i),
      reg_read_out(i)
    )
  }

  // =====================================
  // Connect write wire
  for (i <- 0 until 4) {
    banks(i).io.write_in <> io.write(i)
  }
}
