package mogami.execute.test

import chisel3._
import chisel3.util._
import chisel3.iotesters.PeekPokeTester

// The object that simulate the instIndex function.
object InstIndexDummy {
  // The base index value
  val base = Wire(UInt(4.W))

  // The function used as the initialization argument
  val instIndex = _ + base
}

class PackDependencyTester(c: PackDependency) extends PeekPokeTester(c) {

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
