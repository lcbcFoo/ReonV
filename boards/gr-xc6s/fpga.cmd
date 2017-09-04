setMode -bs
setCable -port auto
Identify 
identifyMPM 
assignFile -p 1 -file "gr-xc6s.bit"
Program -p 1 -defaultVersion 0 -e
quit
