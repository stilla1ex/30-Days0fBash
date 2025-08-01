#!/bin/bash

# Day 1 Exercise: Command Practice
# Interactive practice session for basic commands

echo "=== Day 1: Command Practice Session ==="
echo "Let's practice basic commands step by step!"
echo

# Function to wait for user
wait_for_user() {
    echo
    read -p "Press Enter to continue..." 
    echo
}

echo "🎯 EXERCISE 1: Navigation Commands"
echo "Try these commands one by one:"
echo
echo "1. pwd       (show current directory)"
echo "2. ls        (list files)"
echo "3. ls -la    (detailed list)"
echo "4. cd /tmp   (change to tmp directory)"
echo "5. pwd       (check new location)"
echo "6. cd -      (go back to previous directory)"

wait_for_user

echo "🎯 EXERCISE 2: File Operations"
echo "Let's create and work with files:"
echo
echo "1. mkdir practice_folder"
echo "2. cd practice_folder"
echo "3. touch test_file.txt"
echo "4. echo 'Hello World' > test_file.txt"
echo "5. cat test_file.txt"
echo "6. cp test_file.txt backup.txt"
echo "7. ls -la"

wait_for_user

echo "🎯 EXERCISE 3: Information Commands"
echo "Learn about your system:"
echo
echo "1. whoami    (current user)"
echo "2. date      (current date/time)"
echo "3. uname -a  (system information)"
echo "4. which ls  (find command location)"
echo "5. man ls    (manual for ls command - press 'q' to quit)"

wait_for_user

echo "🎯 EXERCISE 4: Basic Text Operations"
echo "Working with file content:"
echo
echo "1. echo 'Line 1' > sample.txt"
echo "2. echo 'Line 2' >> sample.txt"
echo "3. cat sample.txt"
echo "4. wc -l sample.txt  (count lines)"
echo "5. grep 'Line' sample.txt"

wait_for_user

echo "✅ Practice Complete!"
echo "💡 Remember: Practice these commands until they become natural!"
echo "🔄 You can run this script again anytime to practice."
