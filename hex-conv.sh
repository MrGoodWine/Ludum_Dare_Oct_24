#!/bin/bash

# Input file (bg.asm)
input_file="Tilemaps/bg.asm"

# Output file (bg.hex)
output_file="Tilemaps/bg.hex"

# Create or empty the output file
: > "$output_file"

# Initialize variables for tracking progress
line_number=0
total_bytes=0

# Function to print progress
print_progress() {
  echo -ne "Processing line $line_number, total bytes processed: $total_bytes\r"
}

# Process the input file line by line
while read -r line; do
  # Increase line number counter
  line_number=$((line_number + 1))

  # Only process lines that contain `db` (data bytes)
  if [[ "$line" == *"db"* ]]; then
    # Extract the hex values by removing `db` and trimming spaces/commas/dollar signs
    hex_values=$(echo "$line" | sed 's/.*db //;s/[ ,\$]//g')

    # Convert each byte pair to raw hex and append to output file
    for ((i=0; i<${#hex_values}; i+=2)); do
      byte="${hex_values:i:2}"

      # Write the hex byte directly to the output file
      echo -n -e "\x$byte" >> "$output_file"

      # Increment byte count
      total_bytes=$((total_bytes + 1))
    done

    # Print progress after processing each line
    print_progress
  fi
done < "$input_file"

echo -e "\nConversion completed: $output_file"
