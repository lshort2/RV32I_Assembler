addi x4,x0,#16
addi x5,x0,#4
addi x6,x0,#0

addi x2,x0,#0
addi x3,x0,#1024
bge x2,x3,#32

add x6,x4,x5
addi x6,x6,#-2
addi x7,x0,#1

addi x2,x2,#1
jal x0,#-20
NOP
NOP

add x1,x4,x6
