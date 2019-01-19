package mogami.util

import chisel3._
import chisel3.util._

// The object of data between slice`
abstract class SlicePort[T] {
  def data: Seq[T]
}
case class SliceSimplePort[T](data: Seq[T]) extends SlicePort[T]
case class SliceReducePort[T](data: Seq[T], reduce: T) extends SlicePort[T]

// The general barrel shifter/rotator slice.
// in:
// The input of data. in.length must be divisible by block_size.
// shift:
// The boolean value that control if the object needed to be shifted.
// to_right:
// The control signal of shifting direction.
abstract class BaseBarrelSlice[T]
(in: SlicePort[T], shift: Bool, to_right: Bool) {
  // The interface provided by the subclass.
  // block_size: the size of the data block, the basic unit of data
  // being shifted.
  // mux_func: A function that acts as a mux of general objects (not just
  // the subclasses of Data).
  // right_in_blk: The data block shifting in from the right.
  // left_in_blk: The data block shifting in from the left.
  // barrel_in: the actual input that the slice will take. Can be overloaded.
  def block_size: Int
  def mux_func: (Bool, T, T) => T
  def right_in_blk: Seq[T]
  def left_in_blk: Seq[T]
  def barrel_in = in.data

  // =========================
  // Internal states
  val block_mux = (s: Bool, a: T, b: T) => (a zip b) map mux_func(s, _, _)

  val grouped = barrel_in group block_size

  val shifted_r = right_in_blk +: grouped.init
  val shifted_l = grouped.tail :+ left_in_blk
  val shifted = (shifted_r zip shifted_l) map block_mux(to_right, _, _)
  // =========================
  // The output of the shift.
  // data: The main output of the shifter.
  // right_out_blk: The rightmost block being shifted out. It is
  // equal to left_in_blk if no shift occurs.
  // left_out_blk: Ditto, but this is the leftmost block.
  val data_out = (shifted zip grouped) flatMap block_mux(sel, _, _)
  val right_out_blk = block_mux(sel, grouped.last, right_in_blk)
  val left_out_blk = block_mux(sel, grouped.head, left_in_blk)

  // The actual output
  def result = new SliceSimplePort(data_out)
}

// The helper function
object BaseBarrelSlice {
  def apply(in: SlicePort[T], shift: Bool, to_right: Bool) = {

  }
}

// The shifter class
abstract class ShifterSlice[T](in: SlicePort[T], shift: Bool, to_right: Bool)
extends BarrelRotator(in, shift, to_right) {
  def left_in_ctr: T
  def right_in_ctr: T

  override def right_in_blk = (0 until block_size) map right_in_ctr
  override def left_in_blk = (0 until block_size) map left_in_ctr
}

// The rotator class
abstract class RotatorSlice[T](in: SlicePort[T], shift: Bool, to_right: Bool)
extends BarrelRotator(in, shift, to_right) {
  override def right_in_blk = left_out_blk
  override def left_in_blk = right_out_blk
}

// The shift-out reduce trait: Apply reduce function on shifting out
trait ShiftOutReduce {
  type T
  this: ShifterSlice[T] =>

  def reduce_ctr: T
  def reduce_func: (T, T) => T

  def reduce_in: T
  // =======================
  val reduce_block = (0 until block_size) map reduce_ctr
  // =======================
  val reduce_out = (reduce_in /: reduce_block)(reduce_func)
  override def result = new SliceReducePort(data_out, reduce_out)
}

// The unaligned shift trait: Allow the width of input to be indivisible by
// block_size
trait UnalignedShifter {
  type T
  this: ShifterSlice[T] =>

  def padding_right: Boolean

  val padding = in.length % block_size
  val padding_ctr = if (padding_right) right_in_ctr else left_in_ctr
  override def barrel_in = in ++ ((0 until padding) map padding_ctr)
}

// The actual shifter/rotator
object Barrel {
  def apply(slice: Seq[BaseBarrelSlice[T]])
    (in: SlicePort[T], shamt: UInt, to_right: Bool) = {
      
    }

}

// A general shifter that can shift anything (Yes, <: Any)
object GeneralShift {
  def apply[T](left_in_ctr: T, right_in_ctr: T,
    mux_func: (Bool, T, T) => T, reduce_out: (T, T) => T)
    (in: Seq[T], reduce_init: T, shamt: UInt, to_right: Bool) = {
      // slice
      val shift_slice = (l: Int)(s_in: (Seq[T], T), sel: Bool) => {
        // Create empty shift-in block
        val block_size = math.pow(2, l).intValue
        val block_mux = (s: Bool, a: T, b: T) =>
          (a zip b) map mux_func(s, _, _)
        val right_in_blk = (0 until block_size) map right_in_ctr
        val left_in_blk = (0 until block_size) map left_in_ctr
        val grouped = s_in._1 group block_size

        val reduce_sel = block_mux(to_right,
          block_mux(sel, grouped.last, right_in_blk),
          block_mux(sel, grouped.head, left_in_blk)
        )

        val shifted_r = right_in_blk +: grouped.init
        val shifted_l = grouped.tail :+ left_in_blk
        val shifted = (shifted_r map shifted_l) map block_mux(to_right, _, _)

        val res = (shifted zip grouped) flatMap block_mux(sel, _, _)
        val reduced = (s_in._2 /: reduce_sel)(reduce_out(_, _))
        (res, reduced)
      }
      val shamt_unpacked = Wire(Vec(shamt.getWidth, Bool))
      shamt_unpacked := shamt
      ((in, reduce_init) /: (0 until shamt.getWidth))
        (input, i => shift_slice(i)(input, shamt_unpacked(i)))
    }
  // The version without reducing shift-out
  def apply[T](left_in_ctr: T, right_in_ctr: T,
    mux_func: (Bool, T, T) => T)
    (in: Seq[T], shamt: UInt, to_right: Bool) = {
      // The dummy reduce
      val dummy_reduce_func = (a: T, b: T) => a
      val dummy_reduce_init = right_in_ctr

      apply(left_in_ctr, right_in_ctr, mux_func, dummy_reduce_func)
        (in, dummy_reduce_init, shamt, to_right)._1
    }
  // The version shifting right, with only one empty object constructor
  def apply[T](in_ctr: T, mux_func: (Bool, T, T) => T)
    (in: Seq[T], shamt: UInt) =
      apply(in_ctr, in_ctr, mux_func)(in, shamt, true.B)._1
}
