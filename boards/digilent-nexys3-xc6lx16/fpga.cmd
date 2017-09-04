setMode -bs
setCable -port auto
Identify 
identifyMPM 
assignFile -p 1 -file "digilent-nexys3-xc6lx16.bit"
Program -p 1 -defaultVersion 0 
quit
