.data
cache: .word -1,-1,-1,-1, -1,-1,-1,-1, -1,-1,-1,-1, -1,-1,-1,-1, -1,-1,-1,-1, -1,
.text
.globl main
main:
    li a0,20  # n=20
    call fib
    
    mv a1,a0
    li a0,1
    ecall
    
    li a0,10
    ecall
    
fib:
#initializing the stack frame
   addi sp,sp,-16
   sw ra,12(sp)
   sw s0,8(sp)
   sw s1,4(sp)
   
   mv s0,a0
   
   la t0,cache #t0 = address of cache
   slli t1,s0,2 #t1=n*4
   add t0,t0,t1 #t0= &cache[n]
   lw t2,0(t0)  #t2= cache[n]
   
   li t4,-1   
   bne t2,t4,use_cache  # cache[n] != -1
   
   beqz s0 ,base_case0 
   
   li t5,1
   beq s0,t5,base_case1

   addi a0,s0,-1  #fib[n-1]
   call fib
   mv s1,a0
   
   addi a0,s0,-2  #fib[n-2]
   call fib 
    
   add a0,a0,s1  #fib[n] = fib[n-1] + fib[n-2]
   
   la t0,cache #t0 = address
   slli t1,s0,2 #t1=n*4
   add t0,t0,t1 #t0 &cache[n]
   sw a0,0(t0)  #storing result
   
   
   j return_fib
   
   
   base_case0:
        li a0,0
        
        la t0,cache
        sw zero,0(t0)
        
        j return_fib
   base_case1:
       li a0,1
       
       la t0 ,cache
       li t1,1
       sw t1,4(t0)
       
       j return_fib
 use_cache:
      mv a0,t2
  return_fib:
      lw s1, 4(sp)
      lw s0,8(sp)
      lw ra,12(sp)
      addi sp,sp,16
      ret
   
   
   
   