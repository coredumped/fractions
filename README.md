# Fractions

A small swift based program that performs basic arithmetic operations between fractions.
Features:
 * The `Fraction` type conforms to the `ExpressibleByStringLiteral` which allows us to do funny things in code like: `"1/2" + "1/2"`
 * Fraction simplification
 * Defines the `Fraction.nan` constant `0/0`
 * Unit tests for almost everything, the idea was to cover as much as possible.

---
Write a command-line program in the language of your choice that will take operations on fractions as an input and produce a fractional result. 

 * Legal operators shall be *, /, +, - (multiply, divide, add, subtract).
 * Operands and operators shall be separated by one or more spaces.
 * Mixed numbers will be represented by whole_numerator/denominator. e.g. "3_1/4".
 * Improper fractions and whole numbers are also allowed as operands.
 * To exit the program just type **exit** at the command prompt.

Example run:
```
? 1/2 * 3_3/4
= 1_7/8 
?2_3/8 + 9/8
= 3_1/2
```