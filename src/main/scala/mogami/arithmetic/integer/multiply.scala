import chisel3._
import chisel3.util._

// General partial product generation
object PPGenerate {
  def apply(a: UInt, b: Vec[SD4Port], compensate: Bool) = {
    val a_width = a.getWidth
    val b_width = b.length
    val out_width = a_width + b_width * 2

    // Generate partial product
    val unmasked_pp = b map Cat(true.B,
      Mux(_.shift, Cat(a, false.B), Cat(false.B, a))
    )
    val unaligned_pp = (unmasked_pp zip b) map (p, s =>
      p ^ Fill(2 + b_width, s.sign) & Fill(2 + b_width, s.nonzero)
    )
    val compensate_add = Fill(b_width, compensate) & a
    val neg_carry = Cat(Cat(b.slice(0, b_width - 2).reverse map _.sign),
      b(b_width).sign)

    // Arrange PP in the matrix
    val prefix =
      for (i <- 0 until b_width) {
        if (i == 0) Cat(compensate_add(0), neg_carry(0), ~neg_carry(0))
        else Cat(compensate_add(2 * i, 2 * i - 1), true.B)
      }
    val postfix =
      for (i <- 0 until b_width) {
        Cat((i == b_width - 1).B, neg_carry(i))
      }
    // Concatenate the bits
    val pp_array = (0 until b_width) map i => Cat(
      0.U(((b_width - 1 - i) * 2).W), // Left padding
      prefix(i),
      unaligned_pp(i),
      postfix(i),
      0.U((i * 2).W) // Right padding
    )
    // Remove extra bit and return
    pp_array map _(out_width + 1, 2)
  }
}

// The multiple matrix
class Multiplier extends Module {
  val io = IO(new Bundle{
    val a = Input(UInt(64.W))
    val b = Input(Vec(32, SD4Port))
    val compensate = Input(Bool)
    val s = Output(UInt(128.W))
    val c = Output(UInt(128.W))
  })
  // Generate pp
  val pp = PPGenerate(io.a, io.b, io.compensate)

  // The Wallace tree
  (io.s, io.c) := csa_tree(128)(pp)
}
