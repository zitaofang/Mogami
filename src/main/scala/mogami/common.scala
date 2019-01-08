import chisel3._
import chisel3.util._

// Multi-level mux
def array_mux(ctl: Bool, input: Array(2)) =
  Mux(ctl, input(1), input(0))
def reduce_mux_slice(ctl: Bool, input: Array) =
  (0 until input.length / 2) map (
    (i: Int) => Mux(ctl, input(input.length / 2 + i), input(i))
  )
def reduce_mux (ctl: UInt, input: Array) =
  ((0 until log2Floor(ctl.getWidth)) foldLeft(input) (
    (ctl_b: UInt, input_slice: Array) => reduce_mux_slice(ctl_b, input_slice)
  ))

// common type for carry-save data
class CarrySave(width: Int) extends Bundle {
  val s = UInt(width.W)
  val c = UInt(width.W)
}
object CarrySave {
  def apply(s: UInt, c: UInt) = {
    val res = Wire(new CarrySave(s.getWidth))
    res.s := s
    res.c := c
    res
  }
}

// Calculating the absolute different
class AbsDiff(width: Int) extends Module with BaseComparator {
  val io = IO(new Bundle{
    val a = Input(UInt(width.W))
    val b = Input(UInt(width.W))
    val lt = Output(Bool)
    val out = Output(UInt(width.W))
  })

  // Comparing
  val width_exp = log2Ceil(width)
  val padding = pow(2, width_exp).intValue - width
  def comp_op1 = Cat(io.a, 0.U(padding.W))
  def comp_op2 = Cat(io.b, 0.U(padding.W))
  io.lt := lt

  // Subtracting
}
object AbsDiff {
  def apply(a: UInt, b: UInt) = {
    val core = Module(new AbsDiff(a.getWidth))
    core.io.a := a
    core.io.b := b
    (core.io.lt, core.io.out)
  }
}

// The LUT table for the
