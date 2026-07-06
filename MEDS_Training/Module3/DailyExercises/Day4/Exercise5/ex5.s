.text
.globl main

main:
    add x4,x5,x10
    addi x2,x0,5
loop:
    bne x1,x2,loop
    li a0,10
    ecall