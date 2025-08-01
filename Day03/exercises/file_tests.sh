#!/bin/bash

# Day 3 Exercise 2: File and Directory Tests
# Learning: Test file existence, permissions, and types

echo "File and Directory Testing"
echo "=========================="

# Test file existence
if [ -f "test.txt" ]; then
    echo "test.txt exists as a regular file"
else
    echo "test.txt does not exist as a regular file"
fi

# Test directory existence
if [ -d "/tmp" ]; then
    echo "/tmp exists as a directory"
else
    echo "/tmp does not exist as a directory"
fi

# Test file permissions
if [ -r "/etc/passwd" ]; then
    echo "/etc/passwd is readable"
else
    echo "/etc/passwd is not readable"
fi

# Test if file is executable
if [ -x "/bin/ls" ]; then
    echo "/bin/ls is executable"
else
    echo "/bin/ls is not executable"
fi

# Check if file is empty
echo "Creating empty test file..."
touch empty_test.txt

if [ -s "empty_test.txt" ]; then
    echo "empty_test.txt has content"
else
    echo "empty_test.txt is empty"
fi

# Add content and test again
echo "Adding content to file..."
echo "Hello" > empty_test.txt

if [ -s "empty_test.txt" ]; then
    echo "empty_test.txt now has content"
else
    echo "empty_test.txt is still empty"
fi

# Clean up
rm -f empty_test.txt

echo
echo "Practice:"
echo "1. Test if your home directory exists"
echo "2. Check if a script file is executable"
echo "3. Verify if a log file has content"
