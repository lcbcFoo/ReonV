setMode -bs
setCable -port auto
identify -inferir
identifyMPM
attachflash -position 2 -bpi "28F256P30"
assignfiletoattachedflash -position 2 -file "xilinx-ml605-xc6vlx240t.mcs"
Program -p 2 -dataWidth 16 -rs1 25 -rs0 24 -bpionly -e -v -loadfpga
verify -p 2 -dataWidth 16 -rs1 25 -rs0 24 -bpionly
closeCable
quit
