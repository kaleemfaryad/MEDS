# RISC-V Assembly Programming Challenge

**Course:** MEDS Lab – Module 3: RISC-V ISA  
**Student:** Muhammad Kaleem Faryad  

---

# Overview

This repository contains my solutions for the **MEDS Module 3 Grand Assignment**, implemented entirely in **RISC-V RV32I Assembly Language**.

The project demonstrates the implementation of array processing algorithms, recursive algorithms, instruction encoding/decoding, and a mini RISC-V disassembler while following the standard **RISC-V Calling Convention (ABI)**.

All programs were assembled and tested using the **Venus RISC-V Simulator**.

---

# Repository Structure

```text
riscv-assembly-challenge/
│
├── README.md
├── ENCODING_WORKSHEET.md
│
├── part1_array_ops.s
├── part1_array_ops_SelectionSort.s
├── part2_recursion_fibonacci.s
├── part2_recursion_TowerHanoi.s
├── part3_encoding.s
├── part3_encoding_bonus.s
│
├── docs
│   ├── ENCODING_WORKSHEET.md.txt
│   ├── EXTENSION_SUMMARY.md.txt
│   └── PRIVILEGED_SUMMARY.md.txt
│
└── screenshots
    ├── part1_array_ops.png
    ├── part1_array_ops_SelectionSort.png
    ├── part2_recursion.png
    ├── part2_recursion_TowerHanoi.png
    ├── part2_recursion_fibonacci.png
    └── part3_encoding_bonus.png
```

---

# Development Environment

- ISA: **RISC-V RV32I**
- Language: **RISC-V Assembly**
- Simulator: **Venus RISC-V Simulator**
- Operating System: **Ubuntu (WSL)**

---

# How to Run

1. Open the Venus RISC-V Simulator.
2. Load any `.s` assembly source file.
3. Assemble the program.
4. Run the program.
5. Observe the output in the Venus console.

Each assembly file is independent and can be executed separately.

---

# Part 1 – Array Processing

## File

```text
part1_array_ops.s
```

### Objective

Implement reusable assembly functions that operate on an integer array while following the RISC-V calling convention.

### Implemented Functions

- `sum_array()`
- `find_min()`
- `find_max()`
- `count_negative()`

### Sample Output

```text
Sum: 24
Min: -12
Max: 11
Negative Count: 4
```

---

# Part 1 (Bonus) – Selection Sort

## File

```text
part1_array_ops_SelectionSort.s
```

### Objective

Implement the **Selection Sort** algorithm entirely in RISC-V Assembly.

### Features

- In-place sorting
- Nested loops
- Element swapping
- Pointer arithmetic
- Array traversal

### Sample Output

```text
Sorted Array:
-12 -8 -5 -2 1 3 4 6 7 9 10 11
```

---

# Part 2 – Recursive Fibonacci

## File

```text
part2_recursion_fibonacci.s
```

### Objective

Implement the recursive Fibonacci algorithm using proper stack frames and the RISC-V calling convention.

### Features

- Recursive function calls
- Stack frame management
- Register preservation
- Base cases
- Recursive computation

### Sample Output

```text
fib(10) = 55
```

---

# Part 2 – Tower of Hanoi

## File

```text
part2_recursion_TowerHanoi.s
```

### Objective

Implement the recursive Tower of Hanoi algorithm.

### Features

- Recursive function calls
- Stack frame management
- Parameter passing
- Character output
- Proper register preservation

### Sample Output

```text
Move disk 1 from A to C
Move disk 2 from A to B
Move disk 1 from C to B
Move disk 3 from A to C
Move disk 1 from B to A
Move disk 2 from B to C
Move disk 1 from A to C
```

---

# Part 3 – Instruction Encoding

## File

```text
part3_encoding.s
```

### Objective

Decode RISC-V machine instructions using shift-and-mask operations.

### Extracted Fields

- Opcode
- rd
- rs1
- funct3

### Supported Instruction Formats

- R-Type
- I-Type
- S-Type
- B-Type
- U-Type
- J-Type

---

# Part 3 (Bonus) – Mini RISC-V Disassembler

## File

```text
part3_encoding_bonus.s
```

### Objective

Extend the instruction decoder to identify the actual instruction mnemonic.

### Supported Instructions

- ADD
- ADDI
- SW
- BEQ
- LUI
- JAL

Instead of only extracting instruction fields, the program prints the decoded instruction mnemonic.

---

# Documentation

The `docs/` directory contains the required self-study deliverables.

## ENCODING_WORKSHEET.md.txt

Manual instruction encoding for:

- R-Type
- I-Type
- S-Type
- B-Type
- U-Type
- J-Type

Including:

- Binary representation
- Field breakdown
- Final hexadecimal encoding

---

## PRIVILEGED_SUMMARY.md.txt

Summary of the RISC-V Privileged Architecture including:

- Privilege Levels
- Machine Mode
- Supervisor Mode
- User Mode
- Control and Status Registers (CSRs)
- Trap Handling Flow

Based on Sections **3.1–3.4** of the RISC-V Privileged ISA Specification.

---

## EXTENSION_SUMMARY.md.txt

Summary of the **RISC-V Atomic (A) Extension** including:

- LR (Load Reserved)
- SC (Store Conditional)
- AMO Instructions
- Zalrsc Extension
- Zaamo Extension
- Practical applications in multicore synchronization

---

# RISC-V Concepts Demonstrated

- RV32I Instruction Set
- Arrays
- Pointer Arithmetic
- Branch Instructions
- Loops
- Functions
- Calling Convention
- Stack Frames
- Recursion
- Selection Sort
- Tower of Hanoi
- Recursive Fibonacci
- Instruction Encoding
- Instruction Decoding
- Shift-and-Mask Bit Manipulation
- Mini Disassembler

---

# Screenshots

Execution screenshots for every assignment component are included in the `screenshots/` directory.

---

# Learning Outcomes

After completing this assignment, I gained practical experience with:

- Writing modular assembly programs
- Following the RISC-V ABI
- Stack management
- Recursive programming
- Sorting algorithms
- Bit manipulation
- Instruction encoding and decoding
- Machine instruction analysis
- Mini disassembler implementation

---

# References

- RISC-V Unprivileged ISA Specification (Volume I)
- RISC-V Privileged ISA Specification (Volume II)
- Venus RISC-V Simulator
- MEDS Module 3 Lab Manual

---

# Author

**Muhammad Kaleem Faryad**  

