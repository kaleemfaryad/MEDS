.equ Number,-9
.data
msg: .string "Number is Positive "
msg1: .string "Number is Negative "
msg2: .string "Number is 0 "
.text
.globl main
main:
    li t0,Number
#     li a0,5 # reading number from terminal
#     ecall
#     li t0,a0 
    beqz t0,ZERO   # number = 0
    blt t0,zero,Negative # number is negative
    bgt t0,zero,Positive # number is positive
   
    
ZERO:
    li a0,4
    la a1,msg2
    ecall
    j EXIT
Negative:
    li a0,4
    la a1,msg1
    ecall
    j EXIT
Positive:
    li a0,4
    la a1,msg
    ecall
    j EXIT
EXIT:
    li a0,10
    ecall
    