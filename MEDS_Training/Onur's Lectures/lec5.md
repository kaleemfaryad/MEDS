# Digital Design and Computer Architecture

## L5: HDL, Verilog II, Timing & Verification

### Manipulating bits

1. Bit Slicing
   e.g., wire [15:0] longbus;
2. Concatenation
   e.g., assign y = {a[2],a[1],a[0]}
3. Duplication
   assign x = {a[0],a[0],a[0],a[0]}
   assign y = {4{a[0]}}

### Basic syntax of Verilog

case sensitive: kaleem and KaleeM are not the same
names cannot start with numbers
whitespaces are not allowed
// for single line comment
/\* \*/ for multi-line comment

### Two main styles of HDL

1. Structural(Gate-level)
   low level abstraction
   Similar to circuit diagrams
   Full control over:
   gates
   interconnections
2. Behavioral
   high level abstraction
   Easier to write and understand
   Similar to software logic
   Automatically converted into hardware
   many practical design use combination of both

### Operator precedence

highest to lower
NOT -> mul,div,mod ->add,sub -> shift -> arithematic shift -> comparison -> equal/not equal -> AND,NAND -> XOR,XNOR -> OR,NOR -> ternary operator

### Numbers in verilog

N'Bxx
N-> number of bits
B-> base b,o,h
xx-> number / values
example: 4'b1001 -> 1001

### truth table for AND with Z and X

--| 0 | 1 | Z | X
0 | 0 | 0 | 0 | 0
1 | 0 | 1 | Z | X
Z | 0 | X | X | X
X | 0 | X | X | X

### Timing in Verilog

it is possible to define relationship in verilog but:
these are only for simulation , cannot be synthesized, used for modeling delays in a circuit

### Sequential statements

these are with in <b>always</b> block , triggered with change in the sensitivity list, signals assigned in always must be decleared as reg
use <= for non-blocking assignments and do not use assign with in the always block

### combinational statements

if , else can only be used in always blocks,

### blocking vs non-blocking statements

non-blocking allow operating on old values, easy sequential logic description
blocking statements allows a sequence of operations
