#!/bin/sh
bindir=$(pwd)
cd /Users/BrightLand/Learn_MetalAPI/GRAPHICS API/openGL/tutorial18_billboards_and_particles/
export 

if test "x$1" = "x--debugger"; then
	shift
	if test "x" = "xYES"; then
		echo "r  " > $bindir/gdbscript
		echo "bt" >> $bindir/gdbscript
		GDB_COMMAND-NOTFOUND -batch -command=$bindir/gdbscript  /Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/Debug/tutorial18_billboards 
	else
		"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/Debug/tutorial18_billboards"  
	fi
else
	"/Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/Debug/tutorial18_billboards"  
fi