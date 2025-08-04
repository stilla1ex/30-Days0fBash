#!/bin/bash

# Day 8 Exercise 2: Error Trapping and Signal Handling
# Learning: Advanced error handling with trap command

echo "Day 8: Error Trapping and Signal Handling"
echo "========================================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Basic Error Trapping ==="
echo

echo "The trap command catches signals and errors:"
echo "Common signals:"
echo "  EXIT - script termination"
echo "  ERR - command returns non-zero"
echo "  INT - Ctrl+C interrupt"
echo "  TERM - termination signal"
echo

# Create a basic trap demo
cat > trap_demo.sh << 'EOF'
#!/bin/bash

cleanup() {
    echo "Cleaning up temporary files..."
    rm -f /tmp/demo_*
    echo "Cleanup complete"
}

# Set trap for EXIT
trap cleanup EXIT

echo "Creating temporary files..."
touch /tmp/demo_file1 /tmp/demo_file2
echo "Files created. Script will clean up on exit."
echo "Temporary files:"
ls -la /tmp/demo_*
EOF

chmod +x trap_demo.sh

echo "Basic trap example:"
echo "Command: ./trap_demo.sh"
pause

./trap_demo.sh
echo

echo "=== PART 2: Error Handling with set -e ==="
echo

# Create error handling demo
cat > error_handling.sh << 'EOF'
#!/bin/bash

# Enable exit on error
set -e

error_handler() {
    local exit_code=$?
    echo "Error occurred! Exit code: $exit_code"
    echo "Last command failed in script $0 at line $BASH_LINENO"
    exit $exit_code
}

# Set trap for ERR
trap error_handler ERR

echo "Starting operations..."
echo "Operation 1: Creating file"
echo "test content" > /tmp/test_file

echo "Operation 2: Reading existing file"
cat /tmp/test_file

echo "Operation 3: This will fail!"
cat /nonexistent/file

echo "This line will never be reached"
EOF

chmod +x error_handling.sh

echo "Error handling with set -e:"
echo "Command: ./error_handling.sh"
pause

./error_handling.sh
echo

echo "=== PART 3: Advanced Signal Handling ==="
echo

# Create signal handling demo
cat > signal_demo.sh << 'EOF'
#!/bin/bash

# Global variables for state tracking
INTERRUPTED=false
WORK_PID=""

# Signal handlers
handle_interrupt() {
    echo
    echo "Received interrupt signal (Ctrl+C)"
    INTERRUPTED=true
    
    if [[ -n "$WORK_PID" ]]; then
        echo "Stopping background work (PID: $WORK_PID)"
        kill $WORK_PID 2>/dev/null || true
    fi
    
    echo "Graceful shutdown initiated..."
    exit 130
}

handle_term() {
    echo "Received termination signal"
    echo "Saving work and exiting..."
    exit 143
}

cleanup_on_exit() {
    local exit_code=$?
    echo "Script exiting with code: $exit_code"
    
    # Clean up any background processes
    if [[ -n "$WORK_PID" ]]; then
        kill $WORK_PID 2>/dev/null || true
    fi
    
    # Remove temporary files
    rm -f /tmp/signal_demo_*
    echo "Cleanup completed"
}

# Set up signal traps
trap handle_interrupt INT
trap handle_term TERM
trap cleanup_on_exit EXIT

# Simulate long-running work
simulate_work() {
    local counter=0
    while [[ $counter -lt 30 ]] && [[ "$INTERRUPTED" = false ]]; do
        echo "Working... step $((counter + 1))/30"
        sleep 1
        counter=$((counter + 1))
        
        # Save progress
        echo "Step $((counter))" > /tmp/signal_demo_progress
    done
    
    if [[ "$INTERRUPTED" = false ]]; then
        echo "Work completed successfully!"
    fi
}

echo "Starting work simulation..."
echo "Press Ctrl+C to test interrupt handling"
echo "Or let it complete naturally"

# Start background work
simulate_work &
WORK_PID=$!

# Wait for background work
wait $WORK_PID 2>/dev/null || true
WORK_PID=""
EOF

chmod +x signal_demo.sh

echo "Signal handling demo (will run for 30 seconds or until interrupted):"
echo "Press Ctrl+C during execution to test signal handling"
echo "Command: ./signal_demo.sh"
pause

timeout 10s ./signal_demo.sh || echo "Demo terminated after 10 seconds"
echo

echo "=== PART 4: Comprehensive Error Handling ==="
echo

# Create comprehensive error handling example
cat > robust_script.sh << 'EOF'
#!/bin/bash

# Script configuration
set -euo pipefail  # Exit on error, undefined vars, pipe failures
IFS=$'\n\t'       # Secure Internal Field Separator

# Global variables
SCRIPT_NAME="$(basename "$0")"
LOG_FILE="/tmp/${SCRIPT_NAME}.log"
TEMP_DIR="/tmp/${SCRIPT_NAME}_$$"
DEBUG=${DEBUG:-false}

# Logging function
log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Debug function
debug() {
    if [[ "$DEBUG" = true ]]; then
        log "DEBUG" "$*"
    fi
}

# Error handler
error_handler() {
    local exit_code=$?
    local line_number=${BASH_LINENO[0]}
    
    log "ERROR" "Script failed at line $line_number with exit code $exit_code"
    log "ERROR" "Failed command: ${BASH_COMMAND}"
    
    # Stack trace
    local frame=0
    while caller $frame; do
        ((frame++))
    done 2>/dev/null | while read line func file; do
        log "TRACE" "  at $func ($file:$line)"
    done
    
    cleanup
    exit $exit_code
}

# Cleanup function
cleanup() {
    log "INFO" "Starting cleanup..."
    
    # Remove temporary directory
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR"
        debug "Removed temporary directory: $TEMP_DIR"
    fi
    
    # Kill any background jobs
    local jobs_count=$(jobs -r | wc -l)
    if [[ $jobs_count -gt 0 ]]; then
        log "WARN" "Killing $jobs_count background jobs"
        kill $(jobs -p) 2>/dev/null || true
    fi
    
    log "INFO" "Cleanup completed"
}

# Validation functions
validate_file() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        log "ERROR" "File does not exist: $file"
        return 1
    fi
    
    if [[ ! -r "$file" ]]; then
        log "ERROR" "File is not readable: $file"
        return 2
    fi
    
    debug "File validation passed: $file"
    return 0
}

validate_directory() {
    local dir="$1"
    
    if [[ ! -d "$dir" ]]; then
        log "ERROR" "Directory does not exist: $dir"
        return 1
    fi
    
    if [[ ! -w "$dir" ]]; then
        log "ERROR" "Directory is not writable: $dir"
        return 2
    fi
    
    debug "Directory validation passed: $dir"
    return 0
}

# Safe file operations
safe_copy() {
    local source="$1"
    local destination="$2"
    
    log "INFO" "Copying $source to $destination"
    
    # Validate source
    validate_file "$source" || return 1
    
    # Validate destination directory
    local dest_dir=$(dirname "$destination")
    validate_directory "$dest_dir" || return 1
    
    # Perform copy with error checking
    if cp "$source" "$destination" 2>/dev/null; then
        log "INFO" "Copy successful"
        return 0
    else
        log "ERROR" "Copy failed"
        return 1
    fi
}

# Main function
main() {
    log "INFO" "Script started: $SCRIPT_NAME"
    
    # Create temporary directory
    mkdir -p "$TEMP_DIR"
    debug "Created temporary directory: $TEMP_DIR"
    
    # Create test file
    local test_file="/tmp/test_source.txt"
    echo "Test content $(date)" > "$test_file"
    log "INFO" "Created test file: $test_file"
    
    # Perform safe operations
    safe_copy "$test_file" "$TEMP_DIR/copy1.txt"
    safe_copy "$test_file" "$TEMP_DIR/copy2.txt"
    
    # Simulate some processing
    log "INFO" "Processing files..."
    for file in "$TEMP_DIR"/*; do
        if [[ -f "$file" ]]; then
            local line_count=$(wc -l < "$file")
            log "INFO" "File $(basename "$file") has $line_count lines"
        fi
    done
    
    # Test error condition (uncomment to test error handling)
    # log "INFO" "Testing error condition..."
    # cat /nonexistent/file
    
    log "INFO" "Script completed successfully"
}

# Set up traps
trap error_handler ERR
trap cleanup EXIT
trap 'log "WARN" "Received interrupt signal"; exit 130' INT
trap 'log "WARN" "Received termination signal"; exit 143' TERM

# Run main function
main "$@"
EOF

chmod +x robust_script.sh

echo "Comprehensive error handling script:"
echo "Command: ./robust_script.sh"
pause

./robust_script.sh
echo

echo "Check the log file:"
echo "Command: cat /tmp/robust_script.sh.log"
pause

cat /tmp/robust_script.sh.log
echo

echo "=== PART 5: Debugging with Traps ==="
echo

# Create debugging example
cat > debug_example.sh << 'EOF'
#!/bin/bash

# Enable debugging
set -x  # Print commands as they execute

debug_handler() {
    echo "DEBUG: Line $BASH_LINENO: $BASH_COMMAND"
}

# Uncomment to enable line-by-line debugging
# trap debug_handler DEBUG

calculate() {
    local a=$1
    local b=$2
    local operation=$3
    
    case "$operation" in
        "add") echo $((a + b)) ;;
        "subtract") echo $((a - b)) ;;
        "multiply") echo $((a * b)) ;;
        "divide") 
            if [[ $b -eq 0 ]]; then
                echo "Error: Division by zero" >&2
                return 1
            fi
            echo $((a / b))
            ;;
        *) 
            echo "Error: Unknown operation $operation" >&2
            return 2
            ;;
    esac
}

echo "Testing calculator with debugging enabled"
calculate 10 5 add
calculate 10 5 subtract
calculate 10 0 divide  # This will cause an error
EOF

chmod +x debug_example.sh

echo "Debugging with set -x:"
echo "Command: ./debug_example.sh"
pause

./debug_example.sh
echo

# Clean up
rm -f trap_demo.sh error_handling.sh signal_demo.sh robust_script.sh debug_example.sh
rm -f /tmp/test_file /tmp/test_source.txt /tmp/robust_script.sh.log
rm -rf /tmp/robust_script.sh_*
rm -f /tmp/signal_demo_*

echo "What you learned:"
echo "   - trap command for signal handling"
echo "   - EXIT, ERR, INT, TERM signals"
echo "   - set -e for exit on error"
echo "   - set -u for exit on undefined variables"
echo "   - set -o pipefail for pipe error handling"
echo "   - Cleanup functions for resource management"
echo "   - Error logging and debugging"
echo "   - Graceful shutdown handling"
echo "   - Stack trace generation"
echo
echo "Next: Learn debugging techniques and tools"
