#!/bin/bash

# TODO: Detect when rate limit is hit

# VARS
# Change to your wishes
MAX=1000

# SETUP / BOOTSTRAP / PREPARE
mkdir -p logs

# Find all notes to dump
geeknote find --count $MAX

START=1
END=$MAX
for ((i=$START; i<=$END; i++)); do
    echo "Beginning to dump note number \#$i..."   # ...with date $date
    file=logs/$i.md    # Replace index with date and timestamp, or at the very least date
    geeknote show $i > $file
    echo "Dumped note with filename $file, continuing..."
done

