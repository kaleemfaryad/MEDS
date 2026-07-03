# My first RISC-V program — adds two numbers
.text
.globl main
main:
addi a0, zero, 5 # ecall 5 = read int
ecall
mv a2,a0
addi a0, zero, 5 # ecall 5 = read int
ecall
add a3, a2, a0 # a2 = sum of entered numbers 
# Print result
addi a0, zero, 1 # ecall 1 = print int
mv a1, a3 # a1 = value to print
ecall
# Exit
addi a0, zero, 10 # ecall 10 = exit
ecall