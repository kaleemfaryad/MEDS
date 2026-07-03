# My first RISC-V program — adds two numbers
.text
.globl main
main:
addi a0, zero, 42 # a0 = 42
addi a1, zero, 58 # a1 = 58
add a2, a0, a1 # a2 = 100
# Print result
addi a0, zero, 1 # ecall 1 = print int
mv a1, a2 # a1 = value to print
ecall
# Exit
addi a0, zero, 10 # ecall 10 = exit
ecall