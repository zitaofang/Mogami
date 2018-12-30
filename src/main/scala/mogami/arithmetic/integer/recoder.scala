import chisel3._
import chisel3.util._

// The 64 bits SD4 interface
class SD4Port extends Module {
  val sign = UInt(32.W)
  val nonzero = UInt(32.W)
  val shift = UInt(32.W)
}

// SD4 Recoder Core
// This recoder is based on the following literature:
// Lyu CN, Matula DW. Redundant binary booth recoding. InComputer Arithmetic, 1995.,
//      Proceedings of the 12th Symposium on 1995 Jul 19 (pp. 50-57). IEEE.
// For the explanation of the ports, please refer to the origin paper,
// Page .
// TODO fill in
class RecoderInPort extends Bundle {
  val l = Bool
  val r_2m = Bool
  val r_1s = Bool
  val r_1m = Bool
}
class RecoderOutPort extends Bundle {
  val sign = Bool
  val m_2 = Bool
  val m_1 = Bool
  val m_0 = Bool
}
// The converter from Lyn and Matula's recoder output format
// to the processor format
val cellOutputToSD4 = (in: RecoderOutPort) => {
  val out = new SD4Port
  out.sign := in.sign
  out.nonzero := m_0
  out.shift := m_2
  out
}
// The module
class SD4RecoderCoreCell extends Module {
  val io = IO(new Bundle{
    val in = Input(RecoderInPort)
    val carry_in = Input(Bool)
    val out = Output(RecoderOutPort)
    val carry_out = Output(Bool)
  })

  io.out.sign := io.in.r_2m ^ io.in.r_1s;
  io.carry_out := ~(io.in.l | io.in.r_1s);
  io.out.m_1 := io.in.r_1m ^ io.carry_in;
  // An intermediate value: see the graph in the paper for details
  val m_int = io.in.sign ^ io.in.r_1m;
  io.out.m_2 := ~(~m_int | io.in.m_1);
  io.out.m_0 := ~(m_int | io.in.m_1);
}

// SD4 2's complement recoder
// Also, see the original paper for details
class SD4Recoder2CCell extends Module {
  val io = IO(new Bundle{
    val in = Input(UInt(2.W))
    val carry_in = Input(Bool)
    val out = Output(SD4Port)
    val carry_out = Output(Bool)
  })
  val core = Module(new SD4RecoderCoreCell)
  core.io.in.l := ~io.in(1)
  core.io.in.r_2m := io.in(1)
  core.io.in.r_1s := false.B
  core.io.in.r_1m := io.in(0)
  core.io.carry_in := io.carry_in

  io.out := cellOutputToSD4(core.io.out)
  io.carry_out := core.io.carry_out
}

// SD4 carry-save recoder
class SD4RecoderCSCell extends Module {
  val io = IO(new Bundle{
    val in_c = Input(UInt(3.W))
    val in_s = Input(UInt(3.W))
    val carry_in = Input(Bool)
    val out = Output(SD4Port)
    val carry_out = Output(Bool)
  })
  // Generate the intermediate values (see the paper)
  val tmp = Array(~(io.in_c(2) ^ io.in_s(2)), ~(io.in_c(1) | io.in_s(1)),
    ~(io.in_c(1) ^ io.in_s(1)), ~(io.in_c(0) | io.in_s(0)))

  val core = Module(new SD4RecoderCoreCell)
  core.io.in.l := ~(tmp(0) & ~tmp(2))
  core.io.in.r_2m := tmp(3) ^ tmp(2)
  core.io.in.r_1s := ~(tmp(1) | ~tmp(0))
  core.io.in.r_1m := tmp(1) ^ tmp(0)
  core.io.carry_in := io.carry_in

  io.out := cellOutputToSD4(core.io.out)
  io.carry_out := core.io.carry_out
}

// Configurable SD4 2's complement recoder slice
class SD4Recoder2C(width: Int) extends Module {
  val comp_num = width / 2

  val io = IO(new Bundle{
    val in = Input(UInt(width.W))
    val out = Output(Vec(comp_num, SD4Port))
    val carry_out = Output(Bool)
  })

  // Create component, connect carry bits
  val comp_arr = (0 until comp_num) map Module(new SD4Recoder2CCell)
  val comp_carry = comp_arr map (_.io.carry_out)
  for (i <- 1 until comp_num) {
    comp_arr(i).io.carry_in := comp_carry(i - 1)
  }
  comp_arr(0).io.carry_in := false.B
  io.carry_out := comp_arr(comp_num - 1).io.carry_out

  // Connect input and output
  val in_spliter = Wire(Vec(comp_num, UInt(2.W)))
  in_spliter := in
  for (i <- 0 until comp_num) {
    comp_arr(i).io.in := in_spliter(i)
    io.out(i) := comp_arr(i).io.out
  }
}

// Configurable SD4 carry-save recoder slice
class SD4RecoderSC(width: Int) extends Module {
  val comp_num = width / 2

  val io = IO(new Bundle{
    val in_s = Input(UInt(width.W))
    val in_c = Input(UInt(width.W))
    val out = Output(Vec(comp_num, SD4Port))
    val carry_out = Output(Bool)
  })

  // Create component, connect carry bits
  val comp_arr = (0 until comp_num) map Module(new SD4RecoderCSCell)
  val comp_carry = comp_arr map (_.io.carry_out)
  for (i <- 1 until comp_num) {
    comp_arr(i).io.carry_in := comp_carry(i - 1)
  }
  comp_arr(0).io.carry_in := false.B
  io.carry_out := comp_carry(comp_num - 1)

  // Connect input and output
  // Since this recoder also needs the higher bit from the 2-bit group on
  // the right (for group 0, that bit is 0), I create another arry to hold these.
  val aug_s = Cat(io.in_s, false.B)
  val aug_s = Cat(io.in_c, false.B)
  val in_s_spliter = (0 until comp_num) map ((i: Int) => aug_s(2 * i + 2, 2 * i))
  val in_c_spliter = (0 until comp_num) map ((i: Int) => aug_c(2 * i + 2, 2 * i))
  in_c_spliter := in
  for (i <- 0 until comp_num) {
    comp_arr(i).io.in_s := in_s_spliter(i)
    comp_arr(i).io.in_c := in_c_spliter(i)
    io.out(i) := comp_arr(i).io.out
  }
}
