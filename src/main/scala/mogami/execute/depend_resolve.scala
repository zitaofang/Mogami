package mogami.execute

import chisel3._
import chisel3.util._

// Check dependency within the pack.
// This module shall has less than 1 cycle delay.
// instIndex: A function that returns the queue index that the instuction should
// be stored by adding the current top of the queue and the instructon offset
// in the pack.
class PackDependency(instIndex: UInt => UInt) extends Module {
  val io = IO(new Bundle() {
    // The source operands of each instruction (imm or reg).
    val read = Input(Vec(4, Vec(3, Valid(new Operand()))))
    // The destination register of each instruction.
    val write = Input(Vec(4, Flipped(Valid(UInt(6.W)))))
    // The source operands after the RAW hazard within this pack
    // is resolved.
    val read_out = Output(Vec(4, Vec(3, Valid(new Operand()))))
    // The register read enable bits. True only if it does not depends
    // on other inst in this pack, not imm, and not x0.
    val read_sel = Output(Vec(4, Vec(3, Bool())))
    // Indicate a rename table entry needs to be modified.
    val rename_en = Output(Vec(4, Bool()))
  })

  // Compare the operand register addr to every write addr
  // (THIS FUNCTION DOESN'T CHECK IF THE INPUT IS AN IMMEDIATE!)
  def compareRead(index: Int, read_reg: UInt) = {
    // If any of equal_reg is true, the current operand depends on
    // some previous instructions
    val equal_reg = Cat(for (i <- 0 until index)
      read_reg === io.write(i).bits & io.write(i).valid)
    // The instruction it is depends on is the last instruction that produce
    // the requested register; use priority encode to get it
    val enc_out = PriorityEncoder(Cat(0.U((4 - index).W), equal_reg))
    (enc_out, equal_reg.orR)
  }

  // Connect in and out
  def assignOut(index: Int, reg_ind: Int) = {
    val read_in = read(index)(reg_ind)
    val (instOffset, dependent) = compareRead(index, read_in.bits.tag(5, 0))
    // If it is a register operand and dependent on other inst, use the
    // inst#; otherwise, use the current operand
    Mux(read_in.valid & (dependent | ~read_in.bits.present),
      DecodeOperand(instIndex(instOffset), false.B),
      read(index)(reg_ind)
    )
  }
  for (j <- 0 until 3)
    io.read_out(0)(j) := io.read(0)(j)
  for (i <- 1 until 4) for (j <- 0 until 3)
    io.read_out(i)(j) := assignOut(i, j)

  // If the write address is 0, or it is invalid, then ignore it
  val write_en = io.write map _.orR
  // Compare and resolve WAW hazard by masking unused write to rename table
  // (Note that the results are still written to ROB in case of traps)
  def compareWrite(index: Int, write_reg: UInt) = {
    val equal_reg = Cat((index until 3) map write_reg === io.write(_).bits)
    equal_reg.orR
  }
  for (i <- 0 until 3)
    io.rename_en(i) := ~compareWrite(i) & write_en(i)
  io.rename_en(3) := write_en(3)
}
