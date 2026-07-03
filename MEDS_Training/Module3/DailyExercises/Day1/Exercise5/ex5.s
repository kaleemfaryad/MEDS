.text
.globl main

main:


    addi a0, zero, 5
    ecall
  
    mv t2,a0 # t2 = N
    addi t1,zero,0 # t1 => sum =0
    addi t0,zero,1 #t0 = 1 =>  i =1
    loop:
         bgt t0,t2,done
         add t1,t1,t0 # sum = sum + 1
         addi t0,t0,1 # i++
         j loop
    
    done:
        addi a0,zero,1 # print result 
        mv a1,t1
        ecall
    # Exit
        addi a0, zero, 10
        ecall