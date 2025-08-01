#!/bin/bash

# Day 7 Exercise 1: Basic Arrays
# Learning: Indexed array creation and manipulation

echo "Day 7: Basic Arrays (Indexed)"
echo "============================="

pause() {
    echo
    read -p "Try this, then press Enter to continue..."
    echo
}

echo "=== PART 1: Creating Arrays ==="
echo
echo "Arrays store multiple values in a single variable"
echo "Syntax: array=(value1 value2 value3)"
echo

echo "Create an array of fruits:"
echo "Command: fruits=(apple banana orange grape)"
pause

fruits=(apple banana orange grape)
echo "Array created: ${fruits[@]}"
echo

echo "Create an array of numbers:"
echo "Command: numbers=(1 2 3 4 5)"
pause

numbers=(1 2 3 4 5)
echo "Numbers array: ${numbers[@]}"
echo

echo "=== PART 2: Accessing Array Elements ==="
echo

echo "Access first element (index 0):"
echo "Command: echo \${fruits[0]}"
pause

echo "First fruit: ${fruits[0]}"
echo

echo "Access third element (index 2):"
echo "Command: echo \${fruits[2]}"
pause

echo "Third fruit: ${fruits[2]}"
echo

echo "Access all elements:"
echo "Command: echo \${fruits[@]}"
pause

echo "All fruits: ${fruits[@]}"
echo

echo "Get array length:"
echo "Command: echo \${#fruits[@]}"
pause

echo "Number of fruits: ${#fruits[@]}"
echo

echo "=== PART 3: Adding Elements ==="
echo

echo "Add element at specific index:"
echo "Command: fruits[4]=mango"
pause

fruits[4]=mango
echo "Updated fruits: ${fruits[@]}"
echo

echo "Append to end of array:"
echo "Command: fruits+=(kiwi pineapple)"
pause

fruits+=(kiwi pineapple)
echo "Fruits after append: ${fruits[@]}"
echo "New length: ${#fruits[@]}"
echo

echo "=== PART 4: Array Indices ==="
echo

echo "Get all indices:"
echo "Command: echo \${!fruits[@]}"
pause

echo "Array indices: ${!fruits[@]}"
echo

echo "Create sparse array (gaps in indices):"
echo "Command: sparse[2]=second; sparse[5]=fifth; sparse[10]=tenth"
pause

sparse[2]=second
sparse[5]=fifth  
sparse[10]=tenth

echo "Sparse array values: ${sparse[@]}"
echo "Sparse array indices: ${!sparse[@]}"
echo

echo "=== PART 5: Looping Through Arrays ==="
echo

echo "Loop through values:"
echo "for fruit in \"\${fruits[@]}\"; do"
echo "    echo \"I like \$fruit\""
echo "done"
pause

for fruit in "${fruits[@]}"; do
    echo "I like $fruit"
done
echo

echo "Loop through indices and values:"
echo "for i in \"\${!fruits[@]}\"; do"
echo "    echo \"Index \$i: \${fruits[i]}\""
echo "done"
pause

for i in "${!fruits[@]}"; do
    echo "Index $i: ${fruits[i]}"
done
echo

echo "=== PART 6: Array Operations ==="
echo

echo "Copy array:"
echo "Command: backup_fruits=(\"\${fruits[@]}\")"
pause

backup_fruits=("${fruits[@]}")
echo "Backup array: ${backup_fruits[@]}"
echo

echo "Sort array elements:"
echo "Command: IFS=\$'\\n' sorted=(\$(sort <<<\"\${fruits[*]}\"))"
pause

IFS=$'\n' sorted=($(sort <<<"${fruits[*]}"))
echo "Sorted fruits: ${sorted[@]}"
echo

echo "Remove element by index:"
echo "Command: unset fruits[2]"
pause

unset fruits[2]
echo "After removing index 2: ${fruits[@]}"
echo "Indices now: ${!fruits[@]}"
echo

echo "=== PART 7: Practical Examples ==="
echo

echo "System information array:"
sys_info=(
    "Hostname: $(hostname)"
    "User: $(whoami)" 
    "Date: $(date)"
    "Uptime: $(uptime -p)"
    "Disk: $(df -h / | tail -1 | awk '{print $5}')"
)

echo "System information:"
for info in "${sys_info[@]}"; do
    echo "  $info"
done
echo

echo "File extension counter:"
files=(*.sh *.txt *.md *.log)
declare -A ext_count

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        ext="${file##*.}"
        ((ext_count[$ext]++))
    fi
done

echo "File extensions found:"
for ext in "${!ext_count[@]}"; do
    echo "  .$ext files: ${ext_count[$ext]}"
done
echo

echo "=== PART 8: Command Line Arguments Array ==="
echo

echo "Script arguments are stored in arrays:"
echo "\$@ = all arguments as array"
echo "\$* = all arguments as single string"
echo "\$# = number of arguments"
echo

# Simulate script arguments
set -- arg1 arg2 arg3 "arg with spaces"

echo "Simulated arguments: $@"
echo "Number of arguments: $#"
echo

echo "Loop through script arguments:"
echo "for arg in \"\$@\"; do"
echo "    echo \"Argument: \$arg\""
echo "done"
pause

for arg in "$@"; do
    echo "Argument: $arg"
done
echo

echo "Access by position:"
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
echo

echo
echo "What you learned:"
echo "   - Array creation: array=(val1 val2 val3)"
echo "   - Access elements: \${array[index]}"
echo "   - All elements: \${array[@]}"
echo "   - Array length: \${#array[@]}"
echo "   - Array indices: \${!array[@]}"
echo "   - Add elements: array+=(new_elements)"
echo "   - Loop through arrays"
echo "   - Remove elements: unset array[index]"
echo
echo "Next: Learn associative arrays (key-value pairs)"
