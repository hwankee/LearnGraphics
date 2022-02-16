#!/bin/sh
set -e
if test "$CONFIGURATION" = "Debug"; then :
  cd "/Users/BrightLand/Learn_MetalAPI/GRAPHICS API/openGL/bin"
  make -f /Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/CMakeScripts/ReRunCMake.make
fi
if test "$CONFIGURATION" = "Release"; then :
  cd "/Users/BrightLand/Learn_MetalAPI/GRAPHICS API/openGL/bin"
  make -f /Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/CMakeScripts/ReRunCMake.make
fi
if test "$CONFIGURATION" = "MinSizeRel"; then :
  cd "/Users/BrightLand/Learn_MetalAPI/GRAPHICS API/openGL/bin"
  make -f /Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/CMakeScripts/ReRunCMake.make
fi
if test "$CONFIGURATION" = "RelWithDebInfo"; then :
  cd "/Users/BrightLand/Learn_MetalAPI/GRAPHICS API/openGL/bin"
  make -f /Users/BrightLand/Learn_MetalAPI/GRAPHICS\ API/openGL/bin/CMakeScripts/ReRunCMake.make
fi

