This leon3 design is tailored to the Xilinx XtremeDSP Starter Platform, 
Spartan-3A DSP 1800A Edition

http://www.xilinx.com/s3adspstarter


Design specifics:

* When performing synthesis with the ISE suite it may be difficult to meet
  all timing constraints. Minor violations (~ 0.5 ns) on the DDR2 
  constraints is OK, since they are somewhat tight ...

* System reset is mapped to SW5 (reset)

* DSU break is mapped to SW6 

* LED 13/14 indicates DSU UART TX and RX activity.

* LED 12 indicates processor in debug mode

* LED 11 indicates if the DLL in the DDR2 memory controller is locked
  to the system clock

* LED 7 indicates processor in error mode

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Ethernet debug link is enabled, default IP is 192.168.0.51.
  There are issues with the auto negotiation with the PHY. If the
  board is connected to a gigabit switch this may lead to the phy
  settling in gigabit mode and the 10/100 GRETH will not be able to
  communicate. The PHY can be forced into 100 Mbit operation with
  the GRMON command 'wmdio 1 0 0x2000'. This command can be issued
  when connecting with the UART or JTAG debug link.

* 8-bit flash prom can be read at address 0. It can be programmed
  with GRMON version 1.1.16 or later.

* DDR2 is mapped at address 0x40000000 (128 Mbyte) and is clocked
  at 125 MHz. The processor and AMBA system runs on a different
  clock, and can typically reach 40 MHz. The processor clock
  is generated from the 125 MHz clock oscillator, scaled with the
  DCM factors (8/25) in xconfig.
  The DDR2 read delay may have to be adjusted using the GRMON command
  ddr2skew [dec | inc].

* The application UART1 is connected to the male RS232 connector.

* The JTAG DSU interface is enabled.

* Either SPICTRL or SPIMCTRL can be enabled to interact with the Intel
  S33 serial Flash memory. A suitable configuration for SPIMCTL is:
  Read instruction: 0x03
  Read instruction requires dummy byte: n
  Enable dual output for reads: n
  Clock divisor for device clock: 1
  Clock divisor for alt. device clock: 1
  The MISO signal is shared with the parallel flash memory. It is
  recommended that the MCTRL core is disabled if a SPI core is enabled.

* Output from GRMON is:

$ grmon -eth -ip 192.168.0.51 -u -nb                                                                                     

 GRMON LEON debug monitor v1.1.38 professional version

 Copyright (C) 2004-2008 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/              
 Comments or bug-reports to support@gaisler.com                 


 ethernet startup.
 GRLIB build version: 4090

 initialising ...........
 detected frequency:  40 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 DDR2 Controller                      Gaisler Research
 LEON2 Memory Controller              European Space Agency
 Generic APB UART                     Gaisler Research     
 Multi-processor Interrupt Ctrl       Gaisler Research     
 Modular Timer Unit                   Gaisler Research     
 General purpose I/O port             Gaisler Research     

 Use command 'info sys' to print a detailed report of attached cores

grlib> inf sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0                                       
01.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x0)      
             ahb master 1                                       
02.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)         
             ahb master 2, irq 12                               
             apb: 80000f00 - 80001000                           
             edcl ip 192.168.0.51, buffer 2 kbyte              
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)          
             ahb: 80000000 - 80100000                           
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000                           
             AHB trace 256 lines, stack pointer 0x47fffff0      
             CPU#0 win 8, hwbp 2, itrace 256, V8 mul/div, srmmu, lddel 1
                   icache 2 * 4 kbyte, 32 byte/line lrr                 
                   dcache 2 * 4 kbyte, 16 byte/line lrr                 
04.01:02e   Gaisler Research  DDR2 Controller (ver 0x0)                 
             ahb: 40000000 - 50000000                                   
             ahb: fff00100 - fff00200                                   
             32-bit DDR2 : 1 * 128 Mbyte @ 0x40000000                   
                          125 MHz, col 10, ref 7.8 us, trfc 136 ns      
05.04:00f   European Space Agency  LEON2 Memory Controller (ver 0x1)    
             ahb: 00000000 - 20000000                                   
             ahb: 20000000 - 40000000                                   
             apb: 80000000 - 80000100                                   
             8-bit prom @ 0x00000000                                    
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)                
             irq 2                                                      
             apb: 80000100 - 80000200                                   
             baud rate 38461, DSU mode (FIFO debug)                     
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)  
             apb: 80000200 - 80000300                                   
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)              
             irq 8                                                      
             apb: 80000300 - 80000400                                   
             8-bit scaler, 2 * 32-bit timers, divisor 40                
0b.01:01a   Gaisler Research  General purpose I/O port (ver 0x0)        
             apb: 80000b00 - 80000c00                                   
grlib> fla                                                              

 Intel-style 8-bit flash on D[31:24]

 Manuf.    Intel               
 Device    MT28F128J3      )   

 Device ID ba67ffff9a00bd44    
 User   ID ffffffffffffffff    


 1 x 16 Mbyte = 16 Mbyte total @ 0x00000000


 CFI info
 flash family  : 1
 flash size    : 128 Mbit
 erase regions : 1
 erase blocks  : 128
 write buffer  : 32 bytes
 region  0     : 128 blocks of 128 Kbytes

grlib> lo ~/examples/dhry412
section: .text at 0x40000000, size 53296 bytes
section: .data at 0x4000d030, size 2764 bytes
total size: 56060 bytes (40.2 Mbit/s)
read 262 symbols
entry point: 0x40000000
grlib> run
Execution starts, 1000000 runs through Dhrystone
Total execution time:                         11.3 s
Microseconds for one run through Dhrystone:   11.3
Dhrystones per Second:                      88668.9

Dhrystones MIPS      :                        50.5


Program exited normally.
grlib>

