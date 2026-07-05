.data
array: .word 10,20,30,40,50

msg: .string "Reversed Array:\n"
space: .string " "

.text
.globl main

main:

    la s0,array          
    li s1,5              # array size
    li t0,0              # left = 0
    addi t1,s1,-1        # right = size-1
     
reverse:
    bge t0,t1,printArray     # while(left < right)
    # address of array[left]
    slli t2,t0,2             # left*4
    add t4,s0,t2             # &array[left]
    # address of array[right]
    slli t3,t1,2             # right*4
    add t5,s0,t3             # &array[right]
    # swap
    lw t6,0(t4)              # temp = array[left]
    lw a2,0(t5)              # value = array[right]
    sw a2,0(t4)              # array[left]=array[right]
    sw t6,0(t5)              # array[right]=temp

    addi t0,t0,1             # left++
    addi t1,t1,-1            # right--

    j reverse


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