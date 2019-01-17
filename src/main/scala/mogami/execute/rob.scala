package mogami.execute

import chisel3._
import chisel3.util._

// The reorder buffer line format
class ROBLine extends Bundle {
  val write_reg = UInt(6.W)
  val write_rename = UInt(8.W)
}

// The completion port data bundle
class CompletionBundle extends Bundle {
  val addr = UInt(6.W)
  val exception = Bool
}

// The ROB bank; there are 4 in total
class ROBBank extends Module {
  val io = IO(new Bundle() {
    val dispatch = MemReadIO(6, new ROBLine())
    val commit = MemWriteIO(6, new ROBLine())

    // Instruction completion
    val complete = Vec(4, Flipped(Vaild(new CompletionBundle())))
  })
}

// The ROB
class ROB extends Module {
  val io = IO(new Bundle() {
    val dispatch = Flipped(Valid(new ROBLine()))
    val commit = Flipped(Valid(new ROBLine()))
    val complete = Vec(4, Flipped(Vaild(new CompletionBundle())))
    
  })


}
