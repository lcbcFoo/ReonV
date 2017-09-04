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
setCable -port usb21
Identify
setAttribute -position 2 -attr configFileName -value "xilinx-ml510-xc5vfx130t.bit"
Program -p 2 -v 
setMode -pff
setMode -sm
setMode -bs
setMode -bs
setMode -sm
setMode -bsfile
setMode -dtconfig
setMode -cf
setMode -mpm
setMode -pff
setMode -bs
setMode -bs
quit
