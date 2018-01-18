.file "reonv_crt0.S"
.extern _start
.extern main
.globl __reonv_startup
.type "__reonv_startup",@function

# Build minimal crt0 in future
__reonv_startup:
	# Set stack (maybe will change this to boot code)
	li	sp,0x48FFFFF0
	call 	main
	jal 	__exit

# Exit routine
__exit:
	ebreak

# Interruptions vector
__interruption_vector:
	



# Interruptions handlers
__ecall_handler:

	


