#!/bin/bash

# Day 1 Exercise: Basic Commands
# Practice essential Linux commands for cybersecurity

#The echo command is used to display messages in the terminal
echo "=== Day 1: Basic Commands Exercise ==="
echo "Follow along and practice each command with me"
echo # This line adds a new line for better readability on the terminal

# 1. NAVIGATION COMMANDS
echo "1. Navigation Commands"
echo "Current directory:"
pwd # This command prints the current working directory

# The -e option allows for interpretation of escape sequences like \n and \t
echo -e "\nList files in current directory:"
ls # This command lists the files in the current working directory

echo -e "\nList files with details:"
ls -la # This command lists files with detailed information including permissions, owner, size, and modification date

echo -e "\nList files in /etc (important config directory):"
ls /etc | head -10 # The pipe (|) operator sends output from ls to head command

# 2. FILE OPERATIONS
echo -e "\n2. File Operations"

# Create a test directory
echo "Creating test directory..."
mkdir -p test_dir

# Navigate to test directory
cd test_dir
echo "Current directory: $(pwd)"

# Create test files
echo "Creating test files..."
touch file1.txt file2.txt secret.log # touch creates empty files with current timestamp
echo "Test content" > file1.txt
echo "Confidential data" > secret.log

# Copy files
echo "Copying files..."
cp file1.txt file1_backup.txt

# Move/rename files
echo "Renaming file..."
mv file2.txt renamed_file.txt

# Display file contents
echo -e "\nFile contents:"
cat file1.txt

# 3. SYSTEM INFORMATION
echo -e "\n3. System Information Commands"
echo "Current user: $(whoami)"
echo "System date: $(date)"
echo "System uptime:"
uptime

# 4. MANUAL AND HELP
echo -e "\n4. Getting Help"
echo "To get help for any command, use 'man <command>'"
echo "Example: man ls"
echo "Or use --help flag: ls --help"

# 5. CYBERSECURITY RELEVANT COMMANDS
echo -e "\n5. Cybersecurity Context"
echo "Important directories for security:"
echo "- /etc: System configuration files"
echo "- /var/log: System logs"
echo "- /home: User directories"
echo "- /tmp: Temporary files"

echo -e "\nChecking important log files:"
if [ -f /var/log/auth.log ]; then
    echo "Authentication log exists: /var/log/auth.log"
    echo "Last 3 login attempts:"
    tail -3 /var/log/auth.log 2>/dev/null || echo "Permission denied (normal for regular users)"
fi

# Clean up
cd ..
echo -e "\nCleaning up test directory..."
rm -rf test_dir

echo -e "\n=== Exercise Complete ==="
echo "Practice these commands until they become second nature!"
# Added comment explaining the pipe operator
