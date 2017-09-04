setMode -bs
setCable -port auto
Identify 
identifyMPM 
assignFile -p 1 -file "digilent-anvyl.bit"
Program -p 1 -defaultVersion 0 -e
quit
