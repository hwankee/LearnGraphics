#!/bin/sh
bindir=$(pwd)
cd /Users/BrightLand/Learn_MetalAPI/GRAPHICS API/openGL/tutorial09_vbo_indexing/
export 

if test "x$1" = "x--debugger"; then
	shift
	if test "x" = "xYES"; then
		echo "r  " > $bindir/gdbscript
		echo "bt" >> $bindir/gdbscript
		GDB_COMMAND-NOTFOUND -batch -command=$bindir/gdbscript  /Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/MinSizeRel/tutorial09_vbo_indexing 
	else
		"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/MinSizeRel/tutorial09_vbo_indexing"  
	fi
else
	"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/MinSizeRel/tutorial09_vbo_indexing"  
fi
