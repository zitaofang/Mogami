import chisel3._
import chisel3.util._
import scala.math.pow

class Shifter extends Module with BaseShifter {
  val io = IO(new Bundle{
    val input = Input(FUPortIn)
    val output = Output(FUPortOut)
  })

  // Input specs:
  // Operand1 is the target of the shift operation, and Operand2 is the shamt.
  // This component only use the lower 6 bits and ignore the higher bits.
  // Flag bit 0 indicate the direction: 0 to the left, 1 to the right.
  // Flag bit 1 indicate if it is arithmetic shift: 0 logical, 1 arithmetic.
  // It is the decoder's job to generate correct flag: "arithmetic left" shift
  // should not be passed to the shifter.
  val shamt_bit = 6
  val width = 64
  override def op = io.input.operand1
  override def shamt = io.input.operand2(5, 0)
  override def flags = io.input.flags(1, 0)

  io.output.output1 := output

  // Pull the rest of the output
  io.output.output1_en := io.input.enable
  io.output.output2 := 0.U
  io.output.output2_en := false.B
  io.output.busy := false.B
}

// The implementation of shifter
trait BaseShifter {
  // abstract member:
  val shamt_bit: Int
  val width: Int
  def op: UInt(width.W)
  def shamt: UInt(shamt_bit.W)
  def flags: UInt(2.W)

  // Implementaiton
  // Cell data format
  class CellData extends Bundle(level: Int) {
    private val unit_width = pow(2, level).intValue
    val middle = UInt(unit_width.W) // Data staying on the same route
    val left = UInt(unit_width.W) // Data shifting to the left
    val right = UInt(unit_width.W) // Data shifting to the right
  }
  class ShiftSlice(level: Int) {
    // Some arguments
    val unit_width = pow(2, level).intValue
    val padding = unit_width - width % unit_width
    val group_num = width / unit_width +
      if (padding == 0) 1 else 0

    private def buildCell(middle: UInt, left: UInt, right: UInt) = {
      val res = CellData(level)
      res.middle = middle
      res.left = left
      res.right = right
      res
    }
    private def decode(in: Tuple2[UInt, Bool]) = {
      val padded_in = Cat(in._1, 0.U(padding.W))
      val groups = (0 until group_num) map
        (i => padded_in(unit_width * (i + 1) - 1, unit_width * i))

      // A unified array that includes shift in and shift out
      val input_array = Array(group_num + 2)
      // A indexing function that allow index "-1"
      val arr_ind = (x: Int) => (i + 1)
      // Assign the input array
      input_array(arr_ind(-1)) = 0.U(width.W) // Shift-in from the right
      input_array(arr_ind(num_comp)) =
        Fill(width, op(63) & flags(1))
      for (i <- 0 until num_comp)
        input_array(arr_ind(i)) = in(i)

      // Output
      ((0 until num_com) map (i =>
        CellData.build(level,
          input_array(arr_ind(i - 1)),
          input_array(arr_ind(i)),
          input_array(arr_ind(i + 1))
        )
      ), in._2) // Add the sticky bit
    }
    private def encode(in: Tuple2[UInt, Bool]) = {
      // Fold and concatenate
      (Cat(in._1)(padding + unit_width - 1, padding), in._2)
    }
    private def shift(in: Tuple2[Array[CellData], Bool]) = {
      // Shift
      val out = in._1 map (a => Mux(shamt(level),
        Mux(flags(0), a.left, a.right),
      a.middle))
      // Sticky
      val s = in._2 |
        (in._1(0).middle(unit_width - 1, padding).orR & shamt(level))

      (out, s)
    }
    def apply(in: Tuple2[UInt, Bool]) =
      encode(shift(decode(in)))
  }

  // The output data
  val (output, sticky) =
    ((op, false.B) /: ((shamt_bit - 1) to 0 by -1))// fold
    // Apply slice to the output of the previous slice
  )(r, i => ShiftSlice(i)(r))
}

// Shifter to be used in other module
class ShifterBlock(shamt_bit: Int, width: Int) extends ShifterBase {
  val io = IO(new Bundle{
    val in = Input(UInt(width.W))
    val shamt = Input(UInt(shamt_bit.W))
    val out = Output(UInt(width.W))
    val sticky = Output(Bool)
  })

  override def op = io.in
  override def shamt = io.shamt
  override def flags = io.input.flags(1, 0)

  io.out := output
  io.sticky := sticky
}

object ShifterBlock {
  def apply(in: UInt, shamt: UInt) = {
    val obj = Module(new ShifterBlock(shamt.getWidth, in.getWidth))
    obj.io.in := in
    obj.io.shamt := shamt
    (io.out, io.sticky)
  }
}
