# Author: Lucas Castro
# Last modification: sep/2017
#
# 	Makefile for creating a raw binary RV32I program for ReonV


#######################################################################
# Update the following variables to your environment
# to run example program
CROSS=/home/foo/IC/riscv-leon/rv32i/rv32i-gnu/bin/riscv32-unknown-elf-
#######################################################################
CC=gcc
AS=as
OBJCOPY=objcopy
CFLAGS=-nostdlib
OBJCPFLAGS=-O binary -j .text



# Target .s
%.s : %.c
		${CROSS}$(CC) -S $(CFLAGS) $(CPPFLAGS) $< -o $@


#################################################################
#
# Note that target %.hex requeries %.S, not the makefile target %.s!
# They are different here because there are modifications needed
# on assembly code before running! (set stack, for example)
# More details on README 
#
#################################################################
# Target .o
%.hex : %.S
		${CROSS}$(AS) $< -o $@

# Target raw binary
%.bin : %.hex
		${CROSS}$(OBJCOPY) $(OBJCPFLAGS)  $< $@

clean:
		rm -rf *.hex *.inv *.bin *.o *.log *.jou *.str
