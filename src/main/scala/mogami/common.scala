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

// Valid data compression
// width_exp: the width will be 2 ** width_exp
class CompressValid[T <: Data](width_exp: Int, t: T) extends Module {
  val width = math.pow(2, width_exp).intValue
  val t_width = t.getWidth

  val io = IO(new Bundle() {
    val in = Vec(width, Flipped(Valid(t)))
    val out = Vec(width, Valid(t))
  })

  def empty_t = 0.U(t_width).asTypeof(t)

  // apply "|" on two valid data pack
  def or_valid(a: Seq[(Bool, T)], b: Seq[(Bool, T)]) = {
    val valid = (a zip b) map _._1 | _._1
    val bits = (a zip b) map Mux1H(List(_._2, _._2))
    valid zip bits
  }

  def shift_valid(in: Seq[(Bool, T)], shamt: UInt) =
    GeneralShift((false.B, t),
      (sel, a, b) => (Mux(sel, a._1, b._1), Mux(sel, a._2, b._2))
    )(in, shamt)

  def compress_cell(level: Int)(a: (Seq[(Bool, T)], UInt),
    b: (Seq[(Bool, T)], UInt)) = {
      val in_width = math.pow(2, level).intValue
      val a_padded = List.fill(in_width)((false.B, empty_t))
        :+ a._1
      val b_padded = b._1 +:
        List.fill(in_width)((false.B, 0.U(t_width).asTypeof(t)))
      (or_valid(a_padded, shift_valid(b_padded, a._2)), a._2 +& b._2)
    }
  def compress_slice(level: Int)(in: Seq[(Seq[(Bool, T)], UInt)]) = {
    val cell_func = compress_cell(level) _
    (in group 2) map t => cell_func(t(0), t(1))
  }
  val compress_slice_func = compress_slice _

  // Extract valid and bits from input Valid
  val extracted = (io.in map _.valid) zip (io.in map _.bits)
  // Format the extracted bits
  val initial = extracted map pair => (List(pair), pair._1.asUInt(1.W))
  // Apply slice
  val result = (initial /: (0 until width_exp))(compress_slice_func(_))
  // Assign it to the io
  (io.out zip result(0)._1) map (port, res) => {
    port.valid := res._1
    port.bits := res._2
  }
}

// The LUT table for the
