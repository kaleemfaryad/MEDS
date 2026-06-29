# RISC-V RV32I Instruction Decoder
## Design Document

---

# 1. Overview

This project implements a command-line RISC-V RV32I instruction decoder.

The decoder reads a text file containing hexadecimal machine instructions,
decodes each instruction according to the RISC-V ISA,
and prints the equivalent assembly instruction.

Example:

Input

00500113
00A00193
003100B3

Output

0x00000000 00500113 addi x2, x0, 5
0x00000004 00A00193 addi x3, x0, 10
0x00000008 003100B3 add x1, x2, x3

---

# 2. Project Architecture

The project follows a modular design.

```
                +------------------+
                |     main.c       |
                |------------------|
                | Parse arguments  |
                | Load hex file    |
                | Decode each inst |
                +---------+--------+
                          |
                          |
                          V
                +------------------+
                |    memory.c      |
                |------------------|
                | load_hex()       |
                | Read file        |
                | Allocate memory  |
                +---------+--------+
                          |
                          |
                          V
                +------------------+
                |    decoder.c     |
                |------------------|
                | Decode opcode    |
                | Decode fields    |
                | Print assembly   |
                +------------------+
```

---

# 3. File Responsibilities

## main.c

Responsible for:

- command-line parsing
- loading hex file
- looping through instructions
- printing decoded instructions

It does NOT decode instructions itself.

---

## decoder.c

Contains all decoding logic.

Responsibilities:

- extract instruction fields
- decode every instruction format
- convert machine code into assembly

Supported formats:

- R-Type
- I-Type
- Load
- Store
- Branch
- U-Type
- J-Type

---

## memory.c

Responsible only for reading a hex file.

Functions:

- open file
- allocate memory
- read instructions
- return instruction array

No decoding happens here.

---

# 4. Instruction Decoding Strategy

Every instruction begins with a 7-bit opcode.

```
31                        7   6      0
+-------------------------+----------+
|     Instruction Bits    | Opcode   |
+-------------------------+----------+
```

The decoder first extracts:

```
opcode = instruction & 0x7F
```

Then it chooses the decoding function.

```
switch(opcode)
{
    case OP_R_TYPE:
        ...
        break;

    case OP_I_TYPE:
        ...
        break;

    ...
}
```

---

# 5. Bit Extraction

Instead of hardcoding shifts everywhere,
the project uses a reusable macro.

```
EXTRACT_BITS(value, high, low)
```

Example

```
rd = EXTRACT_BITS(inst,11,7)
```

instead of

```
rd = (inst >> 7) & 0x1F;
```

This makes the code cleaner and easier to maintain.

---

# 6. Immediate Sign Extension

Immediate values may represent negative numbers.

Example

```
addi x1,x0,-4
```

The immediate stored inside the instruction is only 12 bits.

The project converts it into a signed 32-bit integer using

```
SIGN_EXTEND()
```

Example

```
111111111100

↓

-4
```

This ensures arithmetic instructions work correctly.

---

# 7. Instruction Formats

## R-Type

Used for register-register operations.

Fields

```
funct7
rs2
rs1
funct3
rd
opcode
```

Instructions

- add
- sub
- and
- or
- xor
- sll
- srl
- sra
- slt
- sltu

---

## I-Type

Fields

```
imm
rs1
funct3
rd
opcode
```

Instructions

Arithmetic

- addi
- andi
- ori
- xori
- slti
- sltiu
- slli
- srli
- srai

Load

- lb
- lh
- lw
- lbu
- lhu

Jump

- jalr

---

## S-Type

Fields

```
imm[11:5]
rs2
rs1
funct3
imm[4:0]
opcode
```

Instructions

- sb
- sh
- sw

---

## B-Type

Fields

```
imm
rs2
rs1
funct3
opcode
```

Instructions

- beq
- bne
- blt
- bge
- bltu
- bgeu

---

## U-Type

Fields

```
imm[31:12]
rd
opcode
```

Instructions

- lui
- auipc

---

## J-Type

Fields

```
imm
rd
opcode
```

Instruction

- jal

---

# 8. Error Handling

Unknown instructions never crash the program.

Instead the decoder prints

```
UNKNOWN
```

Example

```
DEADBEEF UNKNOWN
```

This allows invalid machine code to be handled safely.

---

# 9. Memory Management

The instruction array is dynamically allocated using

```
malloc()
```

After decoding completes

```
free()
```

is called.

Therefore

- no memory leaks
- Valgrind reports zero leaks

---

# 10. Coding Practices

The project follows good software engineering practices.

✓ Modular design

✓ Header files

✓ Include guards

✓ Named constants

✓ Function prototypes

✓ Macros

✓ Dynamic memory

✓ Separate compilation

✓ Meaningful comments

---

# 11. Build System

The project uses a Makefile.

Supported commands

```
make
```

Compile project

```
make debug
```

Compile with DEBUG enabled

```
make clean
```

Remove binaries

```
make test
```

Run sample test

```
make valgrind
```

Check memory leaks

---

# 12. Future Improvements

Possible future extensions include

- Full RV32I simulator
- Register file simulation
- Memory subsystem
- Pipeline visualization
- ELF executable loading
- Disassembler output
- Interactive debugger
- CSR instruction support
- RV64I support

---

# 13. Conclusion

This project demonstrates how a real instruction decoder is built.

It uses modular C programming, bit manipulation, enums, structs, macros, and dynamic memory to decode RV32I instructions into readable assembly.

The decoder serves as the front-end of a future RISC-V CPU simulator.