setPreference -pref UserLevel:NOVICE
setPreference -pref MessageLevel:DETAILED
setPreference -pref ConcurrentMode:FALSE
setPreference -pref UseHighz:FALSE
setPreference -pref ConfigOnFailure:STOP
setPreference -pref StartupCLock:AUTO_CORRECTION
setPreference -pref AutoSignature:FALSE
setPreference -pref KeepSVF:FALSE
setPreference -pref svfUseTime:FALSE
setPreference -pref UserLevel:NOVICE
setPreference -pref MessageLevel:DETAILED
setPreference -pref ConcurrentMode:FALSE
setPreference -pref UseHighz:FALSE
setPreference -pref ConfigOnFailure:STOP
setPreference -pref StartupCLock:AUTO_CORRECTION
setPreference -pref AutoSignature:FALSE
setPreference -pref KeepSVF:FALSE
setPreference -pref svfUseTime:FALSE
setMode -bs
setCable -port auto
Identify
attachflash -position 1 -bpi "28F00AP30"
assignfiletoattachedflash -position 1 -file "xilinx-kc705-xc7k325t.mcs"
Program -p 1 -dataWidth 16 -rs1 26 -rs0 25 -bpionly -e -loadfpga
setMode -pff
setMode -sm
setMode -bs
deleteDevice -position 1
setMode -bs
setMode -sm
setMode -dtconfig
setMode -cf
setMode -mpm
setMode -pff
setMode -bs
setMode -bs
quit