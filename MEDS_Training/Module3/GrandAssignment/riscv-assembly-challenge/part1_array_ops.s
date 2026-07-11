.equ SIZE,12
.data
array: .word 1,-2,3,4,-5,6,7,-8,9,10,11,-12
Sum: .string "Sum: "
Min: .string "\nMin: "
Max: .string "\nMax: "
Neg_count: .string"\nNegative_count: "
SortedArray: .string "Sorted Array: "
Space: .string " "
.text
.globl main
main:
#sum of the array
    la a1,Sum
    li a0,4
    ecall 
    
    la a0,array          # a0 = address of array
    li a1,SIZE             # a1 = size of array
    call sum_array

    mv a1,a0             # print result
    li a0,1              # ECALL 1 = print integer
    ecall                # Sum: 24
    
#Min value of the array
    la a1,Min
    li a0,4
    ecall 
    
    la a0,array          # a0 = address of array
    li a1,SIZE            # a1 = size of array
    call find_min

    mv a1,a0             # print result
    li a0,1              # ECALL 1 = print integer
    ecall                # Min: -12
    
#max value of the array
    la a1,Max
    li a0,4
    ecall 
    
    la a0,array          # a0 = address of array
    li a1,SIZE            # a1 = size of array
    call find_max

    mv a1,a0             # print result
    li a0,1              # ECALL 1 = print integer
    ecall                # Max: 11
   
 #count negative values 
    la a1,Neg_count
    li a0,4
    ecall 
    
    la a0,array          # a0 = address of array
    li a1,SIZE             # a1 = size of array
    call count_negative

    mv a1,a0             # print result
    li a0,1              # ECALL 1 = print integer
    ecall                # Negative_count: 4
   
    li a0,4                  # print string
    la a1,SortedArray        
    ecall

    la a0,array               # a0 = base address
    li a1,SIZE               
    call selection_sort       

    la t6,array               # t6 = base address
    li t0,0                   # i = 0
    li t1,SIZE             

print_array:
    bge t0,t1,exit_program    # if i>=size exit
    slli t2,t0,2              # i*4
    add t3,t6,t2              # address=&array[i]
    lw t4,0(t3)               # t4=array[i]

    li a0,1                 
    mv a1,t4                 
    ecall

    li a0,4                   # print space
    la a1,Space
    ecall

    addi t0,t0,1              # i++

    j print_array

exit_program:
    li a0,10                  # exit
    ecall





sum_array:
    li t0,0   # sum=0
    li t1,0   # i=0
    mv t2,a0  # t2=address of array
    mv t3,a1  # t3=size of array
    sum_loop:
      bge t1,t3,sum_done # i>= size
      slli t4,t1,2   # t4 = i*4   i<<2
      add t5,t2,t4   # t5 = &array[i*4]    
      lw t6,0(t5)    # t6 = array[i*4]
      add t0,t0,t6   # sum += array[i*4]
      addi t1,t1,1
      j sum_loop
    sum_done:    
        mv a0,t0
        ret
find_min:
    
    lw t0 ,0(a0) # min = 0
    li t1,0  # i=0
    mv t2,a0  # t2=address of array
    mv t3,a1  # t3=size of array
    min_loop:
        bge t1,t3,min_done # i>= size
        slli t4,t1,2   # t4 = i*4   i<<2
        add t5,t2,t4   # t5 = &array[i*4]    
        lw t6,0(t5)    # t6 = array[i*4]
        bgt t6,t0, next  #t6>t0
        mv t0,t6
            next:
            addi t1,t1,1   #i++
            j min_loop
        min_done:
            mv a0,t0
            ret
        
find_max:
    lw t0 ,0(a0) # max = 0
    li t1,0  # i=0
    mv t2,a0  # t2=address of array
    mv t3,a1  # t3=size of array
    max_loop:
        bge t1,t3,max_done # i>= size
        slli t4,t1,2   # t4 = i*4   i<<2
        add t5,t2,t4   # t5 = &array[i*4]    
        lw t6,0(t5)    # t6 = array[i*4]
        blt t6,t0, n #t6<t0
        mv t0,t6
        n:
        addi t1,t1,1   #i++
        j max_loop
        max_done:
            mv a0,t0
            ret
count_negative:
    li t0 ,0 # count = 0
    li t1,0  # i=0
    mv t2,a0  # t2=address of array
    mv t3,a1  # t3=size of array
    count_loop:
        bge t1,t3,count_done # i>= size
        slli t4,t1,2   # t4 = i*4   i<<2
        add t5,t2,t4   # t5 = &array[i*4]    
        lw t6,0(t5)    # t6 = array[i*4]
        bgt t6,zero,ne  #t6>0
        addi t0,t0,1
        ne:
        addi t1,t1,1   #i++
        j count_loop
        count_done:
            mv a0,t0
            ret
                

selection_sort:
    addi sp,sp,-16            # allocate stack space
    sw s0,12(sp)              # save s0
    sw s1,8(sp)               # save s1
    sw s2,4(sp)               # save s2
    sw s3,0(sp)               # save s3

    mv t0,a0                  # base address
    mv t1,a1                  # size

    li t2,0                   # i=0

outer_loop:
    addi t6,t1,-1             # size-1
    bge t2,t6,sort_done       # if i>=size-1 
    mv t4,t2                  # minIndex=i
    addi t3,t2,1              # j=i+1

inner_loop:
    bge t3,t1,swap_check      # if j>=size
    slli t5,t3,2              # offset=j*4
    add s0,t0,t5              # &array[j]
    lw s1,0(s0)               # s1=array[j]
    
    slli t5,t4,2              # minIndex*4
    add s2,t0,t5              # &array[minIndex]
    lw s3,0(s2)               # s3=array[minIndex]

    blt s1,s3,update_min      # if arr[j]<arr[min]

continue_inner:
    addi t3,t3,1              # j++
    j inner_loop

update_min:
    mv t4,t3                  # minIndex=j
    j continue_inner
 
 swap_check:
    beq t4,t2,next_outer      # if minIndex==i, no swap
    slli t5,t2,2              # offset=i*4
    add s0,t0,t5              # s0=&array[i]

    slli t5,t4,2              # offset=minIndex*4
    add s2,t0,t5              # s2=&array[minIndex]

    lw s1,0(s0)               # s1=array[i]
    lw s3,0(s2)               # s3=array[minIndex]

    sw s3,0(s0)               # array[i]=array[minIndex]
    sw s1,0(s2)               # array[minIndex]=temp

next_outer:
    addi t2,t2,1              # i++
    j outer_loop

sort_done:
    lw s3,0(sp)               # restore s3
    lw s2,4(sp)               # restore s2
    lw s1,8(sp)               # restore s1
    lw s0,12(sp)              # restore s0
    addi sp,sp,16             # deallocate stack
    ret
 