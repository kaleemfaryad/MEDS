.text
.globl main

main:
    li a0,10          # n = 10
    call fib
    
    # Print answer
    mv a1,a0
    li a0,1
    ecall
    li a0,10
    ecall

fib:
    addi sp,sp,-16
    sw ra,12(sp)
    sw s0,8(sp)
    sw s1,4(sp)

# Save n
    mv s0,a0
    # Base Case
    beqz a0,fib_zero
    li t0,1
    beq a0,t0,fib_one

# Compute fib(n-1)
    addi a0,s0,-1
    call fib
    mv s1,a0          # Save fib(n-1)
    
    # Compute fib(n-2)
    addi a0,s0,-2
    call fib

    # fib(n)=fib(n-1)+fib(n-2)
    add a0,a0,s1
    j fib_return

# fib(0)
fib_zero:
    li a0,0
    j fib_return

# fib(1)
fib_one:
    li a0,1

fib_return:
    lw s1,4(sp)
    lw s0,8(sp)
    lw ra,12(sp)
    addi sp,sp,16
    ret