import chisel3._
import chisel3.util._

// Common component used to check the NaN Boxing
def isNaNBoxed(in: UInt(64.W)) = 
  in(63:32).andR
