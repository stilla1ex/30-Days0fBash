#!/bin/bash

# Day 8 Exercise 3: Debugging Techniques and Tools
# Learning: Script debugging, troubleshooting, and optimization

echo "Day 8: Debugging Techniques and Tools"
echo "===================================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Basic Debugging Options ==="
echo

echo "Bash debugging options:"
echo "  set -x  : Print commands before execution"
echo "  set -v  : Print shell input lines as read"
echo "  set -n  : Check syntax without execution"
echo "  bash -x : Run script with execution tracing"
echo

# Create a sample script with bugs
cat > buggy_script.sh << 'EOF'
#!/bin/bash

# This script has intentional bugs for debugging practice

process_file() {
    local filename=$1
    
    echo "Processing file: $filename"
    
    # Bug 1: Not checking if file exists
    line_count=$(wc -l < $filename)
    echo "File has $line_count lines"
    
    # Bug 2: Unquoted variable in loop
    for line in $(cat $filename); do
        echo "Line: $line"
    done
    
    # Bug 3: Using undefined variable
    echo "Total processed: $total_processed"
}

# Bug 4: Missing quotes around filename
process_file test file.txt
EOF

chmod +x buggy_script.sh

echo "Sample buggy script created. Let's debug it:"
echo "Command: cat buggy_script.sh"
pause

cat buggy_script.sh
echo

echo "Check syntax without execution:"
echo "Command: bash -n buggy_script.sh"
pause

bash -n buggy_script.sh
echo "Syntax check complete (no output means no syntax errors)"
echo

echo "=== PART 2: Execution Tracing ==="
echo

# Create test file for debugging
echo -e "line one\nline two\nline three" > "test file.txt"

echo "Run with execution tracing:"
echo "Command: bash -x buggy_script.sh"
pause

bash -x buggy_script.sh 2>&1 || echo "Script failed as expected"
echo

echo "=== PART 3: Conditional Debugging ==="
echo

# Create script with conditional debugging
cat > debug_conditional.sh << 'EOF'
#!/bin/bash

# Enable debugging based on environment variable
DEBUG=${DEBUG:-false}

debug_echo() {
    if [[ "$DEBUG" = true ]]; then
        echo "DEBUG: $*" >&2
    fi
}

process_numbers() {
    local numbers=("$@")
    local sum=0
    
    debug_echo "Starting number processing"
    debug_echo "Input numbers: ${numbers[*]}"
    
    for num in "${numbers[@]}"; do
        debug_echo "Processing number: $num"
        
        if [[ "$num" =~ ^[0-9]+$ ]]; then
            sum=$((sum + num))
            debug_echo "Added $num to sum, new total: $sum"
        else
            echo "Warning: '$num' is not a valid number" >&2
            debug_echo "Skipping invalid number: $num"
        fi
    done
    
    debug_echo "Final sum calculated: $sum"
    echo "Sum: $sum"
}

# Test with different inputs
process_numbers 1 2 3 abc 4 5
EOF

chmod +x debug_conditional.sh

echo "Normal execution:"
echo "Command: ./debug_conditional.sh"
pause

./debug_conditional.sh
echo

echo "With debugging enabled:"
echo "Command: DEBUG=true ./debug_conditional.sh"
pause

DEBUG=true ./debug_conditional.sh
echo

echo "=== PART 4: Function Debugging ==="
echo

# Create script with function-level debugging
cat > function_debug.sh << 'EOF'
#!/bin/bash

# Function to trace function calls
trace_function() {
    local func_name="$1"
    shift
    local args="$*"
    
    echo "TRACE: Entering function '$func_name' with args: [$args]" >&2
}

# Wrapper for debugging function returns
debug_return() {
    local func_name="$1"
    local return_code="$2"
    
    echo "TRACE: Function '$func_name' returned: $return_code" >&2
    return $return_code
}

# Example functions with tracing
validate_email() {
    trace_function "validate_email" "$@"
    
    local email="$1"
    
    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "Valid email: $email"
        debug_return "validate_email" 0
    else
        echo "Invalid email: $email"
        debug_return "validate_email" 1
    fi
}

process_user_data() {
    trace_function "process_user_data" "$@"
    
    local name="$1"
    local email="$2"
    
    echo "Processing user: $name"
    
    if validate_email "$email"; then
        echo "User $name added successfully"
        debug_return "process_user_data" 0
    else
        echo "Failed to add user $name"
        debug_return "process_user_data" 1
    fi
}

# Test the functions
echo "Testing function tracing:"
process_user_data "John Doe" "john@example.com"
echo
process_user_data "Jane Smith" "invalid-email"
EOF

chmod +x function_debug.sh

echo "Function-level debugging:"
echo "Command: ./function_debug.sh"
pause

./function_debug.sh
echo

echo "=== PART 5: Variable State Debugging ==="
echo

# Create script for variable debugging
cat > variable_debug.sh << 'EOF'
#!/bin/bash

# Function to dump variable state
dump_vars() {
    local context="$1"
    echo "=== VARIABLE DUMP: $context ===" >&2
    echo "PWD: $PWD" >&2
    echo "USER: $USER" >&2
    echo "Arguments: $*" >&2
    echo "Argument count: $#" >&2
    echo "Script name: $0" >&2
    echo "Process ID: $$" >&2
    echo "================================" >&2
}

# Function to trace variable changes
trace_var() {
    local var_name="$1"
    local var_value="$2"
    echo "VAR_TRACE: $var_name = '$var_value'" >&2
}

# Example function with variable tracing
calculate_area() {
    dump_vars "calculate_area start"
    
    local length="$1"
    local width="$2"
    
    trace_var "length" "$length"
    trace_var "width" "$width"
    
    if [[ ! "$length" =~ ^[0-9]+$ ]] || [[ ! "$width" =~ ^[0-9]+$ ]]; then
        echo "Error: Both length and width must be numbers"
        return 1
    fi
    
    local area=$((length * width))
    trace_var "area" "$area"
    
    echo "Area: $area"
    
    dump_vars "calculate_area end"
    return 0
}

# Test variable debugging
calculate_area 5 10
echo
calculate_area abc 5
EOF

chmod +x variable_debug.sh

echo "Variable state debugging:"
echo "Command: ./variable_debug.sh"
pause

./variable_debug.sh
echo

echo "=== PART 6: Performance Debugging ==="
echo

# Create performance debugging script
cat > performance_debug.sh << 'EOF'
#!/bin/bash

# Function to measure execution time
time_function() {
    local func_name="$1"
    shift
    
    echo "PERF: Starting '$func_name'" >&2
    local start_time=$(date +%s.%N)
    
    # Execute the function
    "$func_name" "$@"
    local result=$?
    
    local end_time=$(date +%s.%N)
    local duration=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "unknown")
    
    echo "PERF: Function '$func_name' took ${duration} seconds" >&2
    return $result
}

# Slow function for testing
slow_function() {
    echo "Performing slow operation..."
    
    local sum=0
    for i in {1..10000}; do
        sum=$((sum + i))
    done
    
    echo "Sum calculated: $sum"
    sleep 1  # Simulate additional work
}

# Fast function for comparison
fast_function() {
    echo "Performing fast operation..."
    
    # Use arithmetic formula instead of loop
    local n=10000
    local sum=$(( n * (n + 1) / 2 ))
    
    echo "Sum calculated: $sum"
}

# Test performance
echo "Testing performance differences:"
time_function slow_function
echo
time_function fast_function
EOF

chmod +x performance_debug.sh

echo "Performance debugging:"
echo "Command: ./performance_debug.sh"
pause

./performance_debug.sh
echo

echo "=== PART 7: Interactive Debugging ==="
echo

# Create interactive debugging script
cat > interactive_debug.sh << 'EOF'
#!/bin/bash

# Interactive debugging function
debug_prompt() {
    local line_number="$1"
    local command="$2"
    
    echo "DEBUG: Line $line_number: About to execute: $command" >&2
    echo -n "DEBUG: Continue? (y/n/q): " >&2
    read -r response
    
    case "$response" in
        n|N) echo "DEBUG: Skipping command" >&2; return 1 ;;
        q|Q) echo "DEBUG: Quitting" >&2; exit 0 ;;
        *) return 0 ;;
    esac
}

# Function with interactive debugging
process_files() {
    local files=("$@")
    
    for file in "${files[@]}"; do
        if debug_prompt $LINENO "ls -la '$file'"; then
            ls -la "$file" 2>/dev/null || echo "File not found: $file"
        fi
        
        if debug_prompt $LINENO "wc -l '$file'"; then
            wc -l "$file" 2>/dev/null || echo "Cannot count lines in: $file"
        fi
    done
}

# Create test files
echo "content" > test1.txt
echo -e "line1\nline2" > test2.txt

echo "Interactive debugging (respond with y/n/q):"
process_files test1.txt test2.txt nonexistent.txt
EOF

chmod +x interactive_debug.sh

echo "Interactive debugging script created."
echo "This would normally prompt for user input at each step."
echo "Command: echo 'y' | ./interactive_debug.sh"
pause

echo 'y' | ./interactive_debug.sh
echo

# Clean up
rm -f buggy_script.sh "test file.txt" debug_conditional.sh function_debug.sh
rm -f variable_debug.sh performance_debug.sh interactive_debug.sh
rm -f test1.txt test2.txt

echo "What you learned:"
echo "   - set -x for execution tracing"
echo "   - set -n for syntax checking"
echo "   - bash -x for script debugging"
echo "   - Conditional debugging with DEBUG variable"
echo "   - Function call tracing"
echo "   - Variable state monitoring"
echo "   - Performance measurement"
echo "   - Interactive debugging techniques"
echo "   - Custom debugging functions"
echo
echo "Next: Build a robust file processing system"
