.text
.globl main
main:
    li t0, 12     # b =12
    li t1, 64     # c = 64
    slli t2,t0,3  # t0<<3 = b*8
    srli t3,t1,2  # t1 >> 2 = c/4 
    sub t4, t2,t3 # (b * 8) - (c / 4)
    mv a1,t4 # a1 = 80
    li a0,1 # print result
    ecall
    exit:
        addi a0, zero, 10
        ecall