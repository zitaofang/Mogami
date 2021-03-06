package mogami.execute

import chisel3._
import chisel3.util._

// Classify input instruction format
// The output is one-hot encoded. The order of bits is: (0 to 6)
// R, R4, I, S, B, U, J
// Bit 7 is used to identify fp output.
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
  // TODO fill these placeholder in
  val bj = false.B // B + J
  val b = false.B // B
  val i = false.B // I
  val is = false.B // I + S
  val u = false.B // U
  val uj = false.B // U + J

  io.imm(4, 0) := Mux(i, io.inst(24, 20), io.inst(11, 7)) &
    Cat(15.U(4.W), bj) & // Clear LSB for B-type
    Fill(5, u) // Clear lower bits if it is U-type
  io.imm(10, 5) := io.inst(30, 25) &
    Fill(6, u) // Clear lower bits if it is U-type
  io.imm(11) := Mux(bj, io.inst(7), io.inst(31)) &
    u // Clear lower bits if it is U-type
  io.imm(12) := Mux(b, io.inst(31), io.inst(12)) &
    ~is // Clear higher bits if it is I- or S-type
  io.imm(19, 13) := io.inst(19, 13) &
    Fill(7, uj) // Clear higher bits if it is not U- or J-type
  io.imm(20) := Mux(u, io.inst(20), io.inst(31)) &
    uj // Clear higher bits if it is not U- or J-type
  io.imm(31, 21) := io.inst(31, 21) &
    Fill(11, u) // Clear higher bits if it is not U-type
}

// This step separates data and opcode, and generate the immediates.
// To be implemented later, after all functional component is finished.
class Decode extends Module {
  val io = IO(new Bundle() {
    val in = Input(Vec(4, UInt(32.W)))
    val uop = Output(Vec(16, new MicroOps()))
    val src = Output(Vec(4, Vec(3, Valid(new Operand()))))
    val dst = Output(Vec(4, Valid(UInt(6.W))))
  })
  // Extract Operand
  def extractOperand(inst: UInt) = {
    // At this time, we don't consider SYSTEM instruction list in
    // the encoding map of Chapter 25, RISC-V specs.
    val type_vector = Wire(Vec(7, Bool()))
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
  for (i <- 0 until 4) {
    val inst_class = 0.U(8.W) // InstClassify(io.in(i))
    io.dst(i) := Cat(io.in(i)(11, 7)) & Fill(6, ~inst_class(4, 3).orR)
  }
}
