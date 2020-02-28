package mogami.execute

import chisel3._
import chisel3.util._
import mogami.FillZero

// A bank of the instruction queue. A queue has 8 banks.
class DispatchQueueBank extends Module {
  val io = IO(new Bundle() {
    val ready = Output(Bool())
    val input = Vec(2, Flipped(Valid(new MicroOps())))
    val output = Irrevocable(new MicroOps())
  })
  // One bank is capable to hold 8 uops.
  val ram = RegInit(Vec(8, FillZero(new MicroOps())))
  // The head and tail registers
  val head = RegInit(0.U(3.W))
  val tail = RegInit(0.U(3.W))

  // The input has been compressed, so it is guaranteed that the second
  // entry is valid only if the first one is valid.

}
