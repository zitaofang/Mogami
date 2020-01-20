package mogami.arithmetic.integer

import chisel3._
import chisel3.util._

// Basic lookahead block
class Lookahead extends Module {
  val io = IO(new Bundle{
    val g = Input(UInt(4.W))
    val p = Input(UInt(4.W))
    val g_out = Output(Bool())
    val p_out = Output(Bool())
    val c0_out = Output(UInt(4.W))
    val c1_out = Output(UInt(4.W))
  })

  // Internally generated carry for each bit
  val internal_g = Cat(
    false.B,
    io.g(0),
    io.g(1) | io.p(1) & io.g(0),
    io.g(2) | io.p(2) & io.g(1) | io.p(2) & io.p(1) & io.g(0)
  )
  // Propagated external carry to each bit
  val internal_p = Cat(
    true.B,
    io.p(0),
    io.p(1) & io.p(0),
    io.p(2) & io.p(1) & io.p(0)
  )
  // When external carry is 0...
  io.c0_out := internal_g
  // When external carry is 1...
  io.c1_out := internal_g | internal_p
  // Group generate
  io.g_out :=
    io.g(3) |
    io.p(3) & io.g(2) |
    io.p(3) & io.p(2) & io.g(1) |
    io.p(3) & io.p(2) & io.p(1) & io.g(0)
  // Group propagate
  io.p_out :=
    io.p(3) & io.p(2) & io.p(1) & io.p(0)
}

object Lookahead {
  // The input and output structure
  class Input extends Bundle {
    val g = UInt(4.W)
    val p = UInt(4.W)
  }
  object Input {
    def apply(g: UInt, p: UInt) = {
      val res = Wire(new Input())
      res.g := g
      res.p := p
      res
    }
  }
  class Output extends Bundle {
    val g = Bool()
    val p = Bool()
    val c0 = UInt(4.W)
    val c1 = UInt(4.W)
  }

  def apply(in: Input) = {
    val out = Wire(new Output())
    val core = Module(new Lookahead())
    core.in.g := in.g
    core.in.p := in.p
    out.g := core.io.g_out
    out.p := core.io.p_out
    out.c0 := core.io.c0_out
    out.c1 := core.io.c1_out
    out
  }
}

// The compound adder
// level: the lookahead level. Note that each lookahead block handles 4 bits.
// Therefore, for a 64 bits adder, the level is 3 (4 ** 3 = 64).
class CompoundAdder(level: Int) extends Module {
  private val input_width = pow(4, level).intValue

  val io = IO(new Bundle{
    val a = Input(UInt(input_width.W))
    val b = Input(UInt(input_width.W))
    val s0 = Output(UInt(input_width.W))
    val s1 = Output(UInt(input_width.W))
    val g = Output(Bool()) // Global generate
    val p = Output(Bool()) // Global propagate
    val sign_c = Output(Vec(2, Bool())) // sign bit carry in, for overflow detection
  })

  // propagate, generate, and sum
  val s = a ^ b
  val g = a & b
  val p = a | b

  // lookahead level
  // exp: 4^exp = (# of lookahead block)
  // g and p: ditto
  // c: a list of tuples of carry when the external carry being passed in
  // is 0 (c[i]._1) or 1 (c[i]._2).
  private def lookahead_slice(exp: Int)
    (g: UInt, p: UInt, c: Seq[Tuple2[UInt, UInt]]) = {
    val num = pow(4, exp).intValue

    val g_split = Vec(num, UInt(4.W))
    g_split := g
    val p_split = Vec(num, UInt(4.W))
    p_split := p
    val seq = (0 until num) map Lookahead.Input(g_split(_), p_split(_))
    val res = seq map Lookhead(_)

    val gout = Cat(res map _.g)
    val pout = Cat(res map _.p)
    val cout = c :+ (res map _.c0, res map _.c1)

    (gout, pout, cout)
  }
  val slice_fn = lookahead_slice _
  val slice_seq = (level - 1 to 0 by -1) map slice_fn(_)
  val (g_res, p_res, lookahead_res) =
    ((g, p, List()) /: slice_seq)(x, f => f.tupled(x))

  // Select and merge
  private def carry_select(c: Tuple2[UInt, UInt], seq: Seq[Tuple2[UInt, UInt]]) = seq match {
    case Nil => c
    case (c0, c1) +: tail => carry_select(
      (
        Cat((c._1.toBool(), c0, c1).zipped map (_ match { case (c, a, b) => Mux(c, b, a) })),
        Cat((c._2.toBool(), c0, c1).zipped map (_ match { case (c, a, b) => Mux(c, b, a) }))
      ),
      tail
    )
  }
  val sel_res = carry_select((false.B, true.B), lookahead_res)
  // Return
  (io.s0, io.s1) := (sel_res._1 ^ s, sel_res._2 ^ s)
  (io.g, io.p) := (g_out, p_out)
  (io.sign_c(1), io.sign_c(0)) := (sel_res._1(63), sel_res._2(63))
}

// The regular lookahead adder, implemented with compound adder
class Adder(level: Int) extends Module {
  private val input_width = pow(4, level).intValue

  val io = IO(new Bundle{
    val a = Input(UInt(input_width.W))
    val b = Input(UInt(input_width.W))
    val cin = Input(Bool())
    val s = Output(UInt(input_width.W))
    val cout = Output(Bool())
    val sign_c = Output(Bool())
  })

  val core = Module(new CompoundAdder(level))
  core.io.a := io.a
  core.io.b := io.b
  io.s := Mux(cin, core.io.s1, core.io.s0)
  io.cout := core.io.g | core.io.p & io.cin
  io.sign_c := Mux(cin, core.io.sign_c(1), core.io.sign_c(0))
}
