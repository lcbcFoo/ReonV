setMode -bscan
setCable -p usb21
identify
assignfile -p 1 -file xilinx-sp601-xc6slx16.bit
program -p 1
quit

