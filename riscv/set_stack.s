.extern _start
.extern main
.file "set_stack.s"
.globl _reonv_set_stack
.type _reonv_set_stack,@function
.text
_reonv_set_stack:
	lui	sp,0x41200
	call 	main
	ebreak
