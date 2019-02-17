package mogami.execute

import chisel3._
import chisel3.util._

// The reorder buffer line format
class ROBLine extends Bundle {
  val write_reg = UInt(6.W)
  val write_rename = UInt(8.W)
}

// The completion port data bundle
class CompletionBundle extends Bundle {
  val addr = UInt(8.W)
  val exception = Bool()
}

// The ROB bank; there are 4 in total.
// One bank has 64 entries.
class ROBBank(num: Int) extends Module {
  val io = IO(new Bundle() {
    // Dispatch port
    val dispatch = Flipped(Irrevocable(new ROBLine()))
    // The higher 6 bits of the inst#, valid when dispatch.ready is true
    val inst_no = Output(UInt(6.W))

    val commit = Irrevocable(new ROBLine())

    // Instruction completion
    val completion = Vec(4, Flipped(Vaild(new CompletionBundle())))

    // Report to the Controller that the instruction in this bank raise an
    // exception
    val except_detected = Output(Bool())
  })

  // The completion and exception bits
  val completion_bits = RegInit(0.U(64.W))
  val exception_bits = RegInit(0.U(64.W))

  // The head and tail counter
  val head = RegInit(0.U(6.W))
  val tail = RegInit(0.U(6.W))
  val head_after_tail = RegInit(Bool())
  // Assign the head index as inst#
  io.inst_no := head

  // The memory entries
  val mem_entries = Mem(64, new ROBLine())

  // Report exception if the instruction with the exception is
  // about to be commited
  io.except_detected := exception_bits(tail) & io.commit.ready

  // If head == tail, the queue is either full or empty
  val full_or_empty = head === tail
  val full = full_or_empty & head_after_tail
  val empty = full_or_empty & ~head_after_tail

  // Whether head_after_tail needs to be flipped
  val dispatch_flip = Wire(Bool())
  val commit_flip = Wire(Bool())

  // dispatch
  val dispatch_ready = io.dispatch.valid & ~full
  when (dispatch_ready) {
    mem_entries.write(head, io.dispatch.bits)
    val new_head = QuickPlusOne(head, true.B)
    head := new_head
    dispatch_flip := new_head(5) & ~head(5)
  } .otherwise {
    dispatch_flip := false.B
  }
  // commit
  val commit_ready = io.commit.ready & ~empty & completion_bits(tail)
  when (commit_ready) {
    io.commit.bits := mem_entries.read(tail)
    val new_tail = QuickPlusOne(tail, true.B)
    tail := new_tail
    commit_flip := new_tail(5) & ~tail(5)
  } .otherwise {
    commit_flip := false.B
  }
  // Update head_after_tail
  head_after_tail := head_after_tail ^ dispatch_flip ^ commit_flip

  // Set exception and comple bits
  val completion_mask = io.completion map (c =>
    UIntTo1H(c.bits.address(5, 0)) &
      Fill(64, c.valid & c.bits.address(7, 6) === num.U(2.W))
  ) reduceLeft (_ | _)
  val exception_mask = io.completion map (c =>
    UIntTo1H(c.bits.address(5, 0)) &
      Fill(64, c.valid & c.exception & c.bits.address(7, 6) === num.U(2.W)))
  ) reduceLeft (_ | _)
  // If commit, clear the completion bit the tail pointing to
  // (Clearing exception bit is not necessary as it will be reset)
  val completion_clear = ~UIntTo1H(tail)
  completion := completion | completion_mask & completion_clear
  exception := exception | exception_mask

  // Set valid and ready
  io.dispatch.ready := ~full
  io.commit.valid := ~empty & completion_bits(tail)
}

// The ROB rotator
object ROBRotator {
  class Slice(level: Int, in: SlicePort[ROBLine], shift: Bool)
  extends RotatorSlice[ROBLine] {
    override def mux_func = Mux(_, _, _)
    override def block_size = math.pow(2, level).intValue
    override def to_right = false.B
  }
  def apply(in: Seq[ROBLine], shamt: UInt) = {
    val slice = (level: Int) => (in: SlicePort[ROBLine]) =>
      new Slice(level, in, shamt(level)).result
    val tree = (0 until 2) map slice(_)
    (new SliceSimplePort(in) /: tree)(a, f => f(a)).data
  }
}

// The ROB
class ROB extends Module {
  val io = IO(new Bundle() {
    val dispatch = Vec(4, Flipped(Irrevocable(new ROBLine())))
    val inst_no = Vec(4, Output(UInt(8.W)))
    val commit = Vec(4, Irrevocable(new ROBLine()))
    val completion = Vec(4, Flipped(Vaild(new CompletionBundle())))

    // Pulling this pin to high will trigger a reset to flush the pipeline
    val exception = Output(Bool())
    val stall = Output(Bool())
  })
  // Four banks
  val banks = (0 until 4) map Module(new ROBBank(_))
  // Connect completion bit to them
  banks map _.io.completion <> io.completion
  // Connect Completion bits
  val except_occurred = banks map _.io.except_detected reduceLeft (_ | _)
  banks map (_.io.except_occurred := except_occurred)
  io.exception := exception_occurred
  // Connect stall bit: stall if any of them is full
  io.stall := banks map ~_.io.dispatch.ready reduceLeft (_ | _)
  // Connect commit ports
  (io.commit zip banks) map _ <> _.io.commit

  // Compress and order the dispatched instructions
  // This register marks which bank the first instruction should go to
  val dispatch_head = RegInit(0.U(2.W))
  // The higher 6 bits of the next available inst#
  val next_inst = RegInit(0.U(6.W))
  val next_init_c = QuickPlusOne(next_inst)
  // Compress the input instruction
  val compressed = CompressValid(io.commit)
  // Rotate the instructions to align the head
  val rotated = ROBRotator(compressed, dispatch_head)
  // Connect the rotated values to the banks
  (banks zip rotated) map (_io.dispatch <> _)

  // attach the lower 2 bit to inst# and decompress it

}
