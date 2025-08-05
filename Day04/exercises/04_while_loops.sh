#!/bin/bash

# Day 4 Exercise 2: While and Until Loops
# Learning: Conditional loops for dynamic iteration

echo "While and Until Loop Examples"
echo "============================="

# While loop - continues while condition is true
echo "While loop example - counting to 5:"
counter=1
while [ $counter -le 5 ]; do
    echo "Count: $counter"
    counter=$((counter + 1))
done

echo
echo "While loop - reading user input:"
echo "Enter 'quit' to stop:"
while true; do
    read -p "Enter command (or 'quit'): " input
    if [ "$input" = "quit" ]; then
        echo "Goodbye!"
        break
    fi
    echo "You entered: $input"
done

echo
echo "Until loop - continues until condition becomes true:"
attempts=0
until [ $attempts -eq 3 ]; do
    attempts=$((attempts + 1))
    echo "Attempt $attempts"
done

echo
echo "Practical example - monitoring a file:"
echo "Creating test file..."
echo "initial content" > monitor_test.txt

echo "Monitoring file size (will stop when it grows)..."
initial_size=$(wc -c < monitor_test.txt)
current_size=$initial_size

# Simulate file growth in background
(sleep 2; echo "new line" >> monitor_test.txt) &

while [ $current_size -eq $initial_size ]; do
    current_size=$(wc -c < monitor_test.txt)
    echo "File size: $current_size bytes"
    sleep 1
done

echo "File has grown! Final size: $current_size bytes"
rm -f monitor_test.txt

echo
echo "Practice: Create loops for system monitoring or file processing"
