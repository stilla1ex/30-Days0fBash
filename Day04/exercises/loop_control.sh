#!/bin/bash

# Day 4 Exercise 3: Loop Control
# Learning: Break and continue statements

echo "Loop Control Examples"
echo "===================="

echo "Example 1: Using 'break' to exit early"
for i in {1..10}; do
    if [ $i -eq 6 ]; then
        echo "Breaking at $i"
        break
    fi
    echo "Number: $i"
done

echo
echo "Example 2: Using 'continue' to skip iterations"
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        continue  # Skip even numbers
    fi
    echo "Odd number: $i"
done

echo
echo "Example 3: Processing files with error handling"
echo "Creating test files..."
touch file1.txt file2.txt file3.txt
chmod 000 file2.txt  # Make file2 unreadable

for file in file*.txt; do
    echo "Processing $file..."
    
    if [ ! -r "$file" ]; then
        echo "Cannot read $file, skipping..."
        continue
    fi
    
    if [ "$file" = "file3.txt" ]; then
        echo "Critical file reached, stopping processing"
        break
    fi
    
    echo "Successfully processed $file"
done

# Clean up
chmod 644 file2.txt 2>/dev/null
rm -f file*.txt

echo
echo "Example 4: Menu system with loop control"
while true; do
    echo
    echo "Menu Options:"
    echo "1) Show date"
    echo "2) Show users"  
    echo "3) Exit"
    read -p "Choose option (1-3): " choice
    
    case $choice in
        1)
            echo "Current date: $(date)"
            ;;
        2)
            echo "Current user: $USER"
            ;;
        3)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option, please try again"
            continue
            ;;
    esac
done

echo
echo "Practice: Build error-handling loops for file processing"
