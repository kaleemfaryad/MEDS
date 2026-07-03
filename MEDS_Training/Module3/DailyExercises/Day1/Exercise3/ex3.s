.data
message: .string "Hello MEDS!"
.text
main:
la a1, message # ao =  message 
addi a0, zero, 4 # ecall 4 = print string
ecall
addi a0, zero, 10 # ecall 10 = exit
ecall