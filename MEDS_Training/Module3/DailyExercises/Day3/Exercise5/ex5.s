.data
value: .word 10

.text
.globl main

main:
    li t0,100
    la t1,value
    mv t2,t0
    nop
    not t3,t0
    neg t4,t0
    beqz t0,END
    bnez t0,LABEL

LABEL:
    ret

END:
    li a0,10
    ecall