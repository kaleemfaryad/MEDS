.equ Number,5
.data

.text
.globl main
main:
    li t0,Number
    li t1,1 # result=1
    li t2,2 # i =2
    loop:
    bgt t2,t0,done #i>N
#     sll t3,t2,t2
    mul t1,t1,t2
    addi t2,t2,1 # i++
    j loop
done:
  li a0,1
  mv a1,t1
  ecall
EXIT:
    li a0,10
    ecall
    