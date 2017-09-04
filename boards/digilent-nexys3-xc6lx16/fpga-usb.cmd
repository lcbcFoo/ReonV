setMode -bscan
setCable -p usb21
identify
assignfile -p 1 -file digilent-nexys3-xc6lx16.bit
program -p 1
quit

