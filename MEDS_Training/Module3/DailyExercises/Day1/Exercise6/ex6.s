.data
    even_message:.string "Even"
    odd_message:.string "Odd"
.text
main:


    addi a0, zero, 5
    ecall
  
    mv t2,a0 # t2 = Number
    andi t1,t2,1 # number & 1 check last bit
    beq t1,zero, even  # t1 == 0 -> even
    odd:
        la a1, even_message
        addi a0,zero,4
        ecall
        j exit
    even:
       la a1, odd_message
       addi a0,zero,4
       ecall
    exit:
        addi a0, zero, 10
        ecall