#!/bin/bash

# Day 6 Exercise 1: sed Basics
# Learning: Stream editing and text transformation

echo "Day 6: sed Stream Editor Basics"
echo "==============================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Basic Substitution ==="
echo
echo "sed (stream editor) modifies text as it flows through"
echo "Basic syntax: sed 's/old/new/' filename"
echo

# Create sample file
cat > sample.txt << 'EOF'
Hello World
This is a test file
Linux is great
Windows is okay
Linux rocks
Testing 123
EOF

echo "Sample file created:"
cat sample.txt
echo

echo "Replace 'Linux' with 'Unix':"
echo "Command: sed 's/Linux/Unix/' sample.txt"
pause

sed 's/Linux/Unix/' sample.txt
echo

echo "=== PART 2: Global Replacement ==="
echo
echo "Replace ALL occurrences with 'g' flag:"
echo "Command: sed 's/is/was/g' sample.txt"
pause

sed 's/is/was/g' sample.txt
echo

echo "=== PART 3: Case-Insensitive Replacement ==="
echo
echo "Use 'I' flag for case-insensitive:"
echo "Command: sed 's/linux/UNIX/I' sample.txt"
pause

sed 's/linux/UNIX/I' sample.txt
echo

echo "=== PART 4: Line-Specific Operations ==="
echo
echo "Delete specific lines:"
echo "Command: sed '2d' sample.txt  # Delete line 2"
pause

sed '2d' sample.txt
echo

echo "Replace only on specific line:"
echo "Command: sed '3s/great/awesome/' sample.txt"
pause

sed '3s/great/awesome/' sample.txt
echo

echo "=== PART 5: Multiple Operations ==="
echo
echo "Chain multiple sed operations:"
echo "Command: sed 's/Linux/Unix/g; s/test/demo/g' sample.txt"
pause

sed 's/Linux/Unix/g; s/test/demo/g' sample.txt
echo

echo "=== PART 6: In-Place Editing ==="
echo
echo "Create backup and modify original file:"
echo "Command: sed -i.backup 's/World/Universe/' sample.txt"
pause

cp sample.txt sample_original.txt
sed -i.backup 's/World/Universe/' sample.txt
echo "Modified file:"
cat sample.txt
echo "Backup created:"
ls sample.txt.*
echo

echo "=== PART 7: Practical Examples ==="
echo

# Create config file example
cat > config.txt << 'EOF'
# Configuration file
server_name=localhost
port=8080
debug=true
max_connections=100
log_level=info
EOF

echo "Configuration file:"
cat config.txt
echo

echo "Change port from 8080 to 9090:"
echo "Command: sed 's/port=8080/port=9090/' config.txt"
pause

sed 's/port=8080/port=9090/' config.txt
echo

echo "Remove comment lines:"
echo "Command: sed '/^#/d' config.txt"
pause

sed '/^#/d' config.txt
echo

# Cleanup
rm -f sample.txt sample.txt.backup sample_original.txt config.txt

echo
echo "What you learned:"
echo "   - Basic substitution: s/old/new/"
echo "   - Global replacement: s/old/new/g"
echo "   - Case-insensitive: s/old/new/I"
echo "   - Line operations: 2d, 3s/old/new/"
echo "   - In-place editing: sed -i"
echo "   - Delete patterns: /pattern/d"
echo
echo "Next: Learn awk for field processing"
