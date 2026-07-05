.data

array: .word 10,20,30,40,50,60,70

msg: .string "Index = "

.text
.globl main

main:
    la s0,array
    li s1,7
    li s2,5          # target
    li t0,0           # left
    addi t1,s1,-1     # right = size-1

loop:
    bgt t0,t1,notFound
    add t2,t0,t1      # left+right
    srli t2,t2,1      # mid=(left+right)/2
    slli t3,t2,2      # offset
    add t4,s0,t3      # address
    lw t5,0(t4)       # array[mid]
    beq t5,s2,found # array[mid] == target value
    blt s2,t5,leftHalf
    
# Search Right Half
    addi t0,t2,1 # left = mid+1
    j loop

# Search Left Half
leftHalf:
    addi t1,t2,-1 # right = mid-1
    j loop

found:
    li a0,4
    la a1,msg
    ecall

    li a0,1
    mv a1,t2
    ecall

    j exit

notFound:
    li a0,4
    la a1,msg
    ecall

    li a0,1
    li a1,-1
    ecall
    
exit:

    li a0,10
    ecall