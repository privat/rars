#stdout:87654321HGFEDCBA2685009920
#exit:42
.data
data:
.eqv eqv, 0x3132333435363738
.dword eqv
.dword 0x4142434445464748

data2: .dword data
.byte 0

.text
li a7, 4 # PrintString
la a0, data
ecall

la s1, data2
li a7, 1 # PrintInt
lw a0, 0(s1)
ecall
lw a0, 4(s1)
ecall

li a7, 93 # Exit2
li a0, 42
ecall
