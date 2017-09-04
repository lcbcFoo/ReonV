setMode -bscan
setCable -p usb21
identify
assignfile -p 1 -file ztex-ufm-115.bit
program -p 1
quit

