#!/bin/bash

# Day 6 Exercise 1: sed Basics
# Learning: Stream editing for text transformation

echo "Day 6: sed Stream Editor Basics"
echo "==============================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

# Create sample data file for practice
cat > sample_data.txt << 'EOF'
apple,red,sweet
banana,yellow,sweet
orange,orange,citrus
grape,purple,sweet
lemon,yellow,sour
lime,green,sour
EOF

echo "Sample data created in sample_data.txt:"
cat sample_data.txt
echo

echo "=== PART 1: Basic Substitution ==="
echo

echo "Replace 'sweet' with 'delicious':"
echo "Command: sed 's/sweet/delicious/' sample_data.txt"
pause

sed 's/sweet/delicious/' sample_data.txt
echo

echo "Replace ALL occurrences (global):"
echo "Command: sed 's/sweet/delicious/g' sample_data.txt"
pause

sed 's/sweet/delicious/g' sample_data.txt
echo

echo "=== PART 2: Line-based Operations ==="
echo

echo "Delete lines containing 'yellow':"
echo "Command: sed '/yellow/d' sample_data.txt"
pause

sed '/yellow/d' sample_data.txt
echo

echo "Print only lines containing 'sweet':"
echo "Command: sed -n '/sweet/p' sample_data.txt"
pause

sed -n '/sweet/p' sample_data.txt
echo

echo "=== PART 3: Line Numbers ==="
echo

echo "Delete the first line:"
echo "Command: sed '1d' sample_data.txt"
pause

sed '1d' sample_data.txt
echo

echo "Print lines 2-4:"
echo "Command: sed -n '2,4p' sample_data.txt"
pause

sed -n '2,4p' sample_data.txt
echo

echo "=== PART 4: Field Manipulation ==="
echo

echo "Extract first field (fruit names):"
echo "Command: sed 's/,.*$//' sample_data.txt"
pause

sed 's/,.*$//' sample_data.txt
echo

echo "Extract last field (taste):"
echo "Command: sed 's/^.*,//' sample_data.txt"
pause

sed 's/^.*,//' sample_data.txt
echo

echo "=== PART 5: File Modification ==="
echo

echo "Save changes to new file:"
echo "Command: sed 's/sweet/delicious/g' sample_data.txt > modified_data.txt"
pause

sed 's/sweet/delicious/g' sample_data.txt > modified_data.txt
echo "Modified data saved to modified_data.txt:"
cat modified_data.txt
echo

echo "Modify file in-place (backup created):"
echo "Command: sed -i.bak 's/citrus/tangy/' sample_data.txt"
pause

sed -i.bak 's/citrus/tangy/' sample_data.txt
echo "Original file modified, backup saved as sample_data.txt.bak"
echo "Modified file:"
cat sample_data.txt
echo

# Clean up
rm -f sample_data.txt modified_data.txt sample_data.txt.bak

echo "What you learned:"
echo "   - s/old/new/ for substitution"
echo "   - /pattern/d to delete lines"
echo "   - -n and p to print specific lines"
echo "   - Line numbers for targeting specific lines"
echo "   - Regular expressions for complex patterns"
echo "   - -i flag for in-place editing"
echo
echo "Next: Learn awk for field processing"
