package mogami.execute

import chisel3._
import chisel3.util._

// Register file bank, 64 * 64 bits
// One bank support 4 read port and 1 write port.
// (Actually there is four copies of the data in one bank)
class RegFileBank extends Module {
  val io = IO(new Bundle() {
    val read_addr = Input(Vec(4, UInt(6.W)))
    val write_addr = Input(UInt(6.W))
    val read_data = Output(UInt(6.W))
    val write_addr = Input(UInt(6.W))
  })
}

// The associated free entry list
class RegBankFreeList extends Module {
  val io = IO(new Bundle() {
    val empty = Output(Bool)
    val alloc_reg = Input(Bool)
    val alloc_reg_addr = Output(UInt(6.W))
    val free_reg = Input(Valid(UInt(6.W)))
  })
}
