# Digital Design and Computer Architecture

## L4: Sequential Logic-II

### FSM State Encoding

1. Fully Encoded /Full Encoding: use minimum no. of possible bits, use log2(num_states) bits to represent the states
2. Hot-bit Encoded: In which each bit encodes a different state
3. Output Encoded: outputs are directly accessible at state end

### Moore vs Mealy

Moore: output depends only on the current state , outputs is generated on states
Mealy:output depend on the current state and current input,output is generated on the transitions
Moore is more stable than mealy(more expensive)

### FPGA (Field Programmable gate array)

it is a software-reconfigurable hardware substrate
Two main building blocks: LookUp table and switches
benefits:

1. An algorithm directly implemented on hardware
2. low development cost
3. Short time to market: reconfigurable in the field
4. Good for prototyping and application acceleration
   Disadvantages:
   not as fast and power efficient as dedicated hardware customized for an algorithm

### FPGA Design Flow

problem definition => HDL => Logic synthesis => Placement and routing => Bitstream generation

### Vivado

it is a software tool that helps us throughout the FPGA design flow

### HDL

verilogs, system verilog nad VHDL

### design methodology

top-down design
bottom up design

### verilog

module is main building block in verilog
define module:
Name of module,directions of tis ports
names and its ports

### module

module example (a,b,c,y);
input [31:0] a; // a[31] ... a[0]
input b;
input c;
output y;
endmodule
another way
module example(input a, input b, output y);
endmodule
