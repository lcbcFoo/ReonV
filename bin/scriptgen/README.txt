Manual for scriptgen

scriptgenwork
If this directory is not present in the directory calling 'make scripts', it
will be copied to that directory (this happens in dependencies.tcl). The directory
will be coped from scriptgencfg if that directory exists in the template
design or otherwise from bin/scriptgen/scripgencfg/. A local copy in the 
template design can be made to contain files that can be altered by the user.
Note that "make distclean" will remove scriptgen/work.

scriptgenwork/tools.tcl
Specifies which tools are going to be used for generating a project. This file
is sourced to main.tcl, dependencies.tcl and targets.tcl in order to only 
generate files specific to the needed tools. The main part of the tcl program is
located in  $GRLIB/bin/scriptgen.

scriptgenwork/extrafiles.tcl
If files are to be included that are not found through scanning in 
generatefilelists in database.tcl they may be specified here.

Guide to adding extra files in scriptgenwork/extrafiles.tcl:
Each file and lib added must be added to both the extrafiletree and 
extrafileinfo dicts. extrafiletree must follow the same structure as filetree 
does in generatefilelists. 

The structure of filetree is: 
	Filetree is a dict.
	An entry in the dict has a lib(key) and a dict(value).
	An entry in the nested dict has a dir(key) and a list(value).
	The list consists of files which are present within that dir.

Each lib and file added to the filetree also has to be added to the 
extrafileinfo dict.

The structure of fileinfo is:
	Fileinfo is a dict.
	An entry in the dict has a lib/file(key) and a dict(value).
	The nested dict has different entries depending on if it's a lib or a file.

	Entries in the nested dict for a lib are: 
	key	   : value
	-------------------------------------
	bn     : lib's basename
	k_real : real path for that lib

	Entries in the nested dict for a file are:
	key	   : value
	-------------------------------------
	bn     : lib's basename
	l	   : parent directory dir
	i      : the type of the file
	q      : the filename

See scripgencfg-examples/extrafiles for an example of added files.

scriptgenwork/filebuild
If an extra tool has been added, database.tcl will try to source $tool.tcl from
this folder in order to create configuration files specific to that tool.
A skeleton of a $tool.tcl file called newtool.tcl can be found in 
$GRLIB/bin/scriptgen/scriptgencfg-examples.




Documentation of main program always located in  $GRLIB/bin/scriptgen:


dependencies.tcl
If scriptgencfg is not present in the directory calling 'make scripts'
it will be copied from $GRLIB/bin/scriptgen/scriptgencfg to the calling
directory. depencencies.tcl then generates a string of files depending on which
tools are used to create the correct dependencies in the script: section in 
$GRLIB/bin/Makefile.

targets.tcl
Generates a string of files depending on which tools are used to create the
correct targets in the script: section in $GRLIB/bin/Makefile.

main.tcl
The program which starts the filegeneration. main.tcl sources the user specific
files scriptgenwork/extrafiles.tcl and scriptgenwork/tools.tcl and then
starts database.tcl.

database.tcl
The procs lsearchmatch, listtrim, listinfile and rmvlinebreak are help methods
for commonly used functions.

parseenv is a proc for parsing the information contained in an environmental 
variable. When environmental variables are exported from the Makefile to tcl,
white space and "|" are changed to “:” in order to export them. parseenv splits
the information when “:” is encountered and puts the information back together
and returns it.

librarieslist and generatefilelists are procs used for scanning the filesystem
for available libs, dirs and files. librarieslist just creates the upper-most
layer of the filesystem. generatefilelists generates through scanning, a dict
for the filetree (libs, dirs and files) called filetree, a dict for information
regarding each lib/file called fileinfo. Files optionally added in 
$VHDLSYNFILES $VHDLOPTSYNFILES $VHDLSIMFILES $VERILOGOPTSYNFILES 
$VERILOGSYNFILES $VERILOGSIMFILES (in the specific designs Makefile) are then
added to the filetree/fileinfo dicts. generatefilelists also echoes settings
and each lib/dir scanned.

mergefiletrees and mergefileinfos are procs used for merging the filetree and
fileinfo dicts generated in genereatefilelists with the user specified 
extrafiletree and extrafileinfo in scriptgenwork/extrafiles.

The main portion of database.tcl sets the environmentals variables needed in 
the beginning, parses them and sets them as variables. These variables are used
in several proc’s in conjunction with the global command in order to fetch the
value.

The program then calls generatefilelists mergefiletrees and mergefileinfos to 
set the filetree and fileinfo dicts. 

In the last part of the program each tools creation file is sourced, that tcl
file is located in $GRLIB/bin/scriptgen/filebuild/$tool.tcl, if a user
specified tool is present it will be sourced from scriptgenwork/filebuild.

filebuild/$tool.tcl
The $tool.tcl file has the same basic structure. This works in such a way that
a string in a specific buildfile (e.g. ghdl_make.tcl) is available (name is the
outputfilename e.g. make_ghdl_contents) and appended by each method called
(create, append or eof).

Basic structure:
Sources each of the tools buildfiles
Calls the buildfiles create method
Scans libs, dirs and files. In libs it calls append_lib proc for some 
buildfiles, and in files it calls the append_file proc for some buildfiles 
After the scanning it calls eof proc of most buildfiles.

Makefile
The make scripts section in the Makefile calls dependencies.tcl and targets.tcl
in order to correctly set dependencies and targets depending on tools specified
in tools.tcl. The makefile then exports parsed environmental variables 
(whitespace and "|" is changed to ":") and starts main.tcl. The reason
environmental variables are exported instead of used as arguments is to easily
access them in tcl.
