#!/bin/bash

# Loop through all PNG files in the directory
for file in *.png; do
    # Get the base filename (without extension)
    base=$(basename "$file" .png)

    # Print the file being processed
    echo "Processing $file"

    # Run png2snes to generate binaries and capture any error messages
    png2snes --tilesize=16x16 --bitplanes=4 --output="$base" --binary "$file" 2>&1 | tee -a png2snes.log

    # Check if png2snes ran successfully
    if [ $? -ne 0 ]; then
        echo "Error processing $file" | tee -a error.log
    fi

done

