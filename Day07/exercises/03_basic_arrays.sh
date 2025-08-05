#!/bin/bash

# Day 7 Exercise 1: Basic Arrays
# Learning: Indexed array fundamentals

echo "Day 7: Basic Arrays (Indexed)"
echo "============================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Creating Arrays ==="
echo

echo "Create an array with initial values:"
echo "Command: fruits=(\"apple\" \"banana\" \"orange\" \"grape\")"
pause

fruits=("apple" "banana" "orange" "grape")
echo "Array created: fruits"
echo

echo "Create empty array and add elements:"
echo "Command: colors=(); colors[0]=\"red\"; colors[1]=\"blue\""
pause

colors=()
colors[0]="red"
colors[1]="blue"
colors[2]="green"
echo "Colors array created"
echo

echo "=== PART 2: Accessing Array Elements ==="
echo

echo "Access first element (index 0):"
echo "Command: echo \"\${fruits[0]}\""
pause

echo "First fruit: ${fruits[0]}"
echo

echo "Access specific elements:"
echo "Command: echo \"\${fruits[1]}\" \"\${fruits[3]}\""
pause

echo "Second and fourth fruits: ${fruits[1]} ${fruits[3]}"
echo

echo "Access all elements:"
echo "Command: echo \"\${fruits[@]}\""
pause

echo "All fruits: ${fruits[@]}"
echo

echo "=== PART 3: Array Properties ==="
echo

echo "Get array length:"
echo "Command: echo \"\${#fruits[@]}\""
pause

echo "Number of fruits: ${#fruits[@]}"
echo

echo "Get indices:"
echo "Command: echo \"\${!fruits[@]}\""
pause

echo "Array indices: ${!fruits[@]}"
echo

echo "Get length of specific element:"
echo "Command: echo \"\${#fruits[1]}\""
pause

echo "Length of '${fruits[1]}': ${#fruits[1]} characters"
echo

echo "=== PART 4: Adding and Removing Elements ==="
echo

echo "Add element to end of array:"
echo "Command: fruits+=(\"mango\")"
pause

fruits+=("mango")
echo "Updated fruits: ${fruits[@]}"
echo "Array length: ${#fruits[@]}"
echo

echo "Add multiple elements:"
echo "Command: fruits+=(\"kiwi\" \"pineapple\")"
pause

fruits+=("kiwi" "pineapple")
echo "Updated fruits: ${fruits[@]}"
echo

echo "Remove element (unset):"
echo "Command: unset fruits[2]"
pause

unset fruits[2]
echo "After removing index 2: ${fruits[@]}"
echo "Indices now: ${!fruits[@]}"
echo

echo "=== PART 5: Looping Through Arrays ==="
echo

echo "Loop through values:"
echo "Command: for fruit in \"\${fruits[@]}\"; do echo \"Fruit: \$fruit\"; done"
pause

for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done
echo

echo "Loop through indices:"
echo "Command: for i in \"\${!fruits[@]}\"; do echo \"Index \$i: \${fruits[i]}\"; done"
pause

for i in "${!fruits[@]}"; do
    echo "Index $i: ${fruits[i]}"
done
echo

echo "Traditional for loop:"
echo "Command: for ((i=0; i<\${#fruits[@]}; i++)); do echo \"Position \$i: \${fruits[i]}\"; done"
pause

# Recreate array without gaps for this example
fruits=("apple" "banana" "grape" "mango" "kiwi" "pineapple")
for ((i=0; i<${#fruits[@]}; i++)); do
    echo "Position $i: ${fruits[i]}"
done
echo

echo "=== PART 6: Array Operations ==="
echo

echo "Create numbers array:"
numbers=(10 25 5 30 15)
echo "Numbers: ${numbers[@]}"
echo

echo "Find maximum value:"
max=${numbers[0]}
for num in "${numbers[@]}"; do
    if [ "$num" -gt "$max" ]; then
        max=$num
    fi
done
echo "Maximum: $max"
echo

echo "Calculate sum:"
sum=0
for num in "${numbers[@]}"; do
    sum=$((sum + num))
done
echo "Sum: $sum"
echo "Average: $((sum / ${#numbers[@]}))"
echo

echo "=== PART 7: String Arrays and Searching ==="
echo

echo "Search for element:"
search_fruit="banana"
found=false
for fruit in "${fruits[@]}"; do
    if [ "$fruit" = "$search_fruit" ]; then
        found=true
        break
    fi
done

if $found; then
    echo "Found '$search_fruit' in the array"
else
    echo "'$search_fruit' not found in the array"
fi
echo

echo "Count occurrences:"
test_array=("apple" "banana" "apple" "orange" "apple")
count=0
for item in "${test_array[@]}"; do
    if [ "$item" = "apple" ]; then
        count=$((count + 1))
    fi
done
echo "Test array: ${test_array[@]}"
echo "Occurrences of 'apple': $count"
echo

echo "What you learned:"
echo "   - array=(val1 val2 val3) to create arrays"
echo "   - \${array[index]} to access elements"
echo "   - \${array[@]} to get all elements"
echo "   - \${#array[@]} to get array length"
echo "   - \${!array[@]} to get indices"
echo "   - array+=(new_element) to append"
echo "   - unset array[index] to remove elements"
echo "   - for loops to iterate through arrays"
echo
echo "Next: Learn associative arrays (hash tables)"
