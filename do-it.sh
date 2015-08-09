#!/bin/bash

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
    echo $i
    geeknote show $i > logs/$i.md
    echo "One down."
done

