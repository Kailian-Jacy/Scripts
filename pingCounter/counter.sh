#!/bin/bash

# Input file
input_file="/Users/kailianjacy/ReferenceVPSMonitor.log"

# Output CSV file
output_file="vps.logging.csv"

# Create or clear the output CSV file
> "$output_file"

# Iterate through each line in the input file
while IFS= read -r line; do
  # Extract timestamp, has response, and latency from the line
  timestamp=$(echo "$line" | awk '{print $1, $2}')
  has_response=$(echo "$line" | grep -q "tcp response" && echo "yes" || echo "no")
  if [[ $has_response == "yes" ]]; then 
  	latency=$(echo "$line" | awk '{print $10}')
  	echo "$timestamp,$has_response,$latency" >> "$output_file"
  else
  	echo "$timestamp,$has_response," >> "$output_file"
  fi

  # Append the extracted values to the CSV file
  echo line disposed..
done < "$input_file"

echo "CSV file '$output_file' created with timestamp, has response, and latency."
