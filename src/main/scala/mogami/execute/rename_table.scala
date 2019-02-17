package mogami.execute

import chisel3._
import chisel3.util._

// There are two rename tables: one is for decoding (read and written by the
// encoder) and another for committing (written only if an instruction is
// committed).
// If there is a trap or misprediction, copy the commit table to the
// decode table.

// The interface to decoder
class RenameDecodePort extends Bundle {
  val write_en = Input(Vec(4, Bool()))
  val write_addr = Input(Vec(4, UInt(6.W)))
  val write_val = Input(Vec(4, UInt(8.W)))
  val read_addr = Input(Vec(4, Vec(3, Valid(new Operand()))))
  val read_val = Output(Vec(4, Vec(3, Valid(new Operand()))))
}

// The interface to ROB
class RenameROBPort extends Bundle {
  val write_en = Input(Vec(4, Bool()))
  val write_addr = Input(Vec(4, UInt(6.W)))
  val write_val = Input(Vec(4, UInt(8.W)))
  val free_addr = Output(Vec(4, UInt(8.W)))
}

// The rename table entry
class RenameTableEntry(order: Int) extends Module {
  val io = IO(new Bundle() {
    val flush = Input(Bool())
    val flush_val = Input(UInt(8.W))

    val write_en = Input(Vec(4, Bool()))
    val write_addr = Input(Vec(4, UInt(6.W)))
    val write_val = Input(Vec(4, UInt(8.W)))
    val value = Output(UInt(8.W))
  })

  val order_u = order.U(6.W)
  val core = RegInit(Cat(0.U(2.W), order_u(5, 2), order_u(1, 0)))
  io.value := core
  val write_match = (io.write_addr zip io.write_en) map order_u === _ & _
  core := Mux(flush, flush_val, Mux1H(write_match, io.write_val))
}
object RenameTableEntry {
  def apply(order: Int, write_en: Vec, write_addr: Vec, write_val: Val,
    flush: Bool, flush_val: UInt) = {
    val res = Module(new RenameTableEntry(order))
    res.io.write_en := write_en
    res.io.write_addr := write_addr
    res.io.write_val := write_val
    res.io.flush := flush
    res.io.flush_val := flush_val
    res.io.value
  }
}

// The rename table for decode
class DecodeRenameTable extends Module {
  val io = IO(new Bundle() {
    // If 1, copy all entries from the committed table
    val flush = Input(Bool())
    val flush_value = Input(Vec(64, UInt(8.W)))

    val port = new RenameDecodePort()
  })

  // Create the table
  val entry_mat = for (i <- 0 until 64) {
    val res = Module(new RenameTableEntry(i))
    res.io.write_en := io.port.write_en
    res.io.write_addr := io.port.write_addr
    res.io.write_val := io.port.write_val
    res.io.flush := io.flush
    res.io.flush_val := io.flush_value(i)
    res.io.value
  }

  // Select the output for each read port
  (io.port.read_val map io.port.read_addr) map _ := MultiMux(_, entry_mat)
}

// The committed rename table
// The ROB will hold the register it is renaming to and send it to the
// committed table once it is committed.
// In the case of a trap / misprediction, everything in this table will
// be copied to the rename table used in decode stage.
class CommitRenameTable extends Module {
  val io = IO(new Bundle() {
    val port = new RenameROBPort()
    val value = Output(Vec(64, UInt(8.W)))
  })

  val value = VecInit((0 until 64) map
    RenameTableEntry(_, io.port.write_en, io.port.write_addr, io.port.write_val,
      false.B, 0.U))
  io.value := value
  (io.port.free_addr zip io.port.write_addr) map _ := value(_)
}

// The rename table exposed to other component
class RenameTable extends Module {
  val io = IO(new Bundle() {
    val flush = Input(Bool())
    val decode_port = new RenameDecodePort()
    val rob_port = new RenameROBPort()
  })

  val decode_table = Module(new DecodeRenameTable())
  val commit_table = Module(new CommitRenameTable())
  decode_table.io.flush := io.flush
  commit_table.io.flush := io.flush
  decode_table.io.flush_value := commit_table.io.value
  decode_table.io.port <> decode_port
  rob_table.io.port <> rob_port
}
