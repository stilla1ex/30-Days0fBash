#!/bin/bash

# Day 1 Exercise: Basic Error Handling
# Understanding when commands succeed or fail

echo "=== Day 1: Understanding Command Success and Failure ==="
echo

echo "GOAL: Let's learn about command success and failure:"
echo

# Example 1: Successful command
echo "1. Running a successful command:"
echo "Command: ls"
ls
echo "Exit code: $?"  # 0 means success
echo

# Example 2: Failed command  
echo "2. Running a command that fails:"
echo "Command: ls /nonexistent_directory"
ls /nonexistent_directory 2>/dev/null  # Hide error message for clarity
echo "Exit code: $?"  # Non-zero means failure
echo

# Example 3: Checking if command exists
echo "3. Checking if a command exists:"
echo "Command: which nmap"
if which nmap >/dev/null 2>&1; then
    echo "[OK] nmap is installed"
else
    echo "❌ nmap is not installed or not in PATH"
fi
echo

# Example 4: Checking file existence
echo "4. Checking if a file exists:"
test_file="/etc/passwd"
echo "Checking if $test_file exists..."
if [ -f "$test_file" ]; then
    echo "[OK] File exists"
    echo "File size: $(wc -l < $test_file) lines"
else
    echo "❌ File does not exist"
fi
echo

# Example 5: Basic conditional command execution
echo "5. Conditional command execution:"
echo "This will create a directory only if it doesn't exist:"
echo "Command: mkdir -p test_directory"
mkdir -p test_directory && echo "[OK] Directory created or already exists"
echo

echo "LEARNED: Key Learning Points:"
echo "• Exit code 0 = success"
echo "• Exit code non-zero = failure" 
echo "• Use \$? to check the last command's exit code"
echo "• Always check if commands succeed in real scripts"
echo "• Use && to run commands only if previous one succeeds"
