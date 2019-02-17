package mogami.execute

import chisel3._
import chisel3.util._

// The general internal value class
class Value extends Bundle {
  val value = UInt(64.W)
  val fp_flag = UInt(8.W)
}

// The operand. See below for the encoding.
// WARNING: The rules below are the general encoding and does not cover
// the encoding used within RegFile module. See that class for its usage
// in RegFile module.
class Operand extends Value {
  // Before the register read, the present is 0 for those to be supplied
  // by another instruction, 1 otherwise.
  val present = Bool()
  // If the operand does not present, this field is valid and holds the
  // instruction tag of that will produce the operand.
  // Before the register read stage, this field hold the physical
  // register address in the lower 8 bits (the upper 2 bits are all 1)
  // if present it 1. If it is an immediate, this field is cleared.
  val tag = UInt(10.W)
  // If the operand presents, these two inherited fields hold the value.
}

// The micro-ops structure
class MicroOps extends Bundle {
  // The instruction tag, used to identify the write-back.
  // Micro-ops tag has two more bits than a macro tag, for one macro-ops
  // can produce at most 4 micro-ops.
  val micro_tag = UInt(10.W)
  // The functional unit it is going to
  val fu_sel = UInt(3.W)
  // Operand 0 - 2.
  // Before operand insertion stage, all of its fields are 0.
  // If the present bit is 0, this operand is not valid.
  val src = Vec(3, new Operand())
  // The write-back register address. If the lowest two bits of micro_tag
  // is set, this field is invalid, because a intermediate micro-ops doesn't
  // need to write back.
  val dst = UInt(8.W)
  // The functional unit flag
  val flag = UInt(4.W)
}

// Writeback pack
class WritePack extends Bundle {
  // The actual value
  val value = new Value()
  // The physical address it is writing to.
  // The bank address is omitted for one bus corresponds to one bank.
  val addr = UInt(6.W)
}

// The CDB interface
class CDBInterface extends WritePack {
  // The micro-ops tag.
  val micro_tag = UInt(10.W)
  // The exception bits.
  val except = Bool()
}

// The main module for execute unit.
class Main extends Module {
  val io = IO(new Bundle() {
    // Connected to the fetch buffer
    val inst = Vec(4, Flipped(Irrevocable(UInt(32.W))))
    // Connected to the dispatch bus
    val dispatch_bus = Vec(8, Irrevocable(new MicroOps()))
    // CDB. Note that one bus can only write to its corresponding register bank.
    val cdb = Vec(4, Flipped(Irrevocable(new CDBInterface())))
  })

  // <<<<<<<<<<< BEGINNING OF DISPATCH FLOW >>>>>>>>>>>>

  // Decode the instruction
  val decode_core = Module(new Decode())
  decode_core.io.in := io.inst
  val uop = decode_core.io.uop
  // At this point, the registers haven't been renamed; the highest
  // two bits should be zero.
  val arch_src = decode_core.io.src
  val arch_dst = decode_core.io.dst

  // ======== Operand processing ==========
  // Resolve the dependency
  val dependency_core = Module(new PackDependency())
  dependency_core.io.read := arch_src
  val depend_read = dependency_core.io.read_out
  val depend_sel = dependency_core.io.read_sel

  // Check the rename table at the same time
  val rename_table = Module(new RenameTable())
  rename_table.io.decode_port.read_addr := arch_src
  val rename_read = rename_table.io.decode_port.read_val

  // Select the read address
  val resolved_read = ((0 until 4) cross (0 until 3)) map (i, j) =>
    Mux(depend_sel(i)(j), depend_read(i)(j), rename_read(i)(j))

  // ========== Writeback processing ==========
  // Detect WAW hazard within one instruction pack. This will not
  // affect writeback but will result in conflicting rename table
  // write. Some write need to be suppressed.
  dependency_core.io.write := arch_dst
  val rename_write_en = dependency_core.io.rename_en

  // ============= Dispatch Inst =============
  // (Here, dispatch to ROB; it only needs the writeback info)
  // At this time, only the lowest two bits of the uop# are set.
  // This step assign the higher 8 bits of uop# with the inst#, and put
  // the instructions into the ROB.
  val rob = Module(new ROB())


  // +++++++++++++ Pipeline Stage +++++++++++++++
  // ============= Read Register ==============
  // which may take at most 5 cycles (3 cycles can be pipelined)
  val reg_file = Module(new RegFile())
  reg_file.io.read_in := RegEnable(resolved_read, reg_file.io.ready)
  val operands = reg_file.io.read_out

  // Pipeline uops (3 + 1)
  val pipe_uops = Pipe(reg_file.io.ready, uops, 4)

  // ============= Set Operands ==============
  // Set the operand fields for all instructions
  pipe_uops map uop => {

  }

  // +++++++++++++ Pipeline Stage +++++++++++++++
  // ============= Dispatch uops =============
  // (Here, dispatch to the actual pipeline)
  // A buffer holds the complete micro-ops. It

  // <<<<<<<<<<< END OF DISPATCH FLOW >>>>>>>>>>>>

  // <<<<<<<<<<< BEGINNING OF COMPLETION FLOW >>>>>>>>>>>>

  // <<<<<<<<<<< END OF COMPLETION FLOW >>>>>>>>>>>>

  // <<<<<<<<<<< BEGINNING OF COMMIT FLOW >>>>>>>>>>>>

  // <<<<<<<<<<< END OF COMMIT FLOW >>>>>>>>>>>>
}
