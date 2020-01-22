package mogami.arithmetic

import chisel3._
import chisel3.util._
import scala.math.pow

// A comparator for both integer and FP comparison.
class Comparator extends Module {
  val io = IO(new Bundle{
    val input = Input(new FPPortIn())
    val output = Output(new FPPortOut())
  })

  // Some specification:
  // The operands can be integers or FPs, depends on the flag specified in flags[0].
  // flags[0] is used to indicates if it is an LE(0) or LT(1) instruction.
  // If it is integer, flags[1] is 0, and:
  //  - flags[2] indicates if they are signed or unsigned (1 if signed).
  // Otherwise, flags[1] = 1, and:
  //  - flags[2] indicates if they are single precision or double (1 if double).
  // For both integer and FP, flags[3] indicates whether this is a max or min
  // instruction. It can be any value if the current instruction is just a comparison
  // instruction. 0 is max and 1 is min.
  // The output #1 is the comparison result, while output #2 is the min/max result.

  // Additional comment regarding NaN:
  // The standard requires that the output should be 0 if either operand is 1
  // for lt/le; also, they should also set IV bit for the CSR.
  // FP min/max will give the non-NaN if there is one NaN, and the canonical NaN
  // if there are two NaNs and one of them is canonical; otherwise, output a
  // random one.
  // Set IV bit if either NaN is signaling.
  // Also, for FP min/max, treat +0.0 > -0.0.

  val width_exp = 6

  // Align single precision
  val aligned_1 = Mux(~io.input.flags(2) && io.input.flags(1),
    Cat(io.input.operand1(31, 0), 0.U(32.W)),
    io.input.operand1
  )
  val aligned_2 = Mux(~io.input.flags(2) && io.input.flags(1),
    Cat(io.input.operand2(31, 0), 0.U(32.W)),
    io.input.operand2
  )

  // Invert the FP values except the sign bits if they are negative: this makes
  // them capable to be compared like signed integers.
  val inverted_1 = Cat(
    aligned_1(63),
    Fill(63, aligned_1(63) & io.input.flags(1)) ^ aligned_1(62, 0)
  )
  val inverted_2 = Cat(
    aligned_2(63),
    Fill(63, aligned_2(63) & io.input.flags(1)) ^ aligned_2(62, 0)
  )

  // Sign swapping: do this if the comparison is signed (integer) or FP.
  val sign_swap = io.input.flags(2) && io.input.flags(1)
  val swapped_1 = Cat(
    Mux(sign_swap, inverted_2(63), inverted_1(63)),
    inverted_1(62, 0)
  )
  val swapped_2 = Cat(
    Mux(sign_swap, inverted_1(63), inverted_2(63)),
    inverted_2(62, 0)
  )

  val (lt, neq) = ComparatorBlock(swapped_1, swapped_2)

  // raw output
  val lt_or_le = lt | ~(neq & io.input.flags(0)) // make a table to understand this
  val min_or_max = Mux(lt ^ io.input.flags(3), io.input.operand1, io.input.operand2)
  val min_max_fp = Mux(lt ^ io.input.flags(3), io.input.operand1_fp, io.input.operand2_fp)

  // Detect FP corner case:
  // 1. zero - (+0 = -0), overwrite the LT/LE output with 0
  val zero_lt_overwrite = io.input.operand1_fp(2) & io.input.operand2_fp(2) &
    io.input.flags(0)
  // 2. check NaN
  val nan_1 = io.input.operand1_fp(4) | io.input.operand1_fp(6)
  val nan_2 = io.input.operand2_fp(4) | io.input.operand2_fp(6)
  // 3. check canonical NaN
  val canonical_1 = io.input.operand1_fp(5) | io.input.operand1_fp(6)
  val canonical_2 = io.input.operand2_fp(5) | io.input.operand2_fp(6)

  // Handle FP corner case:
  // Selection of lt/le out: Pull to zero if either operand is NaN, or if both
  // operands are zero while LT bit is set.
  io.output.output1 := Cat(0.U(63.W), lt_or_le & ~zero_lt_overwrite & ~(nan_1 & nan_2))
  // Selection of min/max out:
}

// Warning: two operands must be of the same width, or the result
// is undefined.
// It returns a (lt, neq) pair.
object ComparatorBlock {
  def apply(a: UInt, b: UInt) = {
    val width = a.getWidth
    val width_exp = log2Ceil(width)
    val comp_width = pow(2, width_exp).intValue
    val comp_op1 = Cat(a, 0.U((comp_width - width).W))
    val comp_op2 = Cat(b, 0.U((comp_width - width).W))

    val lt_bit = ~comp_op1 & comp_op2 // op1 is less than op2?
    val neq_bit = comp_op1 ^ comp_op2 // op1 is not equal to op2?
    val initial_in = (0 until 64) map ((i: Int) => (lt_bit(i), neq_bit(i)))

    // The cell of a comparator
    def comparator_cell(in1: (Bool, Bool), in2: (Bool, Bool)) =
      {
        val (lt_in1, neq_in1) = in1
        val (lt_in2, neq_in2) = in2
        val lt_out = Mux(neq_in2, lt_in2, lt_in1)
        val neq_out = neq_in2
        (lt_out, neq_out)
      }
    // The slice of a comparator
    def comparator_slice(level: Int)(in: Seq[(Bool, Bool)]) =
      (0 until pow(2, width_exp - 1 - level).intValue) map
        (i => comparator_cell(in(2 * i), in(2 * i + 1)))

    // Return
    // Start folding left from a tuple of lt_bit and neq_bit and apply slices to them
    (initial_in /: ((0 until width_exp) map comparator_slice))((in, func) => func(in))(0)
  }
}
