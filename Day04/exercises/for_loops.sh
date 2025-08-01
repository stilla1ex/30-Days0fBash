#!/bin/bash

# Day 4 Exercise 1: For Loops
# Learning: Iterate through lists and ranges

echo "For Loop Examples"
echo "================="

# Loop through numbers
echo "Counting 1 to 5:"
for i in {1..5}; do
    echo "Count: $i"
done

echo
echo "Counting by 2s from 0 to 10:"
for i in {0..10..2}; do
    echo "Even number: $i"
done

echo
echo "Loop through a list of items:"
fruits="apple banana orange grape"
for fruit in $fruits; do
    echo "I like $fruit"
done

echo
echo "Process files in current directory:"
for file in *.md; do
    if [ -f "$file" ]; then
        echo "Found markdown file: $file"
    fi
done

echo
echo "C-style for loop:"
for ((i=1; i<=3; i++)); do
    echo "Iteration $i"
done

echo
echo "Practice: Create loops to process log files or system information"
