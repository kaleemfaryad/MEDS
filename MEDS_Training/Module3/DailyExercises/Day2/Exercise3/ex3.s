.data
array: .word 10, 20, 30, 40, 50, 2, 4,5 
.text
main:
la s0, array # s0 = base address
li s1, 8 # array size
li s2, 0 # sum = 0
li t0, 0 # i = 0
loop:
bge t0, s1, done # if i >= size, exit
slli t1, t0, 2 # t1 = i * 4 (byte offset)
add t2, s0, t1 # t2 = &array[i]
lw t3, 0(t2) # t3 = array[i]
add s2, s2, t3 # sum += array[i]
addi t0, t0, 1 # i++
j loop
done: # s2 = 150
   # Print result
addi a0, zero, 1 # ecall 1 = print int
mv a1, s2 # a1 = value to print
ecall
# Exit
addi a0, zero, 10 # ecall 10 = exit
ecall