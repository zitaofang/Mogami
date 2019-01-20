import chisel3._
import chisel3.util._
import scala.math.pow

class Shifter extends Module {
  val io = IO(new Bundle{
    val input = Input(FUPortIn)
    val output = Output(FUPortOut)
  })

  // Implement the shifter
  class Slice(level: Int, in: SlicePort[Bool], shift: Bool)
  extends ShifterSlice[Bool] {
    override def left_in_ctr = io.input.flags(1) & io.input.operand1(63)
    override def right_in_ctr = false.B
    override def block_size = math.pow(2, level).toInt
    override def to_right = io.input.flags(0)
    override def mux_func = Mux(_, _, _)
  }
  val slice = (level: Int) => (in: SlicePort[Bool]) =>
    new Slice(level, in, io.input.operand2(level)).result
  val tree = (0 until 6) map slice(_)

  io.output.output1 :=
    (new SliceSimplePort(io.input.operand1.toBools) /: tree)
    (a, f => f(a)).data
  io.output.output1_en := io.input.enable
  io.output.output2 := 0.U
  io.output.output2_en := false.B
  io.output.busy := false.B
}

// Simple shifter to the right (not unaligned)
object SimpleShifter {
  class Slice(level: Int, in: SlicePort[Bool], shift: Bool)
  extends ShifterSlice[Bool] {
    override def left_in_ctr = false.B
    override def right_in_ctr = false.B
    override def block_size = math.pow(2, level).toInt
    override def to_right = true.B
    override def mux_func = Mux(_, _, _)
  }

  def apply(input: UInt, shamt: UInt) => {
    val slice = (level: Int) => (in: SlicePort[Bool]) =>
      new Slice(level, in, shamt(level)).result
    val tree = (0 until shamt.getWidth) map slice(_)

    (new SliceSimplePort(input) /: tree)(a, f => f(a)).data
  }
}

// The implementation of shifter
trait BaseShifter {
  // abstract member:
  val shamt_bit: Int
  val width: Int
  def op: UInt(width.W)
  def shamt: UInt(shamt_bit.W)
  def to_right: Bool
  def shift_in: Bool

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
        Fill(width, shift_in)
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
        Mux(to_right, a.left, a.right),
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
    val to_right = Input(Bool)
    val shift_in = Input(Bool)
    val out = Output(UInt(width.W))
    val sticky = Output(Bool)
  })

  override def op = io.in
  override def shamt = io.shamt
  override def to_right = io.input.to_right
  override def shift_in = io.input.shift_in

  io.out := output
  io.sticky := sticky
}

object ShifterBlock {
  def apply(in: UInt, shamt: UInt, to_right: Bool, shift_in: Bool) = {
    val obj = Module(new ShifterBlock(shamt.getWidth, in.getWidth))
    obj.io.in := in
    obj.io.shamt := shamt
    obj.io.to_right := to_right
    obj.io.shift_in := shift_in
    (io.out, io.sticky)
  }
}
