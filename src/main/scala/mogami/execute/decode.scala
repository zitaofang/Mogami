package mogami.execute

import chisel3._
import chisel3.util._

// Classify input instruction format
// The output is one-hot encoded. The order of bits is: (0 to 6)
// R, R4, I, S, B, U, J
// Bit 7 is used to indentify fp output.
object InstClassify {
  class Result extends Bundle {

  }
  def apply(opcode: UInt) = {
    val output = Wire(UInt(8.W))

  }
}

// immediate generator
class ImmGen extends Module {
  val io = IO(new Bundle() {
    val inst = Input(UInt(32.W))
    val imm = Output(UInt(32.W))
  })
  // Control bits
  val bj = 0 // B + J
  val b = 0 // B
  val i = 0 // I
  val is = 0 // I + S
  val u = 0 // U
  val uj = 0 // U + J

  imm(4, 0) := Mux(i, io.inst(24, 20), io.inst(11, 7))
    & Cat(15.U(4.W), bj) // Clear LSB for B-type
    & Fill(5, u) // Clear lower bits if it is U-type
  imm(10, 5) := inst(30, 25)
    & Fill(6, u) // Clear lower bits if it is U-type
  imm(11) := Mux(bj, io.inst(7), io.inst(31))
    & u // Clear lower bits if it is U-type
  imm(12) := Mux(b, io.inst(31), io.inst(12))
    & ~is // Clear higher bits if it is I- or S-type
  imm(19, 13) := io.inst(19, 13)
    & Fill(7, uj) // Clear higher bits if it is not U- or J-type
  imm(20) := Mux(u, io.inst(20), io.inst(31))
    & uj // Clear higher bits if it is not U- or J-type
  imm(31, 21) := io.inst(31, 21)
    & Fill(11, u) // Clear higher bits if it is not U-type
}

// This step separates data and opcode, and generate the immediates.
// To be implemented later.
class PreDecode extends Module {
  val io = IO(new Bundle() {
    val in = Input(Vec(4, UInt(32.W)))
    val uop = Output(Vec(16, UInt))
    val src = Output(Vec(4, Vec(3, new DecodeOperand())))
    val dst = Output(Vec(4, UInt(6.W)))
  })
  // Extract Operand
  def extractOperand(inst: UInt) = {
    // At this time, we don't consider SYSTEM instruction list in
    // the encoding map of Chapter 25, RISC-V specs.
    val type_vector = Wire(Vec(7, Bool))
    // If inst[4:2] == 101, U-type
    type_vector(0) := inst(4, 2) === "b'101".U(3.W)
    // If inst[6:2] == 11000, B-type
    type_vector(1) := inst(6, 2) === "b'11000".U(5.W)
    // If inst[6:2] == 11011, J-type
    type_vector(2) := inst(6, 2) === "b'11011".U(5.W)
    // If inst[6:3] == 0100, S-type
    type_vector(3) := inst(6, 3) === "b'0100".U(4.W)
    // If inst[6:5] == 00 or 11, I-type if not other types
    type_vector(4) := inst(6) ^ inst(5)
    // Otherwise, R type
    type_vector(5) := true.B

    //
  }

  // Connect dst
  (0 until 4) map i =>
    io.dst(i) := Cat(io.in(11, 7)) & Fill(6, ~inst_class(4, 3).orR)
}

// Check dependency within the pack
class PackDependency(instIndex: UInt => UInt) extends Module {
  val io = IO(new Bundle() {
    val read = Input(Vec(4, Vec(3, new DecodeOperand())))
    val write = Input(Vec(4, UInt(6.W)))
    val write_en = Input(Vec(4, Bool))
    val read_out = Output(Vec(4, Vec(3, new DecodeOperand())))
    val rename_en = Output(Vec(4, Bool))
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
    val (instOffset, dependent) = compareRead(index, read_in.data(5, 0))
    Mux(dependent | ~read_in.present,
      DecodeOperand(instIndex(instOffset), false.B),
      read(index)(reg_ind)
    )
  }
  for (j <- 0 until 3)
    io.read_out(0)(j) := io.read(0)(j)
  for (i <- 1 until 4) for (j <- 0 until 3)
    io.read_out(i)(j) := assignOut(i, j)

  // Compare and resolve WAW hazard by masking unused write to rename table
  // (Note that the results are still written to ROB in case of traps)
  def compareWrite(index: Int, write_reg: UInt) = {
    val equal_reg = Cat((index until 3) map write_reg === io.write(_))
    equal_reg.orR
  }
  for (i <- 0 until 3)
    io.rename_en(i) := ~compareWrite(i) & io.write_en(i)
  io.rename_en(3) := io.write_en(3)
}

// The decode stage
class Decode extends Module {
  val io = IO(new Bundle() {
    
  })
}
