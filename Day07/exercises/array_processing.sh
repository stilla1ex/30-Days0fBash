#!/bin/bash

# Day 7 Exercise 3: Array Processing
# Learning: Advanced array operations and algorithms

echo "Day 7: Advanced Array Processing"
echo "================================"

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Array Sorting ==="
echo

echo "Create unsorted array:"
numbers=(42 17 89 23 56 91 13 67)
echo "Original array: ${numbers[@]}"
echo

echo "Bubble sort implementation:"
echo "Command: Implementing bubble sort algorithm..."
pause

# Bubble sort
sorted_numbers=("${numbers[@]}")  # Copy array
n=${#sorted_numbers[@]}

for ((i=0; i<n-1; i++)); do
    for ((j=0; j<n-i-1; j++)); do
        if [ "${sorted_numbers[j]}" -gt "${sorted_numbers[j+1]}" ]; then
            # Swap elements
            temp=${sorted_numbers[j]}
            sorted_numbers[j]=${sorted_numbers[j+1]}
            sorted_numbers[j+1]=$temp
        fi
    done
done

echo "Sorted array: ${sorted_numbers[@]}"
echo

echo "String array sorting:"
names=("Charlie" "Alice" "Bob" "David")
echo "Original names: ${names[@]}"

# Simple selection sort for strings
sorted_names=("${names[@]}")
n=${#sorted_names[@]}

for ((i=0; i<n-1; i++)); do
    min_idx=$i
    for ((j=i+1; j<n; j++)); do
        if [[ "${sorted_names[j]}" < "${sorted_names[min_idx]}" ]]; then
            min_idx=$j
        fi
    done
    # Swap if needed
    if [ $min_idx -ne $i ]; then
        temp=${sorted_names[i]}
        sorted_names[i]=${sorted_names[min_idx]}
        sorted_names[min_idx]=$temp
    fi
done

echo "Sorted names: ${sorted_names[@]}"
echo

echo "=== PART 2: Array Filtering ==="
echo

echo "Filter even numbers:"
all_numbers=(1 2 3 4 5 6 7 8 9 10 11 12)
even_numbers=()

for num in "${all_numbers[@]}"; do
    if [ $((num % 2)) -eq 0 ]; then
        even_numbers+=("$num")
    fi
done

echo "All numbers: ${all_numbers[@]}"
echo "Even numbers: ${even_numbers[@]}"
echo

echo "Filter strings by length:"
words=("cat" "elephant" "dog" "butterfly" "ant" "hippopotamus")
long_words=()

echo "Original words: ${words[@]}"
for word in "${words[@]}"; do
    if [ ${#word} -gt 5 ]; then
        long_words+=("$word")
    fi
done

echo "Words longer than 5 characters: ${long_words[@]}"
echo

echo "=== PART 3: Array Transformation ==="
echo

echo "Convert to uppercase:"
lowercase_words=("hello" "world" "bash" "script")
uppercase_words=()

echo "Lowercase: ${lowercase_words[@]}"
for word in "${lowercase_words[@]}"; do
    uppercase_words+=("$(echo "$word" | tr '[:lower:]' '[:upper:]')")
done
echo "Uppercase: ${uppercase_words[@]}"
echo

echo "Square all numbers:"
base_numbers=(1 2 3 4 5)
squared_numbers=()

echo "Base numbers: ${base_numbers[@]}"
for num in "${base_numbers[@]}"; do
    squared_numbers+=($((num * num)))
done
echo "Squared numbers: ${squared_numbers[@]}"
echo

echo "=== PART 4: Array Merging and Set Operations ==="
echo

echo "Array merging:"
array1=("apple" "banana" "cherry")
array2=("date" "elderberry")
merged_array=("${array1[@]}" "${array2[@]}")

echo "Array 1: ${array1[@]}"
echo "Array 2: ${array2[@]}"
echo "Merged: ${merged_array[@]}"
echo

echo "Remove duplicates (union):"
all_fruits=("apple" "banana" "apple" "cherry" "banana" "date")
unique_fruits=()

echo "Original with duplicates: ${all_fruits[@]}"

# Remove duplicates
for fruit in "${all_fruits[@]}"; do
    found=false
    for unique_fruit in "${unique_fruits[@]}"; do
        if [ "$fruit" = "$unique_fruit" ]; then
            found=true
            break
        fi
    done
    if [ "$found" = false ]; then
        unique_fruits+=("$fruit")
    fi
done

echo "Unique fruits: ${unique_fruits[@]}"
echo

echo "=== PART 5: Array Statistics ==="
echo

echo "Statistical analysis:"
data=(15 23 8 42 16  39 7 28 33 12)
echo "Data set: ${data[@]}"

# Calculate statistics
sum=0
min=${data[0]}
max=${data[0]}
count=${#data[@]}

for num in "${data[@]}"; do
    sum=$((sum + num))
    
    if [ "$num" -lt "$min" ]; then
        min=$num
    fi
    
    if [ "$num" -gt "$max" ]; then
        max=$num
    fi
done

average=$((sum / count))

echo "Count: $count"
echo "Sum: $sum"
echo "Average: $average"
echo "Minimum: $min"
echo "Maximum: $max"
echo "Range: $((max - min))"
echo

echo "=== PART 6: Multi-dimensional Array Simulation ==="
echo

echo "Simulate 2D array (matrix):"
# Simulate a 3x3 matrix using naming convention
declare -A matrix

# Fill matrix
matrix["0,0"]=1; matrix["0,1"]=2; matrix["0,2"]=3
matrix["1,0"]=4; matrix["1,1"]=5; matrix["1,2"]=6
matrix["2,0"]=7; matrix["2,1"]=8; matrix["2,2"]=9

echo "3x3 Matrix:"
for i in {0..2}; do
    row=""
    for j in {0..2}; do
        row="$row ${matrix["$i,$j"]}"
    done
    echo "$row"
done
echo

echo "Calculate row sums:"
for i in {0..2}; do
    row_sum=0
    for j in {0..2}; do
        row_sum=$((row_sum + matrix["$i,$j"]))
    done
    echo "Row $i sum: $row_sum"
done
echo

echo "=== PART 7: Frequency Analysis ==="
echo

echo "Count character frequency:"
text="hello world this is a test"
declare -A char_freq

echo "Analyzing text: '$text'"

# Count characters (excluding spaces)
for (( i=0; i<${#text}; i++ )); do
    char="${text:$i:1}"
    if [ "$char" != " " ]; then
        if [[ -v char_freq["$char"] ]]; then
            char_freq["$char"]=$((char_freq["$char"] + 1))
        else
            char_freq["$char"]=1
        fi
    fi
done

echo "Character frequencies:"
for char in "${!char_freq[@]}"; do
    echo "  '$char': ${char_freq[$char]}"
done | sort
echo

echo "=== PART 8: Dynamic Array Building ==="
echo

echo "Build array from user input simulation:"
echo "Simulating reading file data into array..."

# Simulate reading file data
file_data="192.168.1.100 apache
192.168.1.101 nginx  
192.168.1.102 mysql
192.168.1.103 redis"

declare -A server_map
servers=()

while IFS=' ' read -r ip service; do
    servers+=("$ip")
    server_map["$ip"]="$service"
done <<< "$file_data"

echo "Servers discovered: ${#servers[@]}"
echo "Server mapping:"
for server in "${servers[@]}"; do
    echo "  $server -> ${server_map[$server]}"
done
echo

echo "Group by service type:"
declare -A service_groups

for server in "${servers[@]}"; do
    service=${server_map[$server]}
    if [[ -v service_groups["$service"] ]]; then
        service_groups["$service"]="${service_groups[$service]},$server"
    else
        service_groups["$service"]="$server"
    fi
done

echo "Service groups:"
for service in "${!service_groups[@]}"; do
    echo "  $service: ${service_groups[$service]}"
done
echo

echo "What you learned:"
echo "   - Sorting algorithms (bubble sort, selection sort)"
echo "   - Array filtering with conditions"
echo "   - Array transformation and mapping"
echo "   - Set operations (union, deduplication)"
echo "   - Statistical calculations on arrays"
echo "   - Multi-dimensional array simulation"
echo "   - Frequency analysis techniques"
echo "   - Dynamic array construction"
echo "   - Complex data processing patterns"
echo
echo "Next: Complete the daily challenge - Contact Management System"
