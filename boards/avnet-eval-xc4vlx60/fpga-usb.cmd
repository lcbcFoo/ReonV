setMode -bscan
setCable -port usb21
Identify 
identifyMPM
assignFile -p 2 -file "avnet-eval-xc4vlx60.bit"
Program -p 2 -defaultVersion 0 
quit
