#!/bin/sh
bindir=$(pwd)
cd /Users/BrightLand/Learn_MetalAPI/GRAPHICS API/openGL/tutorial13_normal_mapping/
export 

if test "x$1" = "x--debugger"; then
	shift
	if test "x" = "xYES"; then
		echo "r  " > $bindir/gdbscript
		echo "bt" >> $bindir/gdbscript
		GDB_COMMAND-NOTFOUND -batch -command=$bindir/gdbscript  /Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/MinSizeRel/tutorial13_normal_mapping 
	else
		"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/MinSizeRel/tutorial13_normal_mapping"  
	fi
else
	"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/MinSizeRel/tutorial13_normal_mapping"  
fi
