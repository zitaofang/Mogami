package mogami.arithmetic.fp.fma

import chisel3._
import chisel3.util._

// shift in FP Add - 2 ** shamt_bit can be different from the width
class AddShifter(shamt_bit: Int, input_width: Int)
  extends Module with ShifterBase {
  val io = IO(new Bundle{
    val in = Input(UInt(160.W))
    val shamt = Input(UInt(7.W))
    val out = Output(UInt(160.W))
    val sticky = Output(Bool)
  })

  override def op = io.in
  override def shamt = io.shamt
  override def flags = io.input.flags(1, 0)
}

// Shift and CSA stage
class OPShiftCSA extends Module {
  val io = IO(new Bundle{
    val m = Input(CarrySave(106))
    val a = Input(UInt(53.W))
    val out = Output(CarrySave(161))
    val negated = Output(CarrySave(161))
    val sticky = Output(Bool)
    // Control bits
    val exp_diff = Input(UInt(7.W))
    val exp_comp = Input(Bool) // True if matrix output is greater
    val subtract = Input(Bool)
  })

  // Shift the operand to their places within 159 (=3 * 53) bits.
  val m_shamt = io.exp_diff & Fill(7, io.exp_comp)
  val a_shamt = io.exp_diff & Fill(7, ~io.exp_comp)
  val ms_shifter = Module(new AddShifter(6))
  val mc_shifter = Module(new AddShifter(6))
  val a_shifter = Module(new AddShifter(7))
  ms_shifter.in := Cat(io.m.s, 0.U(53.W))
  mc_shifter.in := Cat(io.m.c, 0.U(53.W))
  ms_shifter.shamt := m_shamt
  mc_shifter.shamt := m_shamt
  a_shifter.in := Cat(io.a, 0.U(106.W))
  a_shifter.shamt := a_shamt

  sticky := ms_shifter.sticky | mc_shifter.sticky | a_shifter.sticky

  // Add them together
  // The CSA has a width of 161 bits,
  // equal to 3 * 53 + 1 (for adjusment) + 1 (sign).
  // The overflow bit will be discard as there would never be overflow.
  (io.out.s, io.out.c) := csa(161)(
    Cat(0.U(2.W), ms_shifter.out),
    Cat(0.U(2.W), mc_shifter.out),
    Fill(161, io.subtract) ^ Cat(0.U(2.W), a_shifter.out),
    io.subtract  // carry in
  )

  // Create a negated version
  val unpack = (f: Function3[Any, Any, Any, Any]) =>
    ((t: Tuple2[Any, Any], a: Any) => f(t._1, t._2, a))
  (io.negated.s, io.negated.c) := unpack(ha(161))(csa(160)(
    Fill(160, io.subtract) ^ ms_shifter.out,
    Fill(160, io.subtract) ^ mc_shifter.out,
    a_shifter.out,
    io.subtract
  ), io.subtract)
}

// Sticky Tree For far (anchor) path
// By this time, the correct CSA output has been selected, and
// the input data is guaranteed to be POSITIVE.
class StickyTree extends Module {
  val io = IO(new Bundle{
    val in = Input(CarrySave(161))
    val shift_sticky = Input(Bool)
    val out = Output(CarrySave(55))
    val sticky = Output(Bool)
    val shifted = Output(Bool)
  })

  // Adjust the carry out value: check the existance of carry out
  // by xoring the highest two bits
  val cout =
    (io.in.s(160) ^ io.in.c(160) ^ (io.in.s(159) & io.in.c(159))) ^
    (io.in.s(159) ^ io.in.c(159))
  // Shift the data, and cut off the leftmost 2 bits
  // (which should be 0 right now)
  val shifted_s = Mux(cout, io.in.s >> 1, io.in.s)(159, 0)
  val shifted_c = Mux(cout, io.in.c >> 1, io.in.c)(159, 0)
  // Send the lower 104 bits to the tree to form sticky bit
  io.sticky := io.shift_sticky |
    shifted_s(103, 0).orR | shifted_c(103.0).orR
  // send the higher 55 bit as the result
  (io.out.s, io.out.c) := (shifted_s(159, 104), shifted_c(159, 104))

  io.shifted := cout
}

// The close path
class ClosePath extends Module with BaseComparator with BaseShifter {
  val io = IO(new Bundle{
    val in = Input(CarrySave(161))
    val negated = Input(CarrySave(161))
    val out = Input(CarrySave(55))
    val cp_exp = Output(UInt(8.W))
    val cp_sign = Output(Bool)
  })

  // Apply LZA to obtain the leading zero position
  val shift = lza(io.in.s(160, 97), io.in.c(160, 97))
  // While comparing the sum and carry
  // Invert (not negate, there is no +1) the negative and compare,
  // select io.in if the inverted negative operand is strictly less than
  // the positive operand
  // Note: there is only one negative operand (no overflow).
  val width_exp = 8
  def comp_op1 = Cat(Fill(161, io.in.s(160)) ^ io.in.s, 95)
  def comp_op1 = Cat(Fill(161, io.in.c(160)) ^ io.in.c, 95)
  val op_sel = Mux(io.in.s(160), lt, ~(lt & neq))
  // Then select the correct number and shift

  // The result will be sent to the sticky tree
}

// The exponent processing unit for FP Add
class ExpUnit extends Module {
  val io = IO(new Bundle{
    val a = Input(UInt(12.W))
    val m = Input(UInt(12.W))
    val cp_exp = Input(UInt(12.W))
    val adjusted = Input(Bool)
    val exp_out = Output(UInt(12.W))
    val cp_sel = Output(Bool)
    val sign_sel = Output(Bool) // True if matrix sign is selected
    val exp_diff = Output(UInt(12.W))
  })

  // Comparator
  val exp_abs_diff = Module(new AbsDiff(12))
  exp_abs_diff.a := io.a
  exp_abs_diff.b := io.m
  // If they are equal, close path will overwrite the symbol
  io.sign_sel := exp_abs_diff.lt
  io.exp_diff := exp_abs_diff.out

  // Close path selection
  val cp = VecInit((-1 to 2) map (_.U(12.W) === exp_abs_diff.out)).orR
  io.cp_sel := cp
  io.exp_out := Mux(cp, cp_exp, Mux(exp_abs_diff.lt, io.m, io.a))
    + adjusted.asUInt // Add 1 if adjusted
}

// The sign unit for FP Add
class SignUnit extends Module {
  val io = IO(new Bundle{
    val a = Input(Bool)
    val m = Input(Bool)
    val cp_sign = Input(Bool)
    val sign_sel = Input(Bool)
    val cp_sel = Input(Bool)
    val out = Input(Bool)
  })

  // If close path is selected, use cp_sign; otherwise,
  // use the selection signal from the exponent unit to choose
  io.out := Mux(io.cp_sel, io.cp_sign, Mux(io.sign_sel, io.m, io.a))
}
