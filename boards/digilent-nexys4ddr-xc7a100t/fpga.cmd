setMode -bs
setCable -port auto
Identify 
identifyMPM 
assignFile -p 1 -file "digilent-nexys4ddr-xc7a100t.bit"
Program -p 1 -defaultVersion 0 
quit
