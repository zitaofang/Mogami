# Internal Representation of Floating Point Numbers

To improve the computation performance of subnormal numbers and to fit the intermediate values in DIV/SQRT (FP division and square root) operations into the standard register the processor provides, all the floating point numbers in Mogami architecture is stored in a special format different from the IEEE formats. This document provides the detail for these internal formats.

## 1. Overview

All physical registers in Mogami architecture have a width of 72 bits. Beside the lower 64 bits shared by both integer and floating point registers, there are 8 bits, from Bit 71 to Bit 64, that is exclusively used by FP instructions and containing flags and extra space to encode special FP values.

When a value is loaded into a FP register, it will pass through a decoder which sets up all necessary flags. The reverse process also occurs when a FP is converted to an integer value. The detail of such operation will be discussed below.

Mogami uses Goldschmidt's algorithm to calculate the division and square root, which comprises of one "seed generation" uop and three fused multiply-add (FMA) uops, which share the FMA unit with normal macro operations. Since there are constraints of the encoding and precision of the uop operands, they are encoded in a separate format.

## 2. Regular Format

All operands of FP macro operations are encoded in such format. The lower 64 bits follows the IEEE 754 standard **except for the denorms**. In the case of a denorms, the exponent is set to 0 while the mantissa is encoded like a normalized FP - that is, lower 51 bits only contains fraction part, left aligned.

Mogami tracks the denorm exponent (or, the *shamt* of mantissa when being converted to integer format) with the flags section, in bit field 7-2 for double precision and 7-3 for single precision.

The rest of the bit is used to classify the type of this number. These bit helps the component to identify special values without expensive reduce logic.

* Bit 0 is the "ENABLE" bit. If it is not set, this FP is a normal number, and all other bits (except Bit 2, see below) in the flag section are invalid.
* Bit 1 is the "TYPE" bit. Its value depends on whether Bit 0 is set or not.
  * If Bit 0 is set: look at op[62] (double) / op[30] (single), the MSB of the exponent field:
    * If it is cleared: 0 represents zero, and 1 represents denorms (which enabled Bits 7-2 (double) / Bits 7-3 (single) for denorms).
    * If it is set: 0 represent inf, and 1 represents NaN.
  * If Bit 0 is cleared, then this bit should be always set for single FP and cleared for double FP.
* Bit 2 is used as "Invalid NaN Boxing" (INB) bit used by single precision ops. It should be set for all double FP except for denorms, and cleared for all single FP. See the paragraph below for more information.
* Bit 3 is an auxiliary (AUX) bit for the determination of single precision when the number is not a denorm. It should be set for all single FP and cleared for all double FP.

### Regarding NaN Boxing

NaN boxing, according to the standard, is used to prevent the error of feeding a double FP to a single FP operation, which is the only source of invalid NaN boxing error.

Therefore, Bit 2 is always set for all double precision values except for denorms, regardless if "enable" bit is set. Conversely, all single precision value will have Bit 2 cleared. The single operation check if a value is not correctly boxed by checking if Bit 2 is set or op[62] is cleared (which represents a double precision denorm).

Beside clearing bit 2, an single precision FP should always have bit 1 set if it is not a special value, and bit 3 set if it is not a denorm. This helps double precision operations detect a single precision number as NaN.

See the source file, mogami/arithmetic/fp/fp_common.scala, for the detail of the NaN detecting algorithm.

## 3. Intermediate Value

Mogami architecture has two different formats for intermediate values produced by the DIV/SQRT seed generator. This document will not describe the detail of the seed generator (see the file comment for more information) but only the encoding of these intermediate values.

There is no bit to indicate if a value is in the regular FP format or intermediate value formats. The FMA unit is the only component that accept this type of values, and it identifies such values by the 4-bit operation flag it receives independently from the operands.

### a. Seed Output Format

This format is used by the seed generator output. The seed generator output a 30-bit seed in carry-save form, along with all the sign, exponent digits and flags. Belows are the specification.

* op[63]: the output sign.
* op[62:59]: the upper 3 bits of the output exponent, exp[10:7].
* op[58:30]: the lower 29 bits of the seed sum field.
* op[29]: seed.s[29] | seed.c[29].
* op[28:0]: the lower 29 bits of the seed carry field.
* flag[0]: indicate if the result is a special value / not a normalized value. 0 if it is normal.
* flag[7:1]: if flag[0] is set, this part follows the regular format specs; otherwise, exp[6:0].

### b. "G" Output Format

This is the output of the first FMA operation, which is denoted as "G" in Pineiro and Bruguera's paper. Since it needs at least 57 bit precision, the least significant 4 bits need a place. As before, the MSB in the raw, unencoded output weighs 2^0.

This format is a slightly modified version of the regular format, with most of the specification identical except for the following:

* flag[0]: indicate if the result is a special value / not a normalized value. 0 if it is normal.
* op[53]: if flag[0] is set, raw_output[56] (MSB); otherwise, follow the regular format.
* op[57:54]: if flag[0] is set, raw_output[3:0] (lower 4 bits); otherwise, follow the regular format.
* flag[7:4]: if flag[0] is cleared, raw_output[3:0]; otherwise, follow the regular format.
* flag[3]: if flag[0] is cleared, raw_output[56]; otherwise, follow the regular format.

All the "sign", "exponent", and "flags" in the regular format specs refer to the macro operation result, while the "mantissa"/"fraction" refers to the output of the "G" FMA unit.

### c. "V" Output Format

This is the output of the second FMA operation, which is referred as "V" in the original paper. This output is similar to the seed generator output for they both have a 30-bit carry save output; however, this component will almost always result in mass cancellation and need a field to hold the exponent. Though, the exponent is at most 8 bits as the CSA employed is only 160 bits wide. And, it doesn't need to carry any sign / exponent information of the final result.

* op[63]: output sign (it has a subtraction)
* op[62:53]: the exponent in biased form, sign extended
* op[52:30]: the lower 22 bits of the output sum.
* op[29:0]: the output carry.
* flag: the higher 8 bits of the output sum.
