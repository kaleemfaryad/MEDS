.data
number:.word 0xDEADBEEF
msg: .string "word: "
msg1: .string "\nhalf word(offest 0): "
msg2: .string "\nhalf word(offest 2): "
msg3: .string "\nByte: "
.text
.globl main
main:
    la t0,number     #t0 = address of the array
    lw t2,0(t0)     # t2 = DEADBEEF
    li a0,4
    la a1,msg
    ecall
    li a0,1
    mv a1,t2
    ecall
    
    # lhu t3,0(t0)     # t3 = 0000BEEF
    lh t3,0(t0)     # t3 = FFFFBEEF
    li a0,4
    la a1,msg1
    ecall
    li a0,1
    mv a1,t3
    ecall
    
    
    # lhu t4, 2(t0)    # t4 = 0000DEAD
    lh t4, 2(t0)    # t4 = FFFFDEAD
    li a0,4
    la a1,msg2
    ecall
    li a0,1
    mv a1,t4
    ecall
    
    #lbu t5, 0(t0)   # t5 = 000000EF
    lb t5, 0(t0)   # t5 = FFFFFFEF
    li a0,4
    la a1,msg3
    ecall
    li a0,1
    mv a1,t5
    ecall
    
    li a0,10
    ecall
    