import chisel3._
import chisel3.util._

// The csa function, with one bit carry out on the left
def csa(width: Int)(a: UInt, b: UInt, c: UInt): Tuple2[UInt, UInt] = {
  val s = UInt((width + 1).W)
  val c = UInt((width + 1).W)

  s := Cat(false.B, a ^ b ^ c)
  c := Cat((a & b) | (b & c) | (c & a), false.B)

  (s, c)
}

// The csa tree: keep applying csa to compress data until two are left.
// It is a Wallace Tree, but I will leave the width specification to
// the optimizer.
def csa_tree(width: Int)(in_arr: List): Tuple2[UInt, UInt] = {
  // A simple array-to-tuple function
  val to_tuple = (arr: List) => (case List(a, b, c, _*) => (a, b, c))
  // The internal function for folding
  @scala.annotation.tailrec
  def csa_slice(from_right: Boolean, in_array: List) = {
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
      val out_array =(0 until comp_num) map (csa(width) _).
        tupled(to_tuple(slice_sel(_)))

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
