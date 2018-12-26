import chisel3._
import chisel3.util._

class DecodeRenameMain extends Module {
  val io = IO(new Bundle{
    // instructions input
    val inst_in = Input(Vec(4, UInt(32.W)))
    // Branch taken signal
    val branch_taken = Output(Vec(4, Bool))
    // ROB pointer, sent to the ROB
    val rob_pointer = Output(UInt(4.W))
    // uop output
    //val uop_dispatch = Output(Vec(4, ))
  })
}
