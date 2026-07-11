.equ SIZE,3
.data
Move:    .string "Move disk  "
From:    .string " from  "
To:      .string " to  "
NewLine: .string "\n"

.text
.globl main
main: 
    li a0,SIZE      # n
    li a1,'A'       # source
    li a2,'C'       # destination
    li a3,'B'       # auxiliary
    call towerHanoi

    #exit
    li a0,10
    ecall

towerHanoi:
    addi sp,sp,-32      # stack frame
    sw ra,28(sp)
    sw s0,24(sp)
    sw s1,20(sp)
    sw s2,16(sp)
    sw s3,12(sp)

    mv s0,a0            # n
    mv s1,a1            # src
    mv s2,a2            # dest
    mv s3,a3            # auxiliary

    li t0,1
    #base case n==1
    bgt s0,t0,base_next

    li a0,4
    la a1,Move
    ecall

    mv a1,s0
    li a0,1
    ecall

    li a0,4
    la a1,From
    ecall

    mv a1,s1
    li a0,11
    ecall

    li a0,4
    la a1,To
    ecall

    mv a1,s2
    li a0,11
    ecall

    la a1,NewLine
    li a0,4
    ecall
    j return_hanoi

    #recursive case
    base_next:
    #step1: tower(n-1,src,aux,dest), move n-1 from src to aux
    addi a0,s0,-1       # n-1
    mv a1,s1            # src
    mv a2,s3            # dest 
    mv a3,s2            # aux  
    call towerHanoi

    #step2: move n from src to dest
    li a0,4
    la a1,Move
    ecall

    mv a1,s0
    li a0,1
    ecall

    li a0,4
    la a1,From
    ecall

    mv a1,s1
    li a0,11
    ecall

    li a0,4
    la a1,To
    ecall

    mv a1,s2
    li a0,11
    ecall

    la a1,NewLine
    li a0,4
    ecall

    #step3: move n-1 from aux to dest
    addi a0,s0,-1
    mv a1,s3            # aux
    mv a2,s2            # dest
    mv a3,s1            # src
    call towerHanoi

 return_hanoi:
    lw s3,12(sp)
    lw s2,16(sp)
    lw s1,20(sp)
    lw s0,24(sp)
    lw ra,28(sp)
    addi sp,sp,32
    ret