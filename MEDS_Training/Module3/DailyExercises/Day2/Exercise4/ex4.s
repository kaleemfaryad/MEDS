.data
array:
    .word 15,-10, 20, -30, 40, 50 ,-100 , -8,-70, 1

msg:
    .string "Maximum = "

.text
.globl main
main:
    la t0,array     #t0 = address of the array
    li t1,10        # size 
    lw t2,0(t0)     # max = 15 
    li t3,1         # i =1
    
    loop:
    bge t3,t1,done # i>= size
    slli t4,t3,2  # offset = i*4
    add t6,t0,t4 #  address of array[i]
    lw t5, 0(t6) # current value
    ble t5,t2,skip # current <= max
    mv t2,t5
    
    skip:
    addi t3,t3,1 # i++
    j loop
    
    done:
    li a0,4
    la a1,msg
    ecall
    li a0,1
    mv a1,t2
    ecall
    