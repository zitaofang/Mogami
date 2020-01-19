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
// the encoding used within RegFile module. See regfile.scala for the usage
// of this data type in RegFile module.
class Operand extends Value {
  // Before the register read, the present is 0 for those to be supplied
  // by another instruction, 1 otherwise.
  val present = Bool()
  // For any operands AFTER the decode stage:
    // If the operand does not present, this field is valid and holds the
    // instruction tag of that will produce the operand.
  // For Macro-ops operands DURING the decode stage:
    // Before the register read stage, this field hold the physical
    // register address in the lower 8 bits (the upper 2 bits are all 1)
    // if "present" is 1. If it is an immediate, this field is cleared.
  // For Micro-ops operands DURING the decode stage:
    // If present is true, the operand will be supplied by the normal
    // macro-ops operands. The lower two bits will be the # of operands
    // in the operand processing flow (rs1, rs2, rs3, ...)
    // If present is false, the operand depends on the uops preceding
    // it in the pack decoded from the current macro-ops. The lower two
    // bits are the uops # in the pack.
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
  // The write-back register address and enable bit
  val dst_enable = Bool()
  val dst = UInt(8.W)
  // The functional unit flag
  val flag = UInt(4.W)
}

// Writeback pack
class RegWritePack extends Bundle {
  // The actual value
  val value = new Value()
  // The physical address it is writing to.
  // The bank address is omitted, for one bus corresponds to one bank.
  val addr = UInt(6.W)
  // Write enable bit (some uops doesn't write register)
  val write_en = Bool()
}

// The completion port data bundle
class ROBCompletePack extends Bundle {
  // The micro-ops tag. Leftmost two bits (Bank index) are ignored
  val micro_tag = UInt(8.W)
  // The exception bits.
  val except = Bool()
}

// The CDB interface
class CDBInterface extends Bundle {
  val reg_pack = new RegWritePack()
  val rob_pack = new ROBCompletePack()
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

  // Stall bits; if any of them is set, stall the fetching.
  val stall_bits = Wire(UInt(2.W))
  for (inst <- io.inst) inst.ready := stall_bits.orR

  // <<<<<<<<<<< BEGINNING OF DISPATCH FLOW >>>>>>>>>>>>

  // ======== Decode instruction ==========
  val decode_core = Module(new Decode())
  decode_core.io.in := io.inst
  val uop = decode_core.io.uop
  // At this point, the registers haven't been renamed; the highest
  // two bits should be zero.
  val arch_src = decode_core.io.src
  val arch_dst = decode_core.io.dst

  // ======== Resolve the dependency ==========
  val dependency_core = Module(new PackDependency())
  dependency_core.io.read := arch_src
  val depend_read = dependency_core.io.read_out
  val depend_sel = dependency_core.io.read_sel

  // ======== Check the rename table ==========
  val rename_table = Module(new RenameTable())
  rename_table.io.decode_port.read_addr := arch_src
  val rename_read = rename_table.io.decode_port.read_val

  //  ======== Select the read address =========
  // (for register read)
  val resolved_read = ((0 until 4) cross (0 until 3)) map (i, j) =>
    Mux(depend_sel(i)(j), depend_read(i)(j), rename_read(i)(j))

  // ========== WAW Resolve ==========
  // Detect WAW hazard within one instruction pack. WAW will not
  // affect writeback but will result in conflicting rename table
  // write. Some write to the rename table need to be suppressed.
  dependency_core.io.write := arch_dst
  val rename_write_en = dependency_core.io.rename_en

  // ========== Free List Read ===========
  // Note that the next free entries are available at the beginning of
  // the cycle
  val free_list = Module(new FreeList())
  for (i <- 0 until 4)
    free_list.io.alloc_reg(i).ready := arch_dst(i).valid
  val alloc_reg = (0 until 4) map free_list.io.alloc_reg(_).bits
  // If the free list has a pending flush request, we need to stall
  // the fetching unit
  stall_bits(0) := ~free_list.io.flush_req.valid

  // (Update the Rename Table used by the decoder)
  rename_table.io.decode_port.write_en := rename_write_en
  rename_table.io.decode_port.write_addr := arch_dst
  rename_table.io.decode_port.write_val := alloc_reg

  // ============= Dispatch Inst =============
  // (Here, dispatch to ROB; ROB only needs the writeback info)
  // At this time, only the lowest two bits of the uop# are set.
  // This step assign the higher 8 bits of uop# with the inst#, and put
  // the instructions into the ROB.
  val rob = Module(new ROB())
  for (i <- 0 until 4) {
    // Set input ROBLine and valid bit
    rob.io.dispatch(i).bits := ROBLine(RegNext(arch_dst(i)), alloc_reg(i))
    rob.io.dispatch(i).valid := inst(i).valid
    // Generate 10b inst#
    uop(i).micro_tag(7, 0) := rob.io.inst_no(i)
  }

  // +++++++++++++ Pipeline Stage +++++++++++++++
  // ============= Read Register ==============
  // which may take at most 5 cycles (3 cycles can be pipelined)
  val reg_file = Module(new RegFile())
  reg_file.io.read_in := RegEnable(resolved_read, reg_file.io.ready)
  val operands = reg_file.io.read_out

  // Pipeline uops (3 + 1)
  val pipe_uops = Pipe(reg_file.io.ready, uops, 4)

  // +++++++++++++ Pipeline Stage +++++++++++++++
  // ============= Set Operands ==============
  // Set the operand fields for all instructions. RegFile will preserve
  // immediate operands and operands that depends on other insts, so we
  // can just take whatever in "val operands".
  for (i <- 0 until 16) {
    pipe_uops(i).src map src_op =>
      when (src_op.present) {
        src_op := operands(i / 4)(src_op.tag(1, 0))
      } .otherwise {
        src_op.tag(9, 2) := pipe_uops(i).micro_tag(9, 2)
      }
  }

  // ============= Enqueue uops =============
  // (Here, dispatch to the actual pipeline)
  // A buffer holds the complete micro-ops.
  // Compress input
  val compressed_uops =
    CompressValid(pipe_uops, new MicroOps()) grouped 8
  // A queue
  val dispatch_ready = Wire(Vec(4, Bool()))
  for (i <- 0 until 8) {
    // Prepare queue input
    val dispatch_queue_in = IrrevocableIO(Vec(2, new MicroOps()))
    dispatch_queue_in.valid := (false.B /: compressed_uops(i)) (_|_)
    dispatch_queue_in.bits := compressed_uops map _.bits
    dispatch_ready(i) := dispatch_queue_in.ready

    // Use a flag bits to delay the removal of queue data or
    // invalidated uops that's received by a reservation station
    val dispatch_queue_out = IrrevocableIO(new MicroOps())
    dispatch_queue_out <> Queue(dispatch_queue_in, 4)
    // If the flag is set, the uop with lower index is dispatched.
    // The flag cannot be set if the queue output valid bit is not high.
    val queue_flag = RegInit(false.B)
    // Connect the bits output to the IO port, muxed by the flags
    io.dispatch_bus(i).bits := dispatch_queue_out.bits(queue_flag)
    // If the queue has data ready...
    when (dispatch_queue_out.valid) {
      // And a reservation station says it will take the uop...
      when (io.dispatch_bus(i).ready) {
        // And the second uop is valid...

        // Flip the flag; if flag is low, first uop not yet sent;
        // if flag is high, move to the next queue entry
        queue_flag := ~queue_flag
      }
    }
    // If the uop is taken, its valid bit should be masked.
    io.dispatch_bus(i).valid :=
    // If both uops are taken by some stations, move on to the next line
    dispatch_queue_out.ready := queue_flag.andR
    when (queue_flag.andR) {
      queue_flag := 0.U(2.W)
    }
  }

  // <<<<<<<<<<< END OF DISPATCH FLOW >>>>>>>>>>>>

  // <<<<<<<<<<< BEGINNING OF COMPLETION FLOW >>>>>>>>>>>>

  // Connect to ROB
  rob.io.completion := io.cdb map bus => {
    val rob_pack = Wire(Valid(new ROBCompletePack()))
    rob_pack.bits := bus.bits.rob_pack
    rob_pack.valid := bus.valid
    rob_pack
  }

  // Write to RegFile
  reg_file.io.write := io.cdb map bus => {
    val reg_pack = Wire(Valid(new RegWritePack()))
    reg_pack.bits := bus.bits.reg_pack
    reg_pack.valid := bus.valid
    reg_pack
  }

  // <<<<<<<<<<< END OF COMPLETION FLOW >>>>>>>>>>>>

  // <<<<<<<<<<< BEGINNING OF COMMIT FLOW >>>>>>>>>>>>

  // ROB initiates a commit; modify rename table
  val commit_wire = Wire(new RenameROBPort())
  for (i <- 0 until 4) {
    commit_wire.write_en(i) := rob.io.commit(i).valid
    commit_wire.write_addr(i) := rob.io.commit(i).bits.write_reg
    commit_wire.write_val(i) := rob.io.commit(i).bits.write_rename
  }
  rename_table.io.rob_port <> commit_wire

  // ++++++++++ Pipeline Stage +++++++++++++
  // Release the regfile rename entry
  for (i <- 0 until 4) {
    free_list.io.free_reg(i).valid := RegNext(commit_wire.write_en(i))
    free_list.io.free_reg(i).bits := commit_wire.free_addr
  }

  // Exception handling
  // If an exception is detected, flush rename table, decode pipeline.
  // The, notify the fetching and execution stages with a signal.
  rename_table.io.flush := rob.io.exception

  // <<<<<<<<<<< END OF COMMIT FLOW >>>>>>>>>>>>
}
