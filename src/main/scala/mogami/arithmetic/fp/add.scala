package mogami.arithmetic.fp

import chisel3._
import chisel3.util._
import mogami.CarrySave
import mogami.arithmetic.ComparatorBlock
import mogami.arithmetic.integer.StickyShifter
import mogami.arithmetic.integer.CSAUtil

// The LZA module based on the following literature:
// Quinnell, Eric, Earl E. Swartzlander, and Carl Lemonds.
//    "Floating-point fused multiply-add architectures."
//    In Signals, Systems and Computers, 2007. ACSSC 2007.
//    Conference Record of the Forty-First Asilomar Conference on, pp. 331-337.
//    IEEE, 2007.
// See page 28 (Section 2.9) for more information.
object FPAddUtil {
  def lza(a_in: UInt, b_in: UInt) = {
    // Prepare
    val t = a_in ^ b_in
    val g = a_in & b_in
    val z = ~a_in & ~b_in

    // Calculate
    val raw_f = Wire(UInt(64.W))
    raw_f := (t << 1) & (g & ~(z >> 1) | z & ~(g >> 1)) |
      ~(t << 1) & (z & ~(z >> 1) | g & ~(g >> 1))
    val f = Cat(raw_f(63, 1), ~t(0) & t(1))

    // Encode and return
    PriorityEncoder(Reverse(f))
  }
}

// The integrated FP add.
// It should be note that some inputs are expected to be one cycle late.
class FPAdd extends Module {
  val io = IO(new Bundle() {
    val is_double = Input(Bool())

    val m = Input(new CarrySave(106)) // ONE CYCLE LATE
    val m_exp = Input(UInt(12.W))
    val m_sign = Input(Bool())
    val m_flags = Input(UInt(4.W)) // One-hot flags: zero, denorm, inf, nan
    val a = Input(UInt(53.W)) // ONE CYCLE LATE
    val a_exp = Input(UInt(12.W))
    val a_sign = Input(Bool())
    val a_flags = Input(UInt(4.W))

    val out = Output(new CarrySave(55))
    val out_exp = Output(UInt(12.W))
    val out_sign = Output(UInt(12.W))
    val out_flags = Output(UInt(4.W))
    val sticky = Output(Bool())
  })

  // Calculate exponent
  val exp_adder = Module(new AbsDiff())
  exp_adder.io.a := io.m_exp
  exp_adder.io.b := io.a_exp
  val out_of_range = exp_adder.io.out(11, 7).orR
  val m_shift_en = RegNext(exp_adder.io.lt)
  val m_oor = RegNext(out_of_range & exp_adder.io.lt)
  val a_oor = RegNext(out_of_range & ~exp_adder.io.lt)
  val exp_diff = RegNext(exp_adder.io.out(6, 0))
  val no_shift = RegNext(exp_adder.io.eq)
  val exp_base = RegNext(RegNext(Mux(exp_adder.io.lt, io.a_exp, io.m_exp)))
  // Sign and plus/minus
  val minus = RegNext(io.m_sign ^ io.a_sign)
  val exp_based_sign = RegNext(RegNext(Mux(exp_adder.io.lt, io.a_sign, io.m_sign)))
  // Close path selection
  val cp = RegNext(RegNext(
    Cat((-1 to 2) map (i => (i.U(12.W) === exp_adder.io.out))).orR |
    io.m_sign ^ io.a_sign
  ))

  // Special value handling rules:
  // NaN + anything = NaN (IV if one is signaling)
  // inf - inf = NaN (IV exception)
  // inf + anything = inf
  // zero + zero = zero
  val invalid_op_wire = io.m_flags(2) & io.a_flags(2) & io.m_sign ^ io.a_sign
  val nan_gen_wire =
    io.m_flags(3) | io.a_flags(3) |
    invalid_op_wire
  val invalid_op = RegNext(invalid_op_wire)
  val nan_gen = RegNext(nan_gen_wire)
  val zero_gen = RegNext(io.m_flags(0) & io.a_flags(0))
  val inf_gen = RegNext(
    io.m_flags(2) | io.a_flags(2)
    & ~invalid_op_wire
  )

  // ========= Stage ==========
  // Starting processing mantissa
  // Shift the operand to their places within 159 (=3 * 53) bits.
  val m_shamt = exp_diff & Fill(7, m_shift_en)
  val a_shamt = exp_diff & Fill(7, ~m_shift_en)
  val (ms_out_w, ms_sticky) = StickyShifter(Cat(io.m.s, 0.U(53.W)), m_shamt)
  val (mc_out_w, mc_sticky) = StickyShifter(Cat(io.m.c, 0.U(53.W)), m_shamt)
  val (a_out_w, a_sticky) = StickyShifter(Cat(io.a, 0.U(106.W)), a_shamt)
  // Out of range data processing
  val m_oor_sticky = (io.m.s.orR | io.m.c.orR) & m_oor
  val a_oor_sticky = io.a.orR & a_oor

  val shift_sticky =
    RegNext(ms_sticky | mc_sticky | a_sticky | m_oor_sticky | a_oor_sticky)
  val ms_out = RegNext(ms_out_w & Fill(159, ~m_oor))
  val mc_out = RegNext(mc_out_w & Fill(159, ~m_oor))
  val a_out = RegNext(a_out_w & Fill(159, ~a_oor))

  // ========== Stage ==========
  // Add them together
  // The CSA has a width of 161 bits,
  // equal to 3 * 53 + 1 (for adjusment) + 1 (sign).
  // The overflow bit will be discard as there would never be overflow.
  val (csa_out_s, csa_out_c) = CSAUtil.csa(161)(
    Cat(0.U(2.W), ms_out),
    Cat(0.U(2.W), mc_out),
    Fill(161, minus) ^ Cat(0.U(2.W), a_out),
    minus  // carry in
  )
  // Create a negated version
  // Since this is only used for close path with subtraction, always
  // negate the operand
  val (negated_tmp_s, negated_tmp_c) = CSAUtil.csa(160)(~ms_out, ~mc_out, a_out, true.B)
  val (negated_out_s, negated_out_c) = CSAUtil.ha(161)(negated_tmp_s, negated_tmp_c, true.B)

  // NOTE: All the code below this and within this stage are used in close
  // path only!

  // Apply LZA to obtain the leading zero position
  // Don't shift if close path is not selected
  val cp_shift = RegNext(Fill(6, cp) &
    FPAddUtil.lza(csa_out_s(160, 97), csa_out_c(160, 97)))
  // Compare sum and carry, with the negative one negated.
  // This determine the sign of the result.
  val (lt, neq) = ComparatorBlock(Fill(161, csa_out_s(160)) ^ csa_out_s,
    Fill(161, csa_out_c(160)) ^ csa_out_c)
  val op_sel = Mux(csa_out_s(160), lt, ~(lt & neq)) | ~cp

  // Select the mantissa
  val cp_s = RegNext(Mux(op_sel, csa_out_s, negated_out_s))
  val cp_c = RegNext(Mux(op_sel, csa_out_c, negated_out_c))

  // Select close path sign; if close path is selected,
  // use the sign of the CSA output with greater abs value; otherwise,
  // use the sign from exponent calculation.
  val cp_sign = RegNext(Mux(cp, lt ^ csa_out_s(160), exp_based_sign))

  // ========== Stage ==========
  // shift sum and carry
  val (s_out, s_sticky) = StickyShifter(cp_s, cp_shift) match { case (a, b) => (RegNext(a), RegNext(b)) }
  val (c_out, c_sticky) = StickyShifter(cp_c, cp_shift) match { case (a, b) => (RegNext(a), RegNext(b)) }
  // Adjust the carry out value: check the existance of carry out
  // by xoring the highest two bits
  val cout =
    (s_out(160) ^ c_out(160) ^ (s_out(159) & c_out(159))) ^
    (s_out(159) ^ c_out(159))
  // Shift the data, and cut off the leftmost 2 bits
  // (which should be 0 right now)
  val shifted_s = Mux(cout, s_out >> 1, s_out)(159, 0)
  val shifted_c = Mux(cout, c_out >> 1, c_out)(159, 0)
  // Calculate close path exp
  // Hack the ExpAdder: subtract the inverted of cp shamt to avoid
  // the extra carry-in when the mantissa carry out is not set
  val cp_exp_adder = Module(new ExpAdder())
  cp_exp_adder.io.is_double := false.B
  cp_exp_adder.io.subtract := ~cout
  cp_exp_adder.io.a := exp_base
  cp_exp_adder.io.b := ~cp_shift ^ Fill(12, cout)
  io.out_exp := cp_exp_adder.io.out
  io.out_sign := cp_sign
  // Send the lower 104 bits to the tree to form sticky bit
  io.sticky := shift_sticky |
    shifted_s(103, 0).orR | shifted_c(103, 0).orR
  // send the higher 55 bit as the result
  io.out.s := shifted_s(159, 104)
  io.out.c := shifted_c(159, 104)
}
