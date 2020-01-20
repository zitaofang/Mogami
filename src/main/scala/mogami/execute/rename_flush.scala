package mogami.execute

import chisel3._
import chisel3.util._

// Rename Table Flush controller, activated if a register bank
// is full or empty. It will take 18-20 cycles to finish.
// It has three-stage pipeline: RRRT (read RRT), RREG (read reg), WREG (write reg).
// It will reset the rename table to their initial value and move
// data between corresponding physical register
class RenameFlushControl extends Module {
  val io = IO(new Bundle() {
    // The register bank selection
    val read_bank = Output(Bool())
    val write_bank = Output(Bool())

    val flush_req = Filpped(Irrevocable(DontCare))

    val rrt_addr = Vec(4, Valid(UInt(6.W)))
    val rrt_data = Input(Vec(4, UInt(8.W)))
    val reg_read = Vec(4, MemReadIO(8, 72))
    val reg_write = Vec(4, MemWriteIO(6, 72))
  })

  // The current bank
  val bank_reg = RegInit(false.B)
  io.read_bank := bank_reg
  // When the controller is activated, invert the write bank
  // signal so that the data will be transferred to another bank.
  // Delay two cycle to match the WREG
  io.write_bank := bank_reg ^ flush_req.valid

  // The counter of current registers being transferred
  val finished = Wire(Bool())
  val reg_counter = Wire(UInt(4.W))
  // Reset the counter once finished
  withReset(reset | finished) {
    // Note that it will only go to 15; once reach 16, reset is
    // triggered and move back to 1
    Cat(finished, reg_counter) := Counter(32, flush_req.valid)._1
  }

  // Send deactivation signal when WREG of the last cycle begins.
  // RRT will be reset when ready is high.
  io.flush_req.ready := RegNext(finished)

  // The enable bits for memory ops
  val rreg_valid = RegNext(valid & ~RegNext(finished))
  val wreg_valid = RegNext(rreg_valid)
  // Set the address during transfer
  (0 until 4) map (i => {
    io.rrt_addr(i) := Cat(reg_counter, i.U(2.W))
    io.reg_read(i).addr.bits := RegNext(io.rrt_data(i))
    io.reg_read(i).addr.valid := rreg_valid
    io.reg_write(i).bits.addr := RegNext(RegNext(reg_counter))
    io.reg_write(i).bits.data := io.reg_read(i).data
    io.reg_write(i).valid := wreg_valid
  })
}
