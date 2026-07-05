.data

array: .word 50,20,10,40,30

msg: .string "Sorted Array:\n"
space: .string " "

.text
.globl main

main:
    la s0,array
    li s1,5          # size
    li t0,0          # i

outerLoop:
    addi t6,s1,-1
    bge t0,t6,printArray
    li t1,0          # j=0

innerLoop:
    sub t6,s1,t0
    addi t6,t6,-1
    bge t1,t6,nextPass

# address of array[j]
    slli t2,t1,2
    add t3,s0,t2

# load array[j]
    lw t4,0(t3)

# load array[j+1]
    lw t5,4(t3)

# compare
    ble t4,t5,noSwap

# swap
    sw t5,0(t3)
    sw t4,4(t3)

noSwap:
    addi t1,t1,1
    j innerLoop

nextPass:
    addi t0,t0,1
    j outerLoop

# PRINT ARRAY
printArray:
    li a0,4
    la a1,msg
    ecall

    li t0,0
    
printLoop:
    bge t0,s1,exit
    slli t2,t0,2
    add t3,s0,t2
    lw t4,0(t3)
    li a0,1
    mv a1,t4
    ecall
    li a0,4
    la a1,space
    ecall
    addi t0,t0,1
    j printLoop

exit:
    li a0,10
    ecall