#!/bin/sh
bindir=$(pwd)
cd /Users/BrightLand/Learn_MetalAPI/GRAPHICS API/openGL/tutorial03_matrices/
export 

if test "x$1" = "x--debugger"; then
	shift
	if test "x" = "xYES"; then
		echo "r  " > $bindir/gdbscript
		echo "bt" >> $bindir/gdbscript
		GDB_COMMAND-NOTFOUND -batch -command=$bindir/gdbscript  /Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/cmake-build-debug/tutorial03_matrices 
	else
		"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/cmake-build-debug/tutorial03_matrices"  
	fi
else
	"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/cmake-build-debug/tutorial03_matrices"  
fi
