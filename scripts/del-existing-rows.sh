#!/bin/bash

ROWS=$1
FILE=$2
NUM_LINES=$(($ROWS - 1))
HEADER1="|Date       |Title                                                                           |Speakers |Presentation                                                                                                       |Recording                                                 |"

if grep -qF "$HEADER1" "$FILE"; then
  echo "Old table found, deleting."
  # Use sed to find and delete the two header lines and the next $ROWS lines
  sed -i '' "/$HEADER1/{N;N;$(for i in $(seq 1 $NUM_LINES); do echo -n 'N;'; done)d;}" "$FILE"
fi

