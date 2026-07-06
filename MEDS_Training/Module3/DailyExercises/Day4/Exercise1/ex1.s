.data
array: .word 10,20,30,40,50
msg1: .string "Maximum = "
msg2: .string "\nArray Sum = "

.text
.globl main

main:
    li a0,25          # First number
    li a1,40          # Second number
    call max          # a0 = max(a0,a1)
    
    mv t0,a0          # Save result because next function
                      # will overwrite a0

    li a0,4
    la a1,msg1
    ecall

    li a0,1
    mv a1,t0
    ecall

# sum_array()
    la a0,array       # Pointer to array
    li a1,5           # Size = 5
    call sum_array    # a0 = sum

    mv t1,a0 

    li a0,4
    la a1,msg2
    ecall

    li a0,1
    mv a1,t1
    ecall
    
# Exit
    li a0,10
    ecall

max:
    bge a0,a1,return_a
    mv a0,a1          # a1 is larger
    return_a:
        ret

sum_array:
    li t0,0           # i = 0
    li t1,0           # sum = 0
    
loop:
    bge t0,a1,done    # if i >= size
    slli t2,t0,2      # offset = i*4
    add t3,a0,t2      # address = base + offset
    lw t4,0(t3)       # array[i]
    add t1,t1,t4      # sum += array[i]
    addi t0,t0,1      # i++
    j loop

done:
    mv a0,t1          # return sum
    ret