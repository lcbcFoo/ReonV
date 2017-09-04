This leon3 design is tailored to the Digilent Zedboard board

www.zedboard.org

Overview
--------

This design implements a typical LEON3 system on a Xilinx Zynq device.
The DDR3 memory attached to the Cortex-A9 processor system (PS) is
uased as LEON3 memory, and accessed through a custom AHB/AXI bridge
(ahb2axi.vhd).


Simulation
----------

Simulation should work with any supported VHDL simultor.
To build and load the design with the modelsim simulator, do:

  make install-secureip_ver
  make sim
  make sim-launch

The PS and external memory is be emulated by a simple model
(leon3_zedboard_stub_sim.vhd) that provides clocks, reset and
 1 Mbyte or memory. No other PS functionality is emulated.

The standard testbench will only work when the AHBROM module
is enabled in xconfig (default on) as it will provide the boot
strap code and jump to RAM.

Synthesis
---------

Synthesis will ONLY work with Vivado 2013.4.  To synthesize the design, do:

  make vivado

or 

  make vivado-launch

  (interactive run).

To program the board, do:

  make vivado-zedboard


Design specifics
----------------

* The top 256 Mnyte of the DDR3 (0x10000000 - 0x20000000) is
  mapped into AHB address space at 0x40000000 - 0x50000000 using
  an AHB/AXI bridge and the S_AXI_GP0 interface on the PS.

* System reset is mapped on the south button (button[0]).

* DSU break is mapped to switch[0]

* The LEON3 system is clocked at 83.3333 MHz, using FCLK_CLK0
  from the PS. Other frequencies can be used by re-configuring the
  PS in Vivado and re-running synthesis.

* LED 0 indicates processor in debug mode

* LED 1 indicates processor in error mode, execution halted

* LED 2 indicates AHB HREADY signal.

* LED 3 UART1 TX

* LED 4 GPIO 11

* LED 5 GPIO 12
5
* LED 6 GPIO 13

* LED 7 GPIO 14


Board programming
-----------------

Always program the Zedboard via the make target 'program-zedboard'
This requires the installation of Xilinx EDK or SDK.

$ make program-zedboard
xmd
Xilinx Microprocessor Debugger (XMD) Engine
Xilinx EDK 14.3 Build EDK_P.40xd
Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.

XMD% 
Programming Bitstream -- ./planAhead/leon3-zedboard-xc7z020/leon3-zedboard-xc7z020.runs/impl_1/leon3mp.bit
Fpga Programming Progress ............10.........20.........30.........40.........50.........60.........70.........80.........90........Done
Successfully downloaded bit file.

JTAG chain configuration
--------------------------------------------------
Device   ID Code        IR Length    Part Name
 1       4ba00477           4        Cortex-A9
 2       03727093           6        XC7Z020


JTAG chain configuration
--------------------------------------------------
Device   ID Code        IR Length    Part Name
 1       4ba00477           4        Cortex-A9
 2       03727093           6        XC7Z020

CortexA9 Processor Configuration
-------------------------------------
Version.............................0x00000003
User ID.............................0x00000000
No of PC Breakpoints................6
No of Addr/Data Watchpoints.........1

Connected to "arm" target. id = 64
Starting GDB server for "arm" target (id = 64) at TCP port no 1234
Info:  Enabling level shifters and clearing fabric port resets


Executing programs with grmon
-----------------------------

* The JTAG DSU interface is enabled and accesible via the JTAG port.
  Start grmon with -xilusb to connect.

* Start grmon with the -u swith to see UART output. The UART connected
  to the PS (USB UART) cannot be used.

* Do not use the CPU RESET button to reset the LEON3 system, as this
  will require to initialiaze the PS using xmd again. Use the south
  button as reset if neessary.

* Output from GRMON is:

jiri@antec:~$ grmon -xilusb -u 

 Xilinx cable: Cable type/rev : 0x3 
 JTAG chain: xc7x020 zynq7000_arm_dap 

 GRLIB build version: 4140

 initialising ...........
 detected frequency:  84 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 AHB ROM                              Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 Xilinx MIG DDR2 controller           Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 General purpose I/O port             Gaisler Research
 AHB status register                  Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> info sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x3)
             ahb master 0
01.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x2)
             ahb master 1
00.01:01b   Gaisler Research  AHB ROM (ver 0x0)
             ahb: 00000000 - 00100000
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000
             AHB trace 128 lines, 32-bit bus, stack pointer 0x4ffffff0
             CPU#0 win 8, hwbp 1, itrace 128, V8 mul/div, srmmu, lddel 1
                   icache 2 * 8 kbyte, 32 byte/line lru
                   dcache 2 * 4 kbyte, 32 byte/line lru
03.01:06b   Gaisler Research  Xilinx MIG DDR2 controller (ver 0x0)
             ahb: 40000000 - 50000000
             apb: 80000000 - 80000100
             DDR2: 256 Mbyte
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: 80000100 - 80000200
             baud rate 38461, DSU mode (FIFO debug)
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: 80000300 - 80000400
             8-bit scaler, 2 * 32-bit timers, divisor 84
08.01:01a   Gaisler Research  General purpose I/O port (ver 0x2)
             apb: 80000800 - 80000900
0f.01:052   Gaisler Research  AHB status register (ver 0x0)
             irq 7
             apb: 80000f00 - 80001000
grlib> lo ~/examples/dhry412 
section: .text at 0x40000000, size 53296 bytes
section: .data at 0x4000d030, size 2764 bytes
total size: 56060 bytes (1.1 Mbit/s) 
read 262 symbols
entry point: 0x40000000
grlib> run
Execution starts, 1000000 runs through Dhrystone
Total execution time:                          4.7 s
Microseconds for one run through Dhrystone:    4.7 
Dhrystones per Second:                      214284.1 

Dhrystones MIPS      :                       122.0 


Program exited normally.
grlib> 


Problems
--------

* The grmon verify command does not work correctly due to some problems
  with the JTAG debug interface on Zynq. The load command works correctly
  abd programs can be loaded and executed as normal.

