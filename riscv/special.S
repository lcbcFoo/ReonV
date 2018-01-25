.text
.globl main
.type "main",@function

main:
	li	x4,0x40000100
	csrrw	x0,3,x4
	csrrs	x5,3,x0
	ecall
	li	x30,0x98765
	ebreak

.org 0x100
	li	x31,0x12345
	ebreak
