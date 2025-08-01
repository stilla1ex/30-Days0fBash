#!/bin/bash

# Day 5 Exercise 1: Basic Functions
# Learning: Function creation and usage

echo "Basic Functions in Bash"
echo "======================"

# Function definition - simple greeting
greet() {
    echo "Hello from the greet function!"
}

# Function definition - with local logic
show_date() {
    echo "Today is: $(date +%Y-%m-%d)"
    echo "Time is: $(date +%H:%M:%S)"
}

# Function definition - system info
system_info() {
    echo "System Information:"
    echo "  Hostname: $(hostname)"
    echo "  User: $USER"
    echo "  Home: $HOME"
    echo "  Shell: $BASH"
}

echo "=== Function Calls ==="
echo

echo "Calling greet function:"
greet

echo
echo "Calling show_date function:"
show_date

echo
echo "Calling system_info function:"
system_info

echo
echo "=== Function with Return Values ==="

# Function that returns a value
check_file_exists() {
    if [ -f "$1" ]; then
        return 0  # Success - file exists
    else
        return 1  # Failure - file doesn't exist
    fi
}

echo
echo "Testing file existence:"
test_file="/etc/passwd"
if check_file_exists "$test_file"; then
    echo "File $test_file exists"
else
    echo "File $test_file does not exist"
fi

test_file="nonexistent_file.txt"
if check_file_exists "$test_file"; then
    echo "File $test_file exists"
else
    echo "File $test_file does not exist"
fi

echo
echo "=== Function with Output Capture ==="

# Function that outputs a value to be captured
get_random_number() {
    echo $((RANDOM % 100 + 1))
}

echo "Getting random number from function:"
random_num=$(get_random_number)
echo "Random number: $random_num"

echo
echo "=== Multiple Function Calls ==="
echo "Calling greet 3 times:"
for i in {1..3}; do
    echo "Call $i:"
    greet
done

echo
echo "What you learned:"
echo "  • Functions group related commands"
echo "  • Call functions by name: function_name"
echo "  • Functions can return exit codes (0-255)"
echo "  • Capture function output with \$(function_name)"
echo "  • Functions make code reusable and organized"
echo
echo "Next: Learn about function parameters"
