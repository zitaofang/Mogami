import chisel3._
import chisel3.util._

// Unaligned PP generation
def generateUnalignedPP(a: UInt, b: SD4Port) = {
  
}

// The multiple matrix
class Multiplier extends Module {
  val io = IO(new Bundle{
    val a = Input(UInt(64.W))
    val b = Input(SD4Port)
    val compensate = Input(Bool)
    val s = Output(UInt(128.W))
    val c = Output(UInt(128.W))
  })

  // Generate partial product
  val unaligned_pp = (0 until 32) map ((i: Int) =>
    Cat(true.B, Mux(io.b.shift(i), Cat(io.a, false.B), Cat(false.B, io.a)))
      ^ Fill(66, io.b.sign(i)) & Fill(66, io.b.nonzero(i))
  )
  val compensate_add = Fill(64, io.compensate) & io.a
  val neg_carry = Cat(io.b.sign(30, 0), io.b.sign(31))

  // Arrange PP in the matrix
  val prefix =
    for (i <- 0 until 32) {
      if (i == 0) Cat(compensate_add(0), neg_carry(i), ~neg_carry(i))
      else Cat(compensate_add(2 * i, 2 * i - 1), true.B)
    }
  val postfix =
    for (i <- 0 until 32) {
      Cat((i == 31).B, neg_carry(i))
    }
  val pp = ((0 until 32) map (i: Int) => Cat(
    0.U(((31 - i) * 2).W), // Left padding
    prefix(i),
    unaligned_pp(i),
    postfix(i),
    0.U((i * 2).W) // Right padding
  )) map _(129, 2) // Skipping the lowest 2 extra bits

  // The Wallace tree
  (io.s, io.c) := csa_tree(128)(pp)
}
