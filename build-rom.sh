#!/bin/bash

# Clean up previous build artifacts
rm -rf Main.o
rm -rf Main.obj
rm -rf Main.smc
rm -rf 'Super Bug Bash.smc'

echo  "be sure sprites are updated"
cd Pictures/
./png2snes.sh
cd ../

# Create the temp.prj file
echo "[objects]" > temp.prj
echo "Main.o" >> temp.prj

# Compile the assembly code
wla-65816 -o Main.o Main.asm 

# Link the compiled object file into a ROM
wlalink -v temp.prj 'Super Bug Bash.smc'

# Check for flags
for arg in "$@"; do
  case $arg in
    -sd)
      # Copy to SD card
      cp 'Super Bug Bash.smc' /media/fufroom/Generic/SAG\ SNES\ Rom\ Pack/
      echo "ROM Built and added to SD Card"
      ;;
    -o)
      # Open ROM in Mesen
      ~/src/Mesen 'Super Bug Bash.smc' &
      echo "ROM opened in Mesen"
      ;;
    *)
      echo "ROM Built. Use -sd flag to copy to the SD card or -o to open in Mesen."
      ;;
  esac
done
