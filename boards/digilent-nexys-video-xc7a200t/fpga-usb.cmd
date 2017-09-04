setMode -bscan
setCable -p usb21
identify
assignfile -p 1 -file digilent-nexys4ddr-xc7a100t.bit
program -p 1
quit

