proc create_lattice_top_lct {} {
	global ISPLIB PART SPEED PACKAGE ISPPACKAGE TOP
	set tlc ""
	append tlc "\[Device\]\n"
	append tlc "Family = $ISPLIB;\n"
	append tlc "PartNumber = $PART$SPEED$PACKAGE;\n"
	append tlc "Package = $ISPPACKAGE;\n"
	append tlc "PartType = $PART;\n"
	append tlc "Speed = $SPEED;\n"
	append tlc "Operating_condition = COM;\n"
	append tlc "Status = Production;"
	set lctfile [open "$TOP.lct" w]
	puts $lctfile $tlc
	close $lctfile
	return
}

