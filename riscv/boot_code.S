.file "boot_code.S"
.equ RAMSTART,  0x40000000

.text
.org 0x0

__boot_code:
	li		a5,RAMSTART
	jalr	a5
	nop
