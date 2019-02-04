# Mogami

---

## Introduction

Mogami is a RISC-V CPU (RV64GC) with out-of-order execution, and it is inteneded to be Linux-compatible. This project is designed for low-cost chip and currently targets Xilinx Artix-7 FPGA (because I ran out of money buying an FPGA).

This project started in March 2018 and was written in Verilog at the time, then it was switched to Chisel. The (abandoned) original Verilog source files are under /old-verilog.

This project is currently in development; no release is available at this time.

## File Structure

The source files and documentations are organized in the following folders:

- `/docs`: The architecture documentations.
- `/lut-gen`: The division / square-root lookup table generation programs. It is written in C with embedded Sollya script (a open-source numerical library by INRIA) and used to calculated the seed value of FP division and square-root.
- `/old-verilog`: The old (System)Verilog source file. It is not well organized and only preserved in case that some components are already implemented in Verilog.
- `/src/main/scala/mogami`: The source folder.
  - `arithmetic`: ALU and FPU implementation.
  - `execute`: The decode, dispatch and control units.
  - `fetch`: The instruction fetching unit.
  - `memory`: MMU, cache, load/store reorder buffer, and atomic operation implementation.
  - `util`: Miscellaneous components that can be used in different unit.

Other folders and files not listed above are build configuration directly from https://github.com/freechipsproject/chisel-template.

## Proposed Architecture

*Because this processor is still in development, the architecture is not fixed and may be changed at any time.*

Currently, Mogami is designed to be able to fetch and decode four instructions per cycle. TAGE branch predictor is being considered but might be replaced by a normal tournament predictor if block RAM resources are not sufficient.

Every instruction can be decoded to up to four micro-operations in the decode unit, then they will be sent to the dispatch queue. Each Mogami core is capable to issue up to 8 micro-ops per cycle.

FPU and integer ALU are highly integrated, and it is impossible to disable FPU only. There are several kinds of arithmetic units connected to the dispatch bus:
- Single Cycle Unit: process all single cycle instructions, including bitwise operation, floating point equal, sign injection and classification.
- Integrated Shifter and Integer Divider: Perform integer division and shift operations. It has one input port and two output ports, one for shifting and one for division.
- Comparator: Perform comparation (for both integer and FP) and min/max operations.
- FP Division / Square-root Seed Generator: Generate the seed value for Goldschmidt's algorithm in FP division and square-root. See Piniero's paper below for details.
- Fused Multiply-Add Unit: Process all fused multiply-add, add, and multiply (for both integer and FP) operations. FP conversions also use this unit. The only FP rounder is in this component.

There are four register banks per CPU, each with 64 entries that can be used as either FP or integer register. Each entry has 72 bits, with high 8 bits as floating point flag field (see `/docs/internal_repr.md`). Every bank has four read ports and one write port (corresponding to one CDB bus); if more than four operands in the instruction pack being decoded are supplied by one bank, the pipeline will stall until the conflict is resolved.
