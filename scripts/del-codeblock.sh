#!/bin/bash

# Define the file to be processed
FILE="README.md"

# if found line, remove table of size 17 rows

# Use sed to remove the code block backticks
sed -i '' '/^```md$/d; /^```$/d' "$FILE"

echo "Removed code block formatting from $FILE."
