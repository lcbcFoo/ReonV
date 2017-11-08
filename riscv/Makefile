# Author: Lucas Castro
# Last modification: sep/2017
#
# 	Makefile for creating a raw binary RV32I program for ReonV 

CC=gcc
AS=as
OBJCOPY=objcopy
CROSS=/home/foo/IC/riscv-leon/rv32i/rv32i-gnu/bin/riscv32-unknown-elf-
CFLAGS=-nostdlib
OBJCPFLAGS=-O binary -j .text


CPPROGRAM=

# Target .s
%.s : %.c
		${CROSS}$(CC) -S $(CFLAGS) $(CPPFLAGS) $< -o $@

# Target .o
%.hex : %.s
		${CROSS}$(AS) $< -o $@

# Target raw binary
%.bin : %.hex
		${CROSS}$(OBJCOPY) $(OBJCPFLAGS)  $< $@

# Inverts target for grmon load (it considers binary is big-endian)
%.inv : %.bin
		./swap $< $@

cp-program :
		cp $(CPPROGRAM) ./repo/designs/leon3-digilent-xc7z020/

clean:
		rm -rf *.inv *.bin *.o *.log *.jou *.str
