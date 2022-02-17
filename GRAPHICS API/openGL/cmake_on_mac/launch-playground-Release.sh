#!/bin/sh
bindir=$(pwd)
cd /Users/BrightLand/Learn_MetalAPI/GRAPHICS API/openGL/playground/
export 

if test "x$1" = "x--debugger"; then
	shift
	if test "x" = "xYES"; then
		echo "r  " > $bindir/gdbscript
		echo "bt" >> $bindir/gdbscript
		GDB_COMMAND-NOTFOUND -batch -command=$bindir/gdbscript  /Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/cmake_on_mac/Release/playground 
	else
		"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/cmake_on_mac/Release/playground"  
	fi
else
	"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/cmake_on_mac/Release/playground"  
fi
