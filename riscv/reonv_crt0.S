.file "reonv_crt0.S"
.extern _start
.extern main
.globl __reonv_startup
.type "__reonv_startup",@function

# Build minimal crt0 in future
__reonv_startup:
	# Clean registers and set stack (maybe will change this to boot code)
	addi	x1,x0,0
	addi	x2,x0,0
	addi	x3,x0,0
	addi	x4,x0,0
	addi	x5,x0,0
	addi	x6,x0,0
	addi	x7,x0,0
	addi	x8,x0,0
	addi	x9,x0,0
	addi	x10,x0,0
	addi	x11,x0,0
	addi	x12,x0,0
	addi	x13,x0,0
	addi	x14,x0,0
	addi	x15,x0,0
	addi	x16,x0,0
	addi	x17,x0,0
	addi	x18,x0,0
	addi	x19,x0,0
	addi	x20,x0,0
	addi	x21,x0,0
	addi	x22,x0,0
	addi	x23,x0,0
	addi	x24,x0,0
	addi	x25,x0,0
	addi	x26,x0,0
	addi	x27,x0,0
	addi	x28,x0,0
	addi	x29,x0,0
	addi	x30,x0,0
	addi	x31,x0,0

	li	sp,0x42000000
	call 	main
	jal 	__exit

# Exit routine
__exit:
	ebreak

# Interruptions vector
__interruption_vector:




# Interruptions handlers
__ecall_handler:
