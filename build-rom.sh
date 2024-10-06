#!/bin/bash

# Compile the assembly code
wla-65816 -o Main.o Main.asm 

# Link the compiled object file into a ROM
wlalink -v temp.prj 'Super Bug Bash.smc'

# Check if the -sd flag is passed
if [[ "$1" == "-sd" ]]; then
    cp 'Super Bug Bash.smc' /media/fufroom/Generic/SAG\ SNES\ Rom\ Pack/
    echo "ROM Built and added to SD Card"
else
    echo "ROM Built. Use -sd flag to copy to the SD card."
fi
