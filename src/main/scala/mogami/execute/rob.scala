package mogami.execute

import chisel3._
import chisel3.util._

// The reorder buffer line format
class ROBLine extends Bundle {
  val exception = Bool
  val write_reg = UInt(6.W)
  val write_rename = UInt(8.W)
}

// The ROB bank; there are 4 in total
class ROBBank extends Module {
  val io = IO(new Bundle() {

  })
}

// The ROB
class ROB extends Module {
  val io = IO(new Bundle() {

  })
}
