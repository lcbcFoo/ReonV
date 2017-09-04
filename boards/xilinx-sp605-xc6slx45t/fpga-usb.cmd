setMode -bscan
setCable -p usb21
identify
assignfile -p 1 -file xilinx-sp605-xc6slx45t.bit
program -p 1
quit

