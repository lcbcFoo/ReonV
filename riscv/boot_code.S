.file "boot_code.S"
.equ RAMSTART,  0x40000000
.equ RAMSIZE,   0x08000000

.text
.org 0x0
__boot_code:
	#li		sp,RAMSTART+RAMSIZE-32
	li		a5,RAMSTART
	jalr	a5
	nop
