package mogami.execute

import chisel3._
import chisel3.util._
import chisel3.iotesters.PeekPokeTester

// The object that simulate the instIndex function.
object InstIndexDummy {
  // The base index value
  val base = Wire(UInt(4.W))

  // The function used as the initialization argument
  val instIndex = (_ + base)
}

class PackDependencyTester(c: PackDependency) extends PeekPokeTester(c) {
  // We have the following cases:
  // 1. No write address appears anywhere as an operand in this packet.
  // 2. A write address appears as an operand before this instruction in the packet. (RAW)
  // 3. A write address appears as an operand of the current instruction. (No RAW)
  // 4. A write address appears as an operand after the current instruction. (No RAW)
  // 5. Cases 2 - 4 all appears.
  // 6. Case 5 with some input and output disabled.
  // 7. Read_sel testing: independent operand, dependent operand, imm, x0 are used in order.

  // Set up module and connect valid bits
  val dut = new PackDependency(InstIndexDummy.instIndex)
  val read_valid = Vec(12, Bool())
  val write_valid = Vec(4, Bool())
  val read_out_valid = Vec(12, Bool())
  ((dut.io.read reduceLeft :+) zip read_valid) map (_.valid := _)
  (dut.io.write zip write_valid) map (._valid := _)
  (read_out_valid zip (dut.io.read_out reduceLeft :+)) map (_ := _.valid)

  // Set all operands and write valid
  poke(read_valid, 0xfff)
  poke(write_valid, 0xf)

  // Array of fed input and expected output
  // Fixed read address for all cases
  val fed_read = List(List(1, 2, 3), List(4, 5, 6), List(7, 7, 8), List(1, 2, 8))
  // Write addresses for different cases
  val fed_write = List(
    List(10, 11, 12, 13),
    List(7, 8, 12, 13),
    List(10, 6, 12, 13),
    List(10, 11, 12, 7),
    List(7, 7, 12, 7),
    List(7, 8, 12, 6)
  )
  val expected_read_out_present = List(
    List(List(True, True, True), List(True, True, True), List(True, True, True), List(True, True, True)),
    List(List(True, True, True), List(True, True, True), List(False, False, False), List(True, True, False)),
    List(List(True, True, True), List(True, True, True), List(True, True, True), List(True, True, True)),
    List(List(True, True, True), List(True, True, True), List(True, True, True), List(True, True, True)),
    List(List(True, True, True), List(True, True, True), List(False, False, True), List(True, True, True)),
    List(List(True, True, True), List(True, True, True), List(False, True, True), List(True, True, True)),
  )
  val expected_read_sel = List()
  val expected_rename_en = List()

  // Implement the process
  for (i <- 0 until 6) {
    // If it is the last cycle, replace valid bit
    if (i == 5) {
      poke(read_valid, 0xfef)
      poke(write_valid, 0xb)
    }

    for (j <- 0 until 4) {
      for (k <- 0 until 3)
        // (0x300 is the upper two bits)
        poke(dut.io.read(j)(k).data, Operand(0, 0, True, 0x300 | fed_read(i)(j)(k)))
      poke(dut.iowrite(j).data, fed_write(i)(j))
    }

    expect(read_valid, peek(read_out_valid))
    for (j <- 0 until 4) {
      for (k <- 0 until 3) {
        // (0x300 is the upper two bits)
        expect(dut.io.read_out(j)(k).data, Operand(0, 0,
          expected_read_out_present(i)(j)(k), 0x300 | fed_read(i)(j)(k)))
        //expect(dut.io.read_sel(j)(k), expected_read_sel(i)(j)(k))
      }
      //expect(dut.io.rename_en(j).data, expected_rename_en(i)(j))
    }

    step(1)
  }
}
class PackDependencySpec extends FlatSpec with Matchers {
  behavior of "PackDependencySpec"

  it should "detect the dependency in an inst pack" in {
    chisel3.iotesters.Driver(() =>
      new PackDependency(InstIndexDummy.instIndex)) { c =>
        new PackDependencyTester(c)
      } should be(true)
  }
}
