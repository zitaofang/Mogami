package mogami.arithmetic

import chisel3._
import chisel3.util._
import mogami.MultiMux

class SingleCycle extends Module {
  val io = IO(new Bundle{
    val input = Input(new FPPortIn())
    val output = Output(new FPPortOut())
  })

  // As these compoenents are very small, it would be a bad idea to maintain a
  // separate reservation station for them, so I integrate them into one
  // component, control by flags.

  // This component covers the following operation, with their corresponding
  // flags[2:0]:
  // and - 0
  // or - 1
  // xor - 2
  // FP equal - 3
  // Sign bit inject (plain) - 4
  // Sign bit inject (negate) - 5
  // Sign bit inject (xor) - 6
  // FP Classification - 7

  // flags[3] is used to distinguish single and double precision (0 is single).

  // The vector holding all outputs
  val output_vec = Vec(8, UInt(64.W))

  // and
  output_vec(0) := io.input.operand1 & io.input.operand2
  // or
  output_vec(1) := io.input.operand1 | io.input.operand2
  // xor
  output_vec(2) := io.input.operand1 ^ io.input.operand2
  // fp equal
  output_vec(3) := 0.U

  // FP output Selector
  val fp_output = Vec(2, Vec(4, UInt(64.W)))

  // Single precision
  // Sign bit inject (plain)
  fp_output(0)(0) := Cat(io.input.operand2(31), io.input.operand1(30, 0))
  // Sign bit inject (negate)
  fp_output(0)(1) := Cat(~io.input.operand2(31), io.input.operand1(30, 0))
  // Sign bit inject (xor)
  fp_output(0)(2) := Cat(io.input.operand1(31) ^ io.input.operand2(31),
    io.input.operand1(30, 0))
  // FP Classification...a little bit complicated
  val is_NaN_s = io.input.operand1(30, 23).andR | io.input.operand1(22, 0).orR
  val quiet_s = io.input.operand1(22) & !io.input.operand1(21, 0).andR
  val res_normal_s = UInt(2.W) // The classification, assumed that it's not NaN
  res_normal_s(1) := io.input.operand1(30, 23).orR
  res_normal_s(0) := io.input.operand1(22, 0).orR ^ res_normal_s(1);
  fp_output(0)(3) := Cat(
    0.U(60.W), // padding
    is_NaN_s,
    Fill(2, !is_NaN_s) & (res_normal_s(2, 1) ^ Fill(2, io.input.operand1(31))),
    is_NaN_s | (res_normal_s(0) ^ io.input.operand1(31))
  )

  // Double precision
  // Sign bit inject (plain)
  fp_output(1)(0) := Cat(io.input.operand2(63), io.input.operand1(62, 0))
  // Sign bit inject (negate)
  fp_output(1)(1) := Cat(~io.input.operand2(63), io.input.operand1(62, 0))
  // Sign bit inject (xor)
  fp_output(1)(2) := Cat(io.input.operand1(63) ^ io.input.operand2(63),
    io.input.operand1(62, 0))
  // FP Classification...a little bit complicated
  val is_NaN_d = io.input.operand1(62, 52).andR | io.input.operand1(51, 0).orR
  val quiet_d = io.input.operand1(51) & !io.input.operand1(50, 0).andR
  val res_normal_d = UInt(2.W) // The classification, assumed that it's not NaN
  res_normal_d(1) := io.input.operand1(62, 52).orR
  res_normal_d(0) := io.input.operand1(51, 0).orR ^ res_normal_d(1);
  fp_output(1)(3) := Cat(
    0.U(60.W), // padding
    is_NaN_d,
    Fill(2, !is_NaN_d) & (res_normal_d(2, 1) ^ Fill(2, io.input.operand1(63))),
    is_NaN_d | (res_normal_d(0) ^ io.input.operand1(63))
  )

  // Select according to the flag
  Cat(output_vec.slice(4, 7)) := Mux(io.input.flags(3), Cat(fp_output(0)), Cat(fp_output(1)))
  io.output.output1 := MultiMux(io.input.flags(2, 0), output_vec)

  // Pull the output
  io.output.output1_en := io.input.enable
  io.output.output2 := 0.U
  io.output.output2_en := false.B
  io.output.busy := false.B
}
