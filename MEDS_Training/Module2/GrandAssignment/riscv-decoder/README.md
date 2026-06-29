# RISC-V RV32I Instruction Decoder

## Grand Assignment — MEDS Module 2

### Author

**Muhammad Kaleem Faryad**

---

# Project Overview

The **RISC-V RV32I Instruction Decoder** is a command-line application written in **C** that reads a hexadecimal file containing RV32I machine instructions and converts each instruction into its human-readable assembly representation.

This project simulates the **instruction decode stage** of a RISC-V processor pipeline and serves as the front-end of a CPU simulator.

The decoder supports multiple RISC-V instruction formats including:

* R-Type
* I-Type
* Load Instructions
* Store Instructions
* Branch Instructions
* U-Type
* Jump Instructions

Unknown instructions are detected safely and displayed as **UNKNOWN** instead of causing program failure.

---

# Project Objectives

The objectives of this project are to:

* Understand the RV32I instruction format.
* Practice C programming for systems programming.
* Learn bit manipulation using masks and shifts.
* Organize large C projects using multiple source files.
* Use header files and include guards.
* Build projects using Makefiles.
* Practice Git workflow.

---

# Features

* Decode RV32I machine instructions
* Read instructions from a hex file
* Decode all major RV32I instruction formats
* Proper sign extension of immediates
* Detect invalid instructions safely
* Modular project structure
* Memory allocated dynamically
* No memory leaks
* Build using Makefile
* Supports Debug and Release builds

---

# Supported Instructions

## R-Type

* ADD
* SUB
* AND
* OR
* XOR
* SLL
* SRL
* SRA
* SLT
* SLTU

---

## I-Type Arithmetic

* ADDI
* ANDI
* ORI
* XORI
* SLTI
* SLTIU
* SLLI
* SRLI
* SRAI

---

## Load Instructions

* LB
* LH
* LW
* LBU
* LHU

---

## Store Instructions

* SB
* SH
* SW

---

## Branch Instructions

* BEQ
* BNE
* BLT
* BGE
* BLTU
* BGEU

---

## U-Type

* LUI
* AUIPC

---

## Jump Instructions

* JAL
* JALR

---

# Project Structure

```
riscv-decoder/
│
├── Makefile
├── .gitignore
├── README.md
│
├── include/
│   ├── common.h
│   ├── decoder.h
│   └── memory.h
│
├── src/
│   ├── main.c
│   ├── decoder.c
│   └── memory.c
│
├── build/
│
├── bin/
│
├── docs/
│   └── DESIGN.md
│
└── test/
    ├── test_decoder.c
    └── programs/
        ├── r_type.hex
        ├── i_type.hex
        ├── branch.hex
        └── mixed.hex
```

---

# Building the Project

Compile the project using:

```bash
make
```

---

# Debug Build

```bash
make debug
```

---

# Release Build

```bash
make release
```

---

# Running the Decoder

Run the decoder using:

```bash
./bin/riscv-decoder test/programs/mixed.hex
```

---

# Sample Output

```
RISC-V RV32I Instruction Decoder
========================================

Loaded 8 instructions from test/programs/mixed.hex

Address      Hex          Assembly
--------------------------------------------------------

0x00000000   00500113     addi x2, x0, 5
0x00000004   00A00193     addi x3, x0, 10
0x00000008   003100B3     add x1, x2, x3
0x0000000C   40310133     sub x2, x2, x3
0x00000010   0020A023     sw x2, 0(x1)
0x00000014   0000A103     lw x2, 0(x1)
0x00000018   FE209CE3     bne x1, x2, -8
0x0000001C   004000EF     jal x1, 4
```

---

# Running Tests

Run the default test program:

```bash
make test
```

---

# Memory Leak Check

Check for memory leaks using Valgrind:

```bash
make valgrind
```

Expected result:

```
All heap blocks were freed -- no leaks are possible.
```

---

# Cleaning the Project

Remove all compiled files:

```bash
make clean
```

---

# Important Design Concepts Used

The project demonstrates the following C programming concepts:

* Structs
* Enums
* Function Prototypes
* Include Guards
* Dynamic Memory Allocation
* Bit Manipulation
* Bit Masks
* Shift Operations
* Macros
* Modular Programming
* Multi-file Projects
* Makefiles
* Git Workflow

---

# Future Improvements

Possible future extensions include:

* Register ABI names (zero, ra, sp, etc.)
* Full RV32IM support
* CSR instruction decoding
* Floating-point instruction support
* ELF executable loading
* Interactive debugger
* Complete CPU simulator
* Five-stage pipeline simulation

---

# Assignment Requirements Checklist

## Decoder Logic

* R-Type Instructions
* I-Type Arithmetic
* Load Instructions
* Store Instructions
* Branch Instructions
* U-Type Instructions
* Jump Instructions
* Sign Extension
* Unknown Instruction Handling

---

## Project Structure

* Multiple Source Files
* Header Files
* Include Guards
* Makefile
* Macros
* Modular Design

---

## Git Workflow

* Multiple Commits
* Feature Branches
* Merge into Main
* Proper .gitignore

---

## Documentation

* README
* DESIGN.md
* Test Programs
* Inline Comments

---

# License

This project was developed for educational purposes as part of the **MEDS Module 2 Grand Assignment**.

---

# Acknowledgements

* MEDS Training Program
* RISC-V International ISA Specification
* GNU GCC Compiler
