	.file	"teste.c"
	.option nopic
	.text
	.align	2
	.globl	_start
	.type	_start, @function
_start:
	lui	sp,0x41200

	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a5,5
	sw	a5,-20(s0)
	lw	a0,-20(s0)
	#call	fib
	jal	ra,fib
	ebreak

	sw	a0,-24(s0)
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	_start, .-_start
	.align	2
	.globl	fib
	.type	fib, @function
fib:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a4,-20(s0)
	li	a5,2
	beq	a4,a5,.L3
	lw	a4,-20(s0)
	li	a5,1
	bne	a4,a5,.L4
.L3:
	li	a5,1
	j	.L5
.L4:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	mv	a0,a5
	#call	fib
	jal 	ra,fib

	mv	s1,a0
	lw	a5,-20(s0)
	addi	a5,a5,-2
	mv	a0,a5
	#call	fib
	jal 	ra,fib

	mv	a5,a0
	add	a5,s1,a5
.L5:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	addi	sp,sp,32
	jr	ra
	.size	fib, .-fib
	.ident	"GCC: (GNU) 7.2.0"
