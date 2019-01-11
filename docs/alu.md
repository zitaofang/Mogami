# Arithmetic in Mogami

*(This is just a sub; the detail of each component will be added after the unit is completed)*

## Notes on FP Exponent Computation

All floating point units in Mogami use the same library, mogami/arithmetic/fp/exp_operation.scala, to compute the exponent. It is worth spending some words explaining the implementation details of this library as it doesn't use 2's complement to encode the exponent, which might be confusing.

There are 3 types of exponent operation:
* Max: FP add operation.
* Add/Subtract: FP multiply/divide operation and close path of FP add operation. It is also used in the common stage of FP add to calculate the exponent difference.
* Divided by 2: FP square root operation.

During the exponent computation, the exponent will be represented by a 12-bit number. For a normal number, this format is equal to the 2's complement **minus 1**, and Bit 10, not Bit 11, is the sign bit. Bit 11 should be a sign extension of Bit 10. For a denorm, Bit 11 and 10 should be "10". Bit 9 to 0 should be the **inverted** (not negated) of the "exponent" (or more accurately, the shift offset needed to normalized a denorm from IEEE format) with sign extension.
