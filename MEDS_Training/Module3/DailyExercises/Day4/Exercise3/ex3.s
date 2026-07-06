.text
.globl main

main:
    li a0,5              # argument = 5
    call compute         # call compute()
    mv a1,a0             # print result
    li a0,1
    ecall

    li a0,10
    ecall

compute:
    addi sp,sp,-16
    sw ra,12(sp)
    sw s0,8(sp)
    mv s0,a0             # save n

    # Nested Call
    mv a0,s0
    call square          # returns n*n
    addi a0,a0,10        # answer +=10

    lw s0,8(sp)
    lw ra,12(sp)
    addi sp,sp,16
    ret

square:
    mul a0,a0,a0
    ret