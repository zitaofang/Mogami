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
class PreDecode extends Module {
  val io = IO(new Bundle() {
    val in = Input(Vec(4, UInt(32.W)))
    val uop = Output(Vec(16, UInt))
    val src = Output(Vec(12, new DecodeOperand()))
    val dst = Output(Vec(4, UInt(6.W)))
  })
  // Classify all four instruction
  val inst_class = io.in map InstClassify(_)
  // Floating point classfication

  // Connect dst
  (0 until 4) map i =>
    io.dst(i) := Cat(io.in(11, 7)) & Fill(6, ~inst_class(4, 3).orR)
}
