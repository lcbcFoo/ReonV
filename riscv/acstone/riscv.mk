CROSS_CFLAGS = -g -march=rv32imafd -std=gnu99 -mabi=ilp32d
LINK_OPTS = -nostartfiles -lc -lm
LIB_DIR	:=	-L../riscv/tests/libac_sysc
LIBS	:=	-lc -lac_sysc
HAL		:=	../riscv/tests/rv_hal/get_id.S

# Compile programs
$(TESTS):
	$(CROSS_COMPILER) -c ../riscv/tests/rv_hal/crt.S $(CROSS_CFLAGS)
	$(CROSS_COMPILER) $(CROSS_CFLAGS) $@.c -o $@$(SUFFIX) $(HAL) $(LIB_DIR) $(LIBS) -T ../riscv/tests/rv_hal/test.ld $(CROSS_CFLAGS) $(LINK_OPTS)
	
