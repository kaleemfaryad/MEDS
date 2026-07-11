.data
instructions:
    .word 0x007302B3     # add x5,x6,x7
    .word 0x00A30293     # addi x5,x6,10
    .word 0x00532423     # sw x5,8(x6)
    .word 0x00628863     # beq x5,x6,16
    .word 0x123452B7     # lui x5,0x12345
    .word 0x020000EF     # jal x1,32

opcode:   .string "\nOpcode: "
rd:       .string "   rd: "
funct3:   .string "    funct3: "
rs1:      .string "  rs1: "
mnemonic: .string "\nMnemonic: "

str_add:     .string "add"
str_addi:    .string "addi"
str_sw:      .string "sw"
str_beq:     .string "beq"
str_lui:     .string "lui"
str_jal:     .string "jal"
str_unknown: .string "unknown"
newline:     .string "\n"

.text
.globl main
main:
    la s0, instructions
    li s1, 6            # i = 6

loop:
    beqz s1, exit
    lw t0, 0(s0)

    # --- decode fields ---
    andi t1, t0, 0x7F        # opcode [6:0]

    srli t2, t0, 7
    andi t2, t2, 0x1F         # rd [11:7]

    srli t3, t0, 12
    andi t3, t3, 0x07         # funct3 [14:12]

    srli t4, t0, 15
    andi t4, t4, 0x1F         # rs1 [19:15]

    srli t6, t0, 25
    andi t6, t6, 0x7F         # funct7 [31:25]

    # --- print opcode ---
    la a1, opcode
    li a0, 4
    ecall
    mv a1, t1
    li a0, 1
    ecall

    # --- print rd ---
    la a1, rd
    li a0, 4
    ecall
    mv a1, t2
    li a0, 1
    ecall

    # --- print funct3 ---
    la a1, funct3
    li a0, 4
    ecall
    mv a1, t3
    li a0, 1
    ecall

    # --- print rs1 ---
    la a1, rs1
    li a0, 4
    ecall
    mv a1, t4
    li a0, 1
    ecall

    # --- print mnemonic label ---
    la a1, mnemonic
    li a0, 4
    ecall

    # --- decode mnemonic based on opcode ---
    li t5, 0x33
    beq t1, t5, is_rtype
    li t5, 0x13
    beq t1, t5, is_addi
    li t5, 0x23
    beq t1, t5, is_sw
    li t5, 0x63
    beq t1, t5, is_beq
    li t5, 0x37
    beq t1, t5, is_lui
    li t5, 0x6F
    beq t1, t5, is_jal
    j is_unknown

is_rtype:
    # only handling add: funct3=0x0, funct7=0x00
    bnez t3, is_unknown
    bnez t6, is_unknown
    la s2, str_add
    j print_mnemonic

is_addi:
    la s2, str_addi
    j print_mnemonic

is_sw:
    la s2, str_sw
    j print_mnemonic

is_beq:
    la s2, str_beq
    j print_mnemonic

is_lui:
    la s2, str_lui
    j print_mnemonic

is_jal:
    la s2, str_jal
    j print_mnemonic

is_unknown:
    la s2, str_unknown
    j print_mnemonic

print_mnemonic:
    mv a1, s2
    li a0, 4
    ecall

    la a1, newline
    li a0, 4
    ecall

    addi s0, s0, 4       # next instruction
    addi s1, s1, -1      # i--
    j loop

exit:
    li a0, 10
    ecall