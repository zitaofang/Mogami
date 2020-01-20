package mogami.util

import chisel3._
import chisel3.util._

// Valid data decompression.
// When data is being compressed, the original index will be stored as
// a part of the output.
// By encoding the vectors of original index bits and feed it to the
// shifter, a compressed data pack can be reordered and decompressed.

class DecompressValid[T <: Data](width_exp: Int, t: T) extends Module {
  val io = IO(new Bundle() {
    val in = Vec(width, Flipped(Valid(t)))
    val in_index = Vec(width, Input(UInt(width_exp.W)))
    val out = Vec(width, Valid(t))
  })

  type IndexPair = ((Bool, T), UInt)
  type Block = Seq[IndexPair]

  val zero_pair = ((false.B, FillZero(t)), 0.U)

  def slice(in: Seq[Block]) = {
    // Extract the MSB and take this bit out from the index
    // Return (the index MSB, the input with index MSB dropped)
    val msb_extractor = (pair: IndexPair) => {
      val index_bit = pair._2.getWidth
      (pair._2(index_bit - 1), (pair._1, pair._2(index_bit - 2, 0)))
    }

    // For every block...
    val block_map = in map (b => {
      // Extract the index MSB
      val extracted = (b map slice)
      // split the upper and lower halves of the original list
      // by filtering by index_msb
      val upper = extracted map Mux(_, _, zero_pair)
      val lower = extracted map Mux(_, zero_pair, _)

      // encode the MSB
      val msb_vec = VecInit(extracted.unzip._1).toUInt
      val shamt = ~PriorityEncoder(msb_vec)

      // Shift the original upper half out of the current lower half
      val shifted_raw = SimpleShifter(upper, shamt)
      // The output of encoder need an additional shift
      val shifted = zero_pair +: shifted_raw.init
      // Combine the upper and lower half
      val half_len = b.length / 2
      // And output
      List((lower grouped half_len)(0), (shifted grouped half_len)(1))
    })

    // Merge the output of every block
    block_map flatMap _
  }

  // Format the input
  val initial = (io.in map (a => (a.valid, a.bits))) zip io.in_index
  // Fold it through
  val result = (initial /: (0 until width_exp))(slice(_))
  // assign them to the output
  (result zip io.out) map ((pair, out) => {
    out.valid := pair._1._1
    out.bits := pair._1._2
  })
}
object DecompressValid {
  def apply[T <: Data](in: Vec[Valid[T]], index: Vec[UInt], t: T) = {
    // Pad
    val level = log2ceil(in.length)
    val padded_in = in.padTo(math.pow(2, level).toInt, Wire(Valid(t)))
    val padded_index = in.padTo(math.pow(2, level).toInt,
      0.U(index(0).getWidth.W))

    val core = Module(new DecompressValid(padded_in.length, t))
    core.io.in <> padded_in
    core.io.in_index <> padded_index

    core.io.out take in.length
  }
}
