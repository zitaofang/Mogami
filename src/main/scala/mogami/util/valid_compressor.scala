package mogami.util

import chisel3._
import chisel3.util._

// Valid data compression.
// A valid data compressor takes an n-size vector where n must be power of
// 2, and outputs another n-sized vector with all valid data packs falls on the
// "bottom" (the end with lower index) and the number of invalid data packs
// in the array.
// For example: (let LSB has index 0 (lowest))
// 1 0 1 0 1 1 0 0 -> 0 0 0 0 1 1 1 1

// The vector will first be divided into n groups, where every groups has only
// one element.
// Let log2(n) = m, then the compressor can be divided into m "slices", which,
// for every two groups (with size 2^m), merge them into a 2^(m+1) sized group.
// These slices will form a tree-like structure similar to barrel shifter.
// For example:
// group 1  group 0       output group
// 1 1      0 1       =>  0 1 1 1
// This is achieved by:
// 1. appending 0s to the left of group 1 and make its size 2^(m+1):
// 1 1      =>   1 1 0 0
// 2. shift group 1 by the number of empty elements in group 0: (in this case, 1)
// 1 1 0 0  =>   0 1 1 0
// 3. mux group 1 and group 0 - if the data at index i in group 1 is valid,
// select the data in group 1; otherwise, select group 0. Apply "or" to valid bits.
// 0 1 1 0  | (0 0) 0 1 => 0 1 1 1
// 4. add the invalid elements # in group 1 and 0 and output it to the next
// slice, as the invalid elements # of the output group.
// 00 + 01 = 01

class CompressValid[T <: Data](width_exp: Int, t: T) extends Module {
  val io = IO(new Bundle() {
    val in = Vec(width, Flipped(Valid(t)))
    val out = Vec(width, Valid(t))
  })

  type ValidPair = (Bool, T)
  type Block = Seq[ValidPair]
  type SizedBlock = (Block, UInt)

  def slice(in: Seq[SizedBlock]) = {
    // A function that apply "|" on two valid data pack
    val or_valid = (a: Block, b: Block) => {
      val valid = (a zip b) map _._1 | _._1
      val bits = (a zip b) map Mux1H(List(_._2, _._2))
      valid zip bits
    }

    // An empty block
    val empty_t = 0.U(t.getWidth).asTypeof(t)
    val empty_block = List().padTo(in_blk_width, (false.B, empty_t))

    // Split upper and lower half
    val grouped = in group 2
    val upper = grouped map (_(1)._1 ++ empty_block)
    val lower = grouped map (empty_block ++ _(0)._1)
    val shamt = grouped map (_(0)._2)
    val out_size = grouped map a => a(1)._2 +& a(0)._2

    // Shift upper half and apply "|"
    val shifted = (upper zip shamt) map SimpleShifter(_, _)
    val out_block = (shifted zip lower) map or_valid

    // Output
    out_block zip out_size
  }
  @scala.annotation.tailrec
  def tree(in: Seq[SizedBlock]) = in match {
    case Seq(r) => r
    case a => tree(a)
  }

  // Extract valid and bits from input Valid
  val extracted = (io.in map _.valid) zip (io.in map _.bits)
  // Use valid bit as the size of the group (there is only 1 element)
  val initial = extracted map pair => (List(pair), pair._1.asUInt(1.W))
  // apply
  val result = tree(initial)
  // And unpack
  (io.out zip result) map (o, r) => {
    o.valid := r._1
    o.bits := r._2
  }
}

object CompressValid {
  def apply[T <: Data](in: Vec[Valid[T]], t: T) = {
    // Pad
    val level = log2ceil(in.length)
    val padded_in = in.padTo(math.pow(2, level).toInt, Wire(Valid(t)))

    val core = Module(new CompressValid(log2floor(in.length), t))
    core.io.in <> in

    core.io.out take in.length
  }
  // A wrapper applied to tuple of valid bit and data bundle
  def apply[T <: Data](in: Seq[(Bool(), T)], t: T) = {
    val packed_in = padded_in map => {
      val pack = Wire(Valid(t))
      pack.valid := i._1
      pack.bits := i._2
      pack
    }
    apply(packed_in, t)
  }
}
