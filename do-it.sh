#!/bin/bash

# VARS
max=10

# SETUP / BOOTSTRAP / PREPARE
mkdir -p logs

# Find all notes to dump
geeknote find --count $max

for i in {1..10}; do
    echo $i
    geeknote show $i > logs/$i.md
    echo "One down."
done

