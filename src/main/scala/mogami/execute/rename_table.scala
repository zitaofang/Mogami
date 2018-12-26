import chisel3._
import chisel3.util._

// The black box of ram with 12 read ports, 4 write ports
// used as the rename table
class MultiportRAM extends BlackBox {
  val io = IO(new Bundle{
    val clk = Input(Clock())
    val raddr = Input(Vec(12, UInt(6.W)))
    val we = Input(Vec(4, Bool))
    val waddr = Input(Vec(4, UInt(6.W)))
    val wdata = Input(Vec(4, UInt(8.W)))
    val rdata = Output(Vec(12, UInt(8.W)))
  })
}

// Arch register address ports
class ArchRegAddr extends Bundle {
  val en = Bool
  val addr = UInt(6.W)
}

// Operand source representation
//
class BypassTag extends Bundle {
  // Valid bit
  val en = Bool
  // present bit: if set, the tag below represents the physical register addr;
  // otherwise, it represents the instruction tag
  val present = Bool
  // The instruction tags in the ROB
  val inst_tag = UInt(8.W)
  // The output selection bit: some component has two output
  val out_sel = Bool
}

// The component that detect the hazards between four incoming instructions
class InterOpsDependency extends Module {
  val io = IO(new Bundle{
    // The architectural registers being read
    val arch_raddr = Input(Vec(4, Vec(3, ArchRegAddr)))
    // The architectural registers being write
    val arch_waddr = Input(Vec(4, ArchRegAddr))
    // inst_tag[4:3], used to be concatenated into inst_tag
    val read_rob_offset = Output(Vec(4, Vec(3, UInt(2.W))))
    // Reg reads that needs to be sent to RegFile
    val regfile_read_en = Output(Vec(4, Vec(3, Bool)))
    // Reg write enable: if there is no interruption, only write the
    // enabled entry to the regfile: avoid conflict writing
    val regfile_write_en = Output(Vec(4, Bool))
  })

  // compare read addresses and write addresses in the same instruction pack
  val addr_comparison = (a: ArchRegAddr, b: ArchRegAddr) =>
    new Bool((a.addr ^ b.addr).orR || (a.en & b.en))
  val comp_res = for (port <- 0 until 3) yield // For all three reading ports...
    (1 until 4) map ((r_inst: Int) => (1 until r_inst) map ((w_inst: Int) =>
    addr_comparison(
      arch_waddr(w_inst), arch_raddr(r_inst)(port)
    )))
    // ...compare it against all the write instructions preceding it.

  for (i <- 0 until 4; j <- 0 until 3) {
    regfile_read_en(i)(j) := ~comp_res(j)(i).orR
    // Then, compute the ROB entry index offset for all ports.
    read_rob_offset(i)(j) := PriorityEncoder(comp_res(j)(i))
  }

  // Calculate the write enable file
  regfile_write_en(0) := true.B
  for (current <- 1 until 4) {
    // Compare the index of every write address with all the address following it
    // If the register will be written after the current instructions in this pack,
    // don't write the result of the current inst at all
    val write_comp = Vec(4, Bool)
    write_comp := for (i <- (current + 1) until 4) yield
      (arch_waddr(i).addr === arch_waddr(current).addr && arch_waddr(i).en)
    regfile_write_en(0) := write_comp.andR && arch_waddr(current).en
  }
}

// rename table
// checking table is parallel to inter-ops dependency check
class RenameTable extends Module {
  val io = IO(new Bundle{
    // Regfile read addresses
    val arch_raddr = Input(Vec(4, Vec(3, ArchRegAddr)))
    // Regfile write addresses
    val arch_waddr = Input(Vec(4, ArchRegAddr))
    // Read output: the source of target register
    val r_source = Output(Vec(4, Vec(3)))
  })
}

// Register read buffer
class RegFileReader extends Module {
  val io = IO(new Bundle{
    // Regfile read address, with modified enable bit
    val arch_raddr = Input(Vec(4, Vec(3, ArchRegAddr)))
    // Output data

    // Stalled for bank conflict

  })
}

// The main component of the rename stage
class RenameUnit extends Module {
  val io = IO(new Bundle{
    // Current pointer to the ROB file
    val rob_pointer = Input(UInt(4.W))
    // The architectural registers being read
    val arch_raddr = Input(Vec(12, ArchRegAddr))
    // The architectural registers being write
    val arch_waddr = Input(Vec(4, ArchRegAddr))
    // The array of physical register (read) wire, connected to four banks
    val phys_raddr = Output(Vec(4, Vec(4, UInt(6.W))))
    // The physical register address the instructions need to write to
    val phys_waddr = Output(Vec(4, UInt(6.W)))
    // The tag output for those instructions waiting for the
    // Bank conflict detected: stall of the fetching unit required
    val stall_fetch = Output(Bool)
  })


}
