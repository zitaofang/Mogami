package mogami

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

// Quick +1 or -1 implemented with QuickPlusOne
object QuickIncrementer {
  def apply(a: UInt, enable: Bool, decrement: Bool) = {
    val width = a.getWidth
    QuickPlusOne(Fill(width, decrement) ^ a) ^ Fill(width, decrement)
  }
}

// The memory read port (only used for synchronized read)
// The memory use this port as-is, and the client flips it
class MemReadIO[T <: Data](addr_w: Int, data_type: T) extends Bundle {
  val addr = Flipped(Valid(UInt(addr_w.W)))
  val data = Output(data_type)
}
object MemReadIO {
  def apply[T <: Data](addr_w: Int, data_type: T) =
    new MemReadIO(addr_w, data_type)
}

// The memory write port
// The memory use this port as-is; client flips it
class MemWriteIO[T <: Data](addr_w: Int, data_type: T) extends Bundle {
  val addr = UInt(addr_w.W)
  val data = T
}
object MemWriteIO {
  def apply[T <: Data](addr_w: Int, data_type: T) =
    Flipped(Valid(new MemWriteIO(addr_w, data_type)))
}

// Fill a data bundle with 0
object FillZero {
  def apply[T <: Data](gen: T) = {
    val zero = 0.U(gen.getWidth.W)
    val ret = Wire(t)
    ret := zero
    ret
  }
}

// The LUT table for the
