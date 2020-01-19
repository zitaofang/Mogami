package mogami

import chisel3._
import chisel3.util._
import chisel3.iotesters.PeekPokeTester

// A helper function that generates Operand literal value for poke / expect.
object Operand {
  def apply(value: Long, fp_flag: Byte, present: Boolean, tag: Short) {
    return BigInt(value) << 19 | BigInt(fp_flag) << 11 | BigInt(present) << 10 | BigInt(tag)
  }
}
