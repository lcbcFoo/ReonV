setMode -bs
setCable -port auto
identify -inferir 
attachflash -position 1 -spi "S25FL128S"
assignFile -p 1 -file "digilent-nexys4ddr-xc7a100t.mcs"
assignfiletoattachedflash -position 1 -file "digilent-nexys4ddr-xc7a100t.mcs"
program -p 1 -dataWidth 1 -spionly -e -v -loadfpga 
quit
