.data
 message: .string "upper word: "
 mesg1: .string "\nsecond byte: "
 mesg2: .string "\nlower byte: "
.text

.globl main
main:
    # uper half word
    li t0, 0xDEADBEEF     
    srli t2,t0,16     # t2 = DEAD
    la a1,message
    li a0,4 # print message
    ecall
    mv a1,t2 # 
    li a0,1 # print result
    ecall
    
     # lower byte
#     slli t2,t0,24 
#     srli t2,t2,24 # t2 = EF
    andi t2,t0,0xFF
    la a1,mesg2
    li a0,4
    ecall
    mv a1 , t2
    li a0,1
    ecall
     
     #second byte
#     slli t2,t0,16 
#     srli t2,t2,24 # t2 = BE
    srli t2,t0,8
    andi t2,t2,0xFF
    la a1,mesg1
    li a0,4
    ecall
    mv a1 , t2
    li a0,1
    ecall
    exit:
        addi a0, zero, 10
        ecall