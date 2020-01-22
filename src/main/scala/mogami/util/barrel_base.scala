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
  def grouped = (in.data grouped block_size).toSeq

  // =========================
  // Internal states
  val block_mux = (s: Bool, a: Seq[T], b: Seq[T]) => (a zip b) map
    (_ match {case (a, b) => mux_func(s, a, b)})
  val shifted_r = right_in_blk +: grouped.init
  val shifted_l = grouped.tail :+ left_in_blk
  val shifted = (shifted_r zip shifted_l) map
    (_ match { case (r, l) => block_mux(to_right, r, l) })
  // =========================
  // The output of the shift.
  // data: The main output of the shifter.
  // right_out_blk: The rightmost block being shifted out. It is
  // equal to left_in_blk if no shift occurs.
  // left_out_blk: Ditto, but this is the leftmost block.
  val data_out = (shifted zip grouped) flatMap (_ match { case (s, g) => block_mux(shift, s, g) })
  val right_out_blk = block_mux(sel, grouped.last, right_in_blk)
  val left_out_blk = block_mux(sel, grouped.head, left_in_blk)

  // The actual output
  def result = new SliceSimplePort(data_out)
}

// The shifter class
abstract class ShifterSlice[T] extends BaseBarrelSlice[T] {
  def left_in_ctr: T
  def right_in_ctr: T

  override def right_in_blk = List().padTo(block_size, right_in_ctr)
  override def left_in_blk = List().padTo(block_size, left_in_ctr)
}

// The rotator class
abstract class RotatorSlice[T] extends BaseBarrelSlice[T] {
  override def right_in_blk = left_out_blk
  override def left_in_blk = right_out_blk
}

// The shift-out reduce trait: Apply reduce function on shifting out.
// WARNING: Always put this trait as the last trait. Other traits may
// override the result as a simple port and discard the reduced value.
trait ShiftOutReduce[T] {
  this: ShifterSlice[T] =>

  def reduce_ctr: T
  def reduce_func: (T, T) => T
  // =======================
  val reduce_in = in match { case SliceReducePort(_, r) => r }
  val reduce_block = List().padTo(block_size, reduce_ctr)
  // =======================
  val reduce_out = (reduce_in /: reduce_block)(reduce_func)
  override def result = new SliceReducePort(this.asInstanceOf[ShifterSlice[T]].result.data, reduce_out)
}

// The unaligned shift trait: Allow the width of input to be indivisible by
// block_size
trait UnalignedShifter[T] {
  this: ShifterSlice[T] =>

  def padding_right: Boolean
  // =======================
  // The padding element #
  val padding = block_size - (in.data.length % block_size)

  // Padded the input
  val right_padded_in = ((0 until padding) map right_in_ctr) ++ in.data
  val left_padded_in = in.data ++ ((0 until padding) map left_in_ctr)
  val padded_in = if (padding_right) right_padded_in else left_padded_in

  // Override group to select the padded input
  override def grouped = List(padded_in grouped block_size)

  // override the output so that its width is equal to the input
  // Note that "right" in this project means smaller index and is
  // opposite to the Scala definition, which means larger index.
  val right_padded_out = data_out drop padding
  val left_padded_out = data_out dropRight padding
  val padded_out = if (padding_right) right_padded_out else left_padded_out
  override def result = new SliceSimplePort(padded_out)
}
