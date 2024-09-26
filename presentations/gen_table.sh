#!/bin/bash

# Set the directory containing all the folders
BASE_DIR="."  # Update this path to your actual directory
OUTPUT_CSV="metadata.csv"

# Create CSV header
echo "Title,Speakers,Date,Location,Event,Slides,Recording" > $OUTPUT_CSV

# Traverse through each folder
for dir in "$BASE_DIR"/*; do
  if [ -d "$dir" ]; then
    # Check if metadata.yml exists in the folder
    if [ -f "$dir/metadata.yml" ]; then
      # Read the metadata.yml file and extract the values
      TITLE=$(grep '^title:' "$dir/metadata.yml" | sed 's/title: "\(.*\)"/\1/')
      SPEAKERS=$(grep '^  -' "$dir/metadata.yml" | sed 's/  - "\(.*\)"/\1/' | paste -sd "," -)  # Join multiple speakers with commas
      DATE=$(grep '^date:' "$dir/metadata.yml" | sed 's/date: "\(.*\)"/\1/')
      LOCATION=$(grep '^location:' "$dir/metadata.yml" | sed 's/location: "\(.*\)"/\1/')
      EVENT=$(grep '^event:' "$dir/metadata.yml" | sed 's/event: "\(.*\)"/\1/')
      SLIDES=$(grep '^slides:' "$dir/metadata.yml" | sed 's/slides: "\(.*\)"/\1/')
      RECORDING=$(grep '^recording:' "$dir/metadata.yml" | sed 's/recording: "\(.*\)"/\1/')

      # Append the row to the CSV file
      echo "\"$TITLE\",\"$SPEAKERS\",\"$DATE\",\"$LOCATION\",\"$EVENT\",\"$SLIDES\",\"$RECORDING\"" >> $OUTPUT_CSV
    fi
  fi
done
