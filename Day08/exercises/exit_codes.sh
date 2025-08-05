#!/bin/bash

# Day 8 Exercise 1: Exit Codes and Error Detection
# Learning: Understanding and using exit codes for error handling

echo "Day 8: Exit Codes and Error Detection"
echo "====================================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Understanding Exit Codes ==="
echo

echo "Every command returns an exit code:"
echo "  0 = success"
echo "  1-255 = various error conditions"
echo

echo "Check the exit code of the last command with \$?:"
echo "Command: ls /existing/directory; echo \"Exit code: \$?\""
pause

ls /etc > /dev/null 2>&1; echo "Exit code: $?"
echo

echo "Command: ls /nonexistent/directory; echo \"Exit code: \$?\""
pause

ls /nonexistent/directory > /dev/null 2>&1; echo "Exit code: $?"
echo

echo "=== PART 2: Testing Command Success ==="
echo

echo "Use && to run command only if previous succeeded:"
echo "Command: ls /etc && echo \"Directory exists!\""
pause

ls /etc > /dev/null 2>&1 && echo "Directory exists!"
echo

echo "Command: ls /nonexistent && echo \"This won't print\""
pause

ls /nonexistent > /dev/null 2>&1 && echo "This won't print"
echo

echo "Use || to run command only if previous failed:"
echo "Command: ls /nonexistent || echo \"Directory not found!\""
pause

ls /nonexistent > /dev/null 2>&1 || echo "Directory not found!"
echo

echo "=== PART 3: Functions with Exit Codes ==="
echo

# Define test functions
check_file() {
    local filename="$1"
    if [[ -f "$filename" ]]; then
        echo "File $filename exists"
        return 0
    else
        echo "File $filename not found"
        return 1
    fi
}

create_backup() {
    local source="$1"
    local backup="$2"
    
    if [[ ! -f "$source" ]]; then
        echo "Error: Source file $source does not exist"
        return 2
    fi
    
    if cp "$source" "$backup" 2>/dev/null; then
        echo "Backup created: $backup"
        return 0
    else
        echo "Error: Failed to create backup"
        return 3
    fi
}

echo "Testing file existence function:"
echo "Command: check_file \"/etc/passwd\""
pause

check_file "/etc/passwd"
echo "Exit code: $?"
echo

echo "Command: check_file \"/nonexistent/file\""
pause

check_file "/nonexistent/file"
echo "Exit code: $?"
echo

echo "=== PART 4: Custom Exit Codes ==="
echo

# Create a test file
echo "test content" > test_file.txt

echo "Testing backup function with custom exit codes:"
echo "Command: create_backup \"test_file.txt\" \"test_backup.txt\""
pause

create_backup "test_file.txt" "test_backup.txt"
backup_result=$?
echo "Exit code: $backup_result"
echo

echo "Command: create_backup \"/nonexistent\" \"backup.txt\""
pause

create_backup "/nonexistent" "backup.txt"
backup_result=$?
echo "Exit code: $backup_result"
echo

echo "=== PART 5: Script-level Exit Codes ==="
echo

# Create a sample script
cat > exit_demo.sh << 'EOF'
#!/bin/bash

# Function to validate input
validate_number() {
    local input="$1"
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Main script logic
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <number>"
    exit 10  # Custom exit code for usage error
fi

if validate_number "$1"; then
    echo "Valid number: $1"
    if [[ $1 -gt 100 ]]; then
        echo "Number is greater than 100"
        exit 0
    else
        echo "Number is 100 or less"
        exit 1
    fi
else
    echo "Error: '$1' is not a valid number"
    exit 20  # Custom exit code for validation error
fi
EOF

chmod +x exit_demo.sh

echo "Testing script with custom exit codes:"
echo "Command: ./exit_demo.sh"
pause

./exit_demo.sh
echo "Exit code: $?"
echo

echo "Command: ./exit_demo.sh abc"
pause

./exit_demo.sh abc
echo "Exit code: $?"
echo

echo "Command: ./exit_demo.sh 50"
pause

./exit_demo.sh 50
echo "Exit code: $?"
echo

echo "Command: ./exit_demo.sh 150"
pause

./exit_demo.sh 150
echo "Exit code: $?"
echo

echo "=== PART 6: Error Handling Patterns ==="
echo

safe_operation() {
    local operation="$1"
    local target="$2"
    
    case "$operation" in
        "read")
            if [[ -r "$target" ]]; then
                cat "$target"
                return 0
            else
                echo "Error: Cannot read $target"
                return 1
            fi
            ;;
        "write")
            if echo "test" > "$target" 2>/dev/null; then
                echo "Write successful to $target"
                return 0
            else
                echo "Error: Cannot write to $target"
                return 2
            fi
            ;;
        *)
            echo "Error: Unknown operation $operation"
            return 99
            ;;
    esac
}

echo "Testing safe operations:"
echo "Command: safe_operation \"read\" \"/etc/passwd\""
pause

safe_operation "read" "/etc/passwd" | head -3
echo "Exit code: $?"
echo

echo "Command: safe_operation \"write\" \"/tmp/test_write\""
pause

safe_operation "write" "/tmp/test_write"
echo "Exit code: $?"
echo

echo "Command: safe_operation \"invalid\" \"anything\""
pause

safe_operation "invalid" "anything"
echo "Exit code: $?"
echo

echo "=== PART 7: Chaining with Exit Codes ==="
echo

echo "Complex operation chaining:"
echo "Command: check_file \"test_file.txt\" && create_backup \"test_file.txt\" \"final_backup.txt\" && echo \"All operations successful\""
pause

check_file "test_file.txt" && create_backup "test_file.txt" "final_backup.txt" && echo "All operations successful"
echo

echo "Error handling with fallback:"
echo "Command: check_file \"missing.txt\" || echo \"File missing, creating it...\" && echo \"content\" > missing.txt"
pause

check_file "missing.txt" || { echo "File missing, creating it..."; echo "content" > missing.txt; }
echo

# Clean up
rm -f test_file.txt test_backup.txt final_backup.txt exit_demo.sh missing.txt
rm -f /tmp/test_write

echo "What you learned:"
echo "   - Exit codes: 0=success, non-zero=error"
echo "   - \$? variable contains last command's exit code"
echo "   - && runs command only if previous succeeded"
echo "   - || runs command only if previous failed"
echo "   - return statement sets function exit code"
echo "   - exit statement sets script exit code"
echo "   - Custom exit codes for different error types"
echo "   - Chaining operations with logic operators"
echo
echo "Next: Learn error trapping with trap command"
