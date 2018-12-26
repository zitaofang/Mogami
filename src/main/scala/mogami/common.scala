import chisel3._
import chisel3.util._

// Multi-level mux
def array_mux(ctl: Bool, input: Array(2)) =
  Mux(ctl, input(1), input(0))
def reduce_mux_slice(ctl: Bool, input: Array) =
  (0 until input.length / 2) map (
    (i: Int) => Mux(ctl, input(input.length / 2 + i), input(i))
  )
def reduce_mux (ctl: UInt, input: Array) =
  ((0 until log2Floor(ctl.getWidth)) foldLeft(input) (
    (ctl_b: UInt, input_slice: Array) => reduce_mux_slice(ctl_b, input_slice)
  ))
