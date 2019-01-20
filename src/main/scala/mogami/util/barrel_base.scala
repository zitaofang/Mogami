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
abstract class BaseBarrelSlice[T] {
  // in:
  // The input of data. in.length must be divisible by block_size.
  // shift:
  // The boolean value that control if the object needed to be shifted.
  // to_right:
  // The control signal of shifting direction.
  def in: SlicePort[T]
  def shift: Bool
  def to_right: Bool

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

  // The subclass can override the way how the element is grouped.
  // But for the default case, use iterable.group
  def grouped = in.data group block_size

  // =========================
  // Internal states
  val block_mux = (s: Bool, a: T, b: T) => (a zip b) map mux_func(s, _, _)
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
abstract class ShifterSlice[T] extends BarrelRotator[T] {
  def left_in_ctr: T
  def right_in_ctr: T

  override def right_in_blk = (0 until block_size) map right_in_ctr
  override def left_in_blk = (0 until block_size) map left_in_ctr
}

// The rotator class
abstract class RotatorSlice[T] extends BarrelRotator[T] {
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
  val right_padded_in = ((0 until padding) map right_in_ctr) ++ in.data
  val left_padded_in = in.data ++ ((0 until padding) map left_in_ctr)
  val padded_in = if (padding_right) right_padded_in else left_padded_in
  override def grouped = padded_in group block_size
}
