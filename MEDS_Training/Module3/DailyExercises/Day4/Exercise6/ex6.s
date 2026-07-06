.text
.globl main

main:
    li a0,2              # a0 = base = 2
    li a1,10             # a1 = exponent = 10
    call power           # call power(2,10)

    mv a1,a0             # print result
    li a0,1              # ECALL 1 = print integer
    ecall               

    li a0,10            
    ecall

power:
    addi sp,sp,-16       # Allocate 16-byte 
    sw ra,12(sp)         # Save return address
    sw s0,8(sp)          # Save s0
    sw s1,4(sp)          # Save s1

   # Save function arguments
    mv s0,a0             # s0 = base (preserve across recursion)
    mv s1,a1             # s1 = exponent
    beqz s1,base_case    # if exponent==0 return 1

    # Recursive Call
    mv a0,s0             # first argument = base
    addi a1,s1,-1        # second argument = exponent-1
    call power           # recursively compute power(base,exp-1)

    # Multiply by base
    mul a0,a0,s0         # answer = returned_value × base
    j power_return       # skip base case


base_case:
    li a0,1              # base^0 = 1

power_return:
    lw s1,4(sp)       
    lw s0,8(sp)        
    lw ra,12(sp)         
    addi sp,sp,16        
    ret                 