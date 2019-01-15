import chisel3._
import chisel3.util._

// Multi-level mux
object MultiMux {
  private def array_mux(ctl: Bool, input: Array(2)) =
    Mux(ctl, input(1), input(0))
  private def reduce_mux_slice(ctl: Bool, input: Seq[Data]) =
    (0 until input.length / 2) map (
      (i: Int) => Mux(ctl, input(input.length / 2 + i), input(i))
    )
  def apply (ctl: UInt, input: Seq[Data]) =
    ((0 until log2Floor(ctl.getWidth)) foldLeft(input) (
      (ctl_b: UInt, input_slice: Seq[Data]) => reduce_mux_slice(ctl_b, input_slice)
    ))
}

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

// Quick +1, Canonical adder
object QuickPlusOne {
  def apply(a: UInt, add: Bool) = {
    val carry = (0 until a.getWidth) map (a(_, 0).andR & add)
    a ^ Cat(carry)
  }
}

// The LUT table for the
