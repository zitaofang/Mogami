package mogami.execute

import chisel3._
import chisel3.util._

// Check dependency within the pack
class PackDependency(instIndex: UInt => UInt) extends Module {
  val io = IO(new Bundle() {
    val read = Input(Vec(4, Vec(3, new Operand())))
    val write = Input(Vec(4, UInt(6.W)))
    val read_out = Output(Vec(4, Vec(3, new Operand())))
    val read_sel = Output(Vec(4, Vec(3, Bool())))
    val rename_en = Output(Vec(4, Bool()))
  })

  // Compare the operand register addr to every write addr
  def compareRead(index: Int, read_reg: UInt) = {
    val equal_reg = Cat((0 until index) map read_reg === io.write(_))
    val enc_out = PriorityEncoder(Cat(0.U((4 - index).W), equal_reg))
    (enc_out, equal_reg.orR)
  }

  // Connect in and out
  def assignOut(index: Int, reg_ind: Int) = {
    val read_in = read(index)(reg_ind)
    val (instOffset, dependent) = compareRead(index, read_in.tag(5, 0))
    Mux(dependent | ~read_in.present,
      DecodeOperand(instIndex(instOffset), false.B),
      read(index)(reg_ind)
    )
  }
  for (j <- 0 until 3)
    io.read_out(0)(j) := io.read(0)(j)
  for (i <- 1 until 4) for (j <- 0 until 3)
    io.read_out(i)(j) := assignOut(i, j)

  // If the write address is 0, then ignore it
  val write_en = io.write map _.orR
  // Compare and resolve WAW hazard by masking unused write to rename table
  // (Note that the results are still written to ROB in case of traps)
  def compareWrite(index: Int, write_reg: UInt) = {
    val equal_reg = Cat((index until 3) map write_reg === io.write(_))
    equal_reg.orR
  }
  for (i <- 0 until 3)
    io.rename_en(i) := ~compareWrite(i) & write_en(i)
  io.rename_en(3) := write_en(3)
}
