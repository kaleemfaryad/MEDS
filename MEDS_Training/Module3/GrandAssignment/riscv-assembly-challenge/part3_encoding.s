.data
instructions:
    .word 0x007302B3     # add x5,x6,x7
    .word 0x00A30293     # addi x5,x6,10
    .word 0x00532423     # sw x5,8(x6)
    .word 0x00628863     # beq x5,x6,16
    .word 0x123452B7     # lui x5,0x12345
    .word 0x020000EF     # jal x1,32
    
 opcode: .string "\nOpcode: "
 rd: .string"   rd: "
 funct3: .string"    funct3: "
 rs1: .string"  rs1: "
.text
.globl main
main:
    la s0,instructions 
    li s1, 6 # i
    
loop:
    beqz s1,exit
    lw t0,0(s0)
    
    #extracting the opcode [6:0]
    andi t1,t0,0x7F
    
    la a1,opcode
    li a0, 4
    ecall
    
    mv a1,t1
    li a0,1
    ecall
    
    #extracting rd
    srli t2,t0,7   #instruction>>7
    andi t2,t2,0x1F
        
    la a1,rd
    li a0, 4
    ecall
    
    mv a1,t2
    li a0,1
    ecall
    
    #extracting funct3
    srli t3,t0,12
    andi t3,t3,0x07
        
    la a1,funct3
    li a0, 4
    ecall
    
    mv a1,t3
    li a0,1
    ecall
    
    #extracting rs1
    srli t4,t0,15
    andi t4,t4,0x1F
    
    la a1,rs1
    li a0, 4
    ecall
    
    mv a1,t4
    li a0,1
    ecall
    
    
    addi s0,s0,4 #next instructiom
    addi s1,s1,-1 # i--
    j loop
    
    exit:
    li a0,10
    ecall
    
    
    
   
   
   