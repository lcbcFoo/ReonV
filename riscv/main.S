	.file	"teste.c"
	.option nopic
	.text
	.align	2
	.globl	_start
	.type	_start, @function
_start:
	# Need to set stack pointer!
	lui	sp,0x41200


	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	li	a5,1
	sw	a5,-20(s0)
	sw	zero,-24(s0)
.L2:
	li	a1,4
	lw	a0,-20(s0)
	jal	ra,mul
	sw	a0,-20(s0)
	lw	a5,-24(s0)
	add	a5,a5,1

	# Move counter to x7
	mv	x7,a5

	sw	a5,-24(s0)
	lw	a4,-20(s0)
	li	a5,4096
	add	a5,a5,-1597
	ble	a4,a5,.L2
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	add	sp,sp,32

	###########################
	# Move i to x6, since we dont have printf yet =( 
	mv	x6,a4
	# Stop processor
	sbreak
	###########################

	jr	ra
	.size	_start, .-_start
	.align	2
	.globl	mul
	.type	mul, @function
mul:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lw	a5,-20(s0)
	bnez	a5,.L4
	li	a5,0
	j	.L5
.L4:
	lw	a5,-20(s0)
	add	a5,a5,-1
	lw	a1,-24(s0)
	mv	a0,a5
	jal	ra,mul
	mv	a4,a0
	lw	a5,-24(s0)
	add	a5,a4,a5
.L5:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	add	sp,sp,32
	jr	ra
	.size	mul, .-mul
	.ident	"GCC: (GNU) 7.1.1 20170509"
