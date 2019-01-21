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

// Simple shifter function
object SimpleShifter {
  def apply(input: UInt, shamt: UInt, to_right_: Bool = true.B,
    shift_in: Bool = false.B) => {
      class Slice(level: Int, in: SlicePort[Bool])
      extends ShifterSlice[Bool] with UnalignedShifter[Bool] {
        override def shift = shamt(level)
        override def left_in_ctr = shift_in
        override def right_in_ctr = false.B
        override def block_size = math.pow(2, level).toInt
        override def to_right = to_right_
        override def mux_func = Mux(_, _, _)
        override def padding_right = true
      }

      val slice = (level: Int) => (in: SlicePort[Bool]) =>
        new Slice(level, in).result
      val tree = (0 until shamt.getWidth) map slice(_)

      (new SliceSimplePort(input) /: tree)(a, f => f(a)).data
    }
}

// Shifter with a sticky bit output for FPU
object StickyShifter {
  def apply(input: UInt, shamt: UInt) => {
    class Slice(level: Int, in: SlicePort[Bool])
    extends ShifterSlice[Bool] with UnalignedShifter[Bool]
    with ShiftOutReduce[Bool] {
      override def shift = shamt(level)
      override def left_in_ctr = false.B
      override def right_in_ctr = false.B
      override def block_size = math.pow(2, level).toInt
      override def to_right = true.B
      override def mux_func = Mux(_, _, _)
      override def reduce_ctr = false.B
      override def reduce_func = (_ | _)
      override def padding_right = false
    }

    val slice = (level: Int) => (in: SlicePort[Bool]) =>
      new Slice(level, in).result
    val tree = (0 until shamt.getWidth) map slice(_)

    (new SliceReducePort(input, false.B) /: tree)(a, f => f(a)) match
      { case SliceReducePort(data, reduce) => (data, reduce) }
  }
}
