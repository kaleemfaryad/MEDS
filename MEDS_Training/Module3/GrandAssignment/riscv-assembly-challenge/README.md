# RISC-V Assembly Programming Challenge

**Course:** MEDS Lab – Module 3: RISC-V ISA  
**Student:** Muhammad Kaleem Faryad  

---

# Overview

This repository contains the solutions for the **MEDS Module 3 Grand Assignment**. The assignment focuses on implementing algorithms in **RISC-V Assembly Language** while following the standard RISC-V calling convention.

The repository includes three assembly programming tasks, instruction encoding exercises, and self-study summaries based on the RISC-V specifications.

---

# Repository Structure

```text
riscv-assembly-challenge/
│
├── README.md
├── .gitignore
│
├── part1_array_ops.s
├── part2_recursion.s
├── part3_encoding.s
│
├── screenshots/
│   ├── part1_output.png
│   ├── part2_output.png
│   └── part3_output.png
│
└── docs/
    ├── ENCODING_WORKSHEET.md
    ├── PRIVILEGED_SUMMARY.md
    └── EXTENSION_SUMMARY.md
```

---

# Development Environment

- ISA: RISC-V RV32I
- Simulator: Venus RISC-V Simulator
- Language: RISC-V Assembly
- Operating System: Ubuntu (WSL)

---

# How to Run

1. Open the Venus RISC-V Simulator.
2. Load the required `.s` file.
3. Assemble the program.
4. Run the program.
5. Verify the output in the Venus console.

Each assembly file is independent and can be executed separately.

---

# Part 1 – Array Processing

File:

```text
part1_array_ops.s
```

## Objective

Implement four reusable functions that operate on an integer array.

The program contains an array of signed integers (including negative values) and computes:

- Sum of all elements
- Minimum value
- Maximum value
- Count of negative numbers

Each function follows the RISC-V calling convention.

## Implemented Functions

### sum_array

**Arguments**

- a0 = Array address
- a1 = Array size

**Returns**

- a0 = Sum of all elements

---

### find_min

**Arguments**

- a0 = Array address
- a1 = Array size

**Returns**

- a0 = Minimum element

---

### find_max

**Arguments**

- a0 = Array address
- a1 = Array size

**Returns**

- a0 = Maximum element

---

### count_negative

**Arguments**

- a0 = Array address
- a1 = Array size

**Returns**

- a0 = Number of negative elements

---

## Sample Output

```text
Sum: 24
Min: -12
Max: 11
Negative Count: 4
```

---

# Part 2 – Recursive Fibonacci with Memoization

File:

```text
part2_recursion.s
```

## Objective

Implement Recursive Fibonacci using memoization.

Instead of recomputing previous Fibonacci values repeatedly, previously computed answers are stored inside a cache array located in the `.data` section.

## Features

- Genuine recursion
- Memoization using cache
- Stack frame management
- Proper calling convention
- Recursive function calls
- Cache lookup before recursion

## Cache Layout

```text
cache[0] ... cache[20]
```

Initial value:

```text
-1
```

Meaning:

```text
Not computed yet
```

Whenever a Fibonacci value is calculated, it is stored inside the cache.

## Sample Output

```text
6765
```

which is

```text
fib(20)
```

---

# Part 3 – Instruction Encoding

File:

```text
part3_encoding.s
```

## Objective

Load six machine instructions as hexadecimal values and decode them using bit manipulation.

Each instruction is stored using `.word`.

The decoder extracts:

- Opcode
- rd
- rs1
- funct3

using only:

- Shift Right Logical Immediate (`srli`)
- AND Immediate (`andi`)

## Instructions Included

| Format | Instruction |
|---------|-------------|
| R | add x5,x6,x7 |
| I | addi x5,x6,10 |
| S | sw x5,8(x6) |
| B | beq x5,x6,16 |
| U | lui x5,0x12345 |
| J | jal x1,32 |

---

## Sample Output

```text
Opcode: 51   rd: 5   funct3: 0   rs1: 6
Opcode: 19   rd: 5   funct3: 0   rs1: 6
Opcode: 35   rd: 8   funct3: 2   rs1: 6
Opcode: 99   rd:16   funct3: 0   rs1: 5
Opcode: 55   rd: 5   funct3: 5   rs1: 8
Opcode:111   rd: 1   funct3: 0   rs1: 0
```

---

# Documentation

## ENCODING_WORKSHEET.md

Contains manual encoding of one instruction from each RISC-V instruction format:

- R-Type
- I-Type
- S-Type
- B-Type
- U-Type
- J-Type

Each instruction includes:

- Binary encoding
- Field breakdown
- Final hexadecimal machine code

---

## PRIVILEGED_SUMMARY.md

Summary of the RISC-V Privileged Architecture covering:

- Privilege Levels
- Control and Status Registers (CSRs)
- Trap Handling Flow

Based on:

Sections 3.1–3.4 of the RISC-V Privileged Specification.

---

## EXTENSION_SUMMARY.md

Summary of one RISC-V ISA extension covering:

- Purpose
- Important Instructions
- Practical Applications

---

# RISC-V Concepts Demonstrated

- RV32I Instruction Set
- Procedure Calls
- Stack Management
- Calling Convention
- Recursive Functions
- Memoization
- Arrays
- Pointer Arithmetic
- Bit Manipulation
- Instruction Encoding
- Instruction Decoding
- Shift and Mask Operations

---

# Learning Outcomes

After completing this project, the following concepts were practiced:

- Writing modular assembly programs
- Implementing reusable functions
- Following the RISC-V ABI
- Managing recursive function calls
- Using the stack correctly
- Understanding instruction formats
- Manual instruction encoding
- Decoding machine instructions
- Using shift and mask operations for field extraction

---

# References

- RISC-V Unprivileged ISA Specification
- RISC-V Privileged ISA Specification
- Venus RISC-V Simulator
- MEDS Module 3 Lab Manual

---

# Author

**Muhammad Kaleem Faryad**

