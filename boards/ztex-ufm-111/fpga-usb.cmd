setMode -bscan
setCable -p usb21
identify
assignfile -p 1 -file ztex-ufm-111.bit
program -p 1
quit

