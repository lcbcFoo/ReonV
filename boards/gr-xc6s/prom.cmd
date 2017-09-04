setMode -bs
setCable -port auto
identify -inferir 
attachflash -position 1 -spi "W25Q64BV"
assignfiletoattachedflash -position 1 -file "gr-xc6s.mcs"
program -p 1 -dataWidth 4 -spionly -e -v -loadfpga 
quit
