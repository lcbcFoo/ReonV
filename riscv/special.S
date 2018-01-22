.text
.globl main
.type "main",@function

main:
	li	x4,0x40000100
	csrr	x4,3
	csrw	3,x5
	ebreak
