package mogami.arithmetic.integer

import chisel3._
import chisel3.util._

object CSAUtil {
  // The csa function, with one bit carry out on the left
  def csa(width: Int)(a: UInt, b: UInt, c: UInt, carry_in: Bool): Tuple2[UInt, UInt] = {
    val s = UInt((width + 1).W)
    val c = UInt((width + 1).W)

    s := Cat(false.B, a ^ b ^ c)
    c := Cat((a & b) | (b & c) | (c & a), carry_in)

    (s, c)
  }

  // The half adder
  def ha(width: Int)(a: UInt, b: UInt, carry_in: Bool): Tuple2[UInt, UInt] = {
    val s = UInt((width + 1).W)
    val c = UInt((width + 1).W)

    s := Cat(false.B, a ^ b)
    c := Cat(a & b, carry_in)

    (s, c)
  }

  // The csa tree: keep applying csa to compress data until two are left.
  // It is a Wallace Tree, but I will leave the width specification to
  // the optimizer.
  def csa_tree(width: Int)(in_arr: Seq[UInt]): Tuple2[UInt, UInt] = {
    // A simple sequence-to-tuple function ("false" is the carry in, not used here)
    val to_tuple = (arr: Seq[UInt]) => arr.toList match { case List(a, b, c, _*) => (a, b, c, false.B) }
    // Another simple tuple-to-sequence function (for Tuple2)
    val to_seq = (tup: Tuple2[UInt, UInt]) => List(tup._1, tup._2)
    // The internal function for folding
    @scala.annotation.tailrec
    def csa_slice(from_right: Boolean, in_array: Seq[UInt]): Seq[UInt] = {
      if (in_array.length <= 2)
        in_array
      else {
        val len = in_array.length
        val comp_num = len / 3
        val slice_sel =
          if (from_right) (i: Int) => in_array.slice(3 * i, 3 * i + 3)
          else (i: Int) => in_array.slice(len - (3 * i + 3), len - 3 * i)
        val tail_slice =
          if (from_right) in_array.slice(3 * comp_num, len)
          else in_array.slice(0, len - 3 * comp_num)
        val out_array = ((0 until comp_num) flatMap (i => to_seq((csa(width) _).tupled(to_tuple(slice_sel(i))))))

        csa_slice(!from_right,
          if (from_right) out_array ++ tail_slice
          else tail_slice ++ out_array
        )
      }
    }

    // Return the tree
    val res = csa_slice(true, in_arr)
    (res(1), res(0))
  }
}
