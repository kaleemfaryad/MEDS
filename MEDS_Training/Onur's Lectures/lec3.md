# Digital Design and Computer Architecture

## L3: Sequential Logic

### Logical(functional) completeness

Any logic function can be made with the help of PLAs
PLA consist AND, OR and NOT gates
NAND and NOR are universal gate
NAND is logically complete but NOR is not

### Equality Checker/comparator

it contains XNOR gates with AND gate

### ALU

it is the combination of Arithmetic(+,-,x,/) and Logic(gates:AND,OR,NOT) Unit

### Tri-State buffer

it is a buffer with an ENABLE , When EN is 0 then output will Floating (undefined may be) otherwise output will same as input
like CPU and memory use tristate buffer for communication to overcome collision

### Logic Simplification Goals

reduce the number of gates/inputs
reduce the cost,latency,power
the uniting thorem : remove the therms/input that dont affect the output
k-map also used for the simplification of the circuits

### Sequential circuits

that use the memory ,output depends on the input + previous state
latches,flipflop,SRAM,DRAM,flash memory etc.

### R-S latch

R => reset, S=> set
issue when both S and R both 0 it will shown Q=Q'
and when S and R both 1 , metastability issue output not confirmed 1 or 0

### D Latch

it will overcome the problem of RS-latch by using the Write Enable
by using WE and D the S and R never be same at the sametime
but it increases the cost by using addtional 2 NAND gates
A NAND gate contains 4 transistors

### Memory

addressability: the number bits stored in each location

### Asynchronous vs Synchronous

Asynchronous not uses clock
Synchronous uses clock for synchronization

### Finite State of Machine

discrete-time model, it shows the all states and transitions between them
three parts:

1. next state logic
2. state register(clock)
3. output logic
   D-latche use enable so when its true the output will changed as the input changes , level-triggered
   D-flipflop use clock so when its true the output will changed after the particular clock cycle completion as the input changes , edge-triggered
