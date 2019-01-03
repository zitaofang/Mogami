import chisel3._
import chisel3.util._
import scala.math.pow

class Shifter extends Module with ShifterBase{
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
  val shamt_bit = 6;
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
trait ShifterBase {
  // abstract member:
  val shamt_bit: Int
  val width = pow(2, shamt_bit).intValue
  def op: UInt(width.W)
  def shamt: UInt(shamt_bit.W)
  def flags: UInt(2.W)

  // Implementaiton
  // Cell data format
  class CellData extends Bundle(level: Int) {
    private val width = pow(2, level).intValue
    val middle = UInt(width.W) // Data staying on the same route
    val left = UInt(width.W) // Data shifting to the left
    val right = UInt(width.W) // Data shifting to the right
  }
  object CellData {
    def build(level: Int, middle: UInt, left: UInt, right: UInt) = {
      val res = CellData(level)
      res.middle = middle
      res.left = left
      res.right = right
      res
    }
  }

  // The shifter cell
  def shifter_cell(level: Int, in: CellData(level)) = {
    Mux(shamt(level),
      Mux(flags(0), in.left, in.right),
    in.middle)
  }

  // The function that chains the CellData input and output together,
  // and construct a slice
  def shifter_slice(level: Int, ctl: Bool)(param: Tuple2[Array, Bool]) = {
    // Unpack args
    val (in, s) = param

    val width = pow(2, level).intValue
    val num_comp = pow(2, shamt_bit - level).intValue

    // A unified array that includes shift in and shift out
    val input_array = Array(num_comp + 2)
    // A indexing function that allow index "-1"
    val arr_ind = (x: Int) => (i + 1)
    // Assign the input array
    input_array(arr_ind(-1)) = 0.U(width.W) // Shift-in from the right
    input_array(arr_ind(num_comp)) =
      Fill(width, op(63) & flags(1))
    for (i <- 0 until num_comp)
      input_array(arr_ind(i)) = in(i)

    // the array of mux output
    val mux_output = (0 until num_com) map ((i: Int) =>
      shifter_cell(level, CellData.build(level,
        input_array(arr_ind(i - 1)),
        input_array(arr_ind(i)),
        input_array(arr_ind(i + 1))
      ))
    )

    // Sticky generation
    val sticky_out = s | input_array(arr_ind(0)).orR

    // Merge two items in the mux array into a bigger array
    ((0 until num_comp / 2) map ((i: Int) =>
      Cat(mux_output(2 * i + 1), mux_output(2 * i))
    ), sticky_out) // sticky
  }

  // Connect the slices together
  // First, break the input into an array of 64 bits
  val initial_array = (0 until pow(2, shamt_bit).intValue) map op(_)

  // The output data
  val (output, sticky) = ((initial_array, false.B) /: // fold
    // Apply slice to the output of the previous slice
    ((0 until shamt_bit) map ((i: Int) =>
      shifter_slice(i, io.input.operand2(i))
    ))
  )(0) // Extract array[0] where the final result lies in
}
