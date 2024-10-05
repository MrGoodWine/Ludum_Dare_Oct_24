#!/bin/bash

# Loop through all PNG files in the directory
for file in *.png; do
    # Get the base filename (without extension)
    base=$(basename "$file" .png)

    # Run png2snes to generate binaries
    png2snes --tilesize=16x16 --bitplanes=4 --output="$base" --binary "$file"

done
