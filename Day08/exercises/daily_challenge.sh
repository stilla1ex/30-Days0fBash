#!/bin/bash

# Day 8 Daily Challenge: Robust File Processing System
# Build a production-ready file processor with comprehensive error handling

echo "Day 8 Challenge: Robust File Processing System"
echo "=============================================="

# Script configuration
set -euo pipefail
IFS=$'\n\t'

# Global configuration
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_DIR="/tmp/file_processor_logs"
readonly WORK_DIR="/tmp/file_processor_work"
readonly CONFIG_FILE="$SCRIPT_DIR/processor.conf"

# Default configuration
DEFAULT_MAX_FILE_SIZE="10485760"  # 10MB
DEFAULT_ALLOWED_EXTENSIONS="txt,log,csv,json"
DEFAULT_BACKUP_ENABLED="true"
DEFAULT_PARALLEL_JOBS="4"

# Global variables
PROCESSED_COUNT=0
ERROR_COUNT=0
SKIPPED_COUNT=0
START_TIME=""
LOG_FILE=""
INTERRUPTED=false

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Logging functions
setup_logging() {
    mkdir -p "$LOG_DIR"
    LOG_FILE="$LOG_DIR/processor_$(date +%Y%m%d_%H%M%S).log"
    START_TIME=$(date +%s)
    
    log_info "File Processor started"
    log_info "Log file: $LOG_FILE"
    log_info "Working directory: $WORK_DIR"
}

log_message() {
    local level="$1"
    local color="$2"
    shift 2
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Log to file
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
    
    # Display with color
    echo -e "${color}[$level]${NC} $message"
}

log_info() { log_message "INFO" "$BLUE" "$@"; }
log_warn() { log_message "WARN" "$YELLOW" "$@"; }
log_error() { log_message "ERROR" "$RED" "$@"; }
log_success() { log_message "SUCCESS" "$GREEN" "$@"; }

# Configuration management
load_config() {
    # Set defaults
    MAX_FILE_SIZE="$DEFAULT_MAX_FILE_SIZE"
    ALLOWED_EXTENSIONS="$DEFAULT_ALLOWED_EXTENSIONS"
    BACKUP_ENABLED="$DEFAULT_BACKUP_ENABLED"
    PARALLEL_JOBS="$DEFAULT_PARALLEL_JOBS"
    
    # Load from config file if exists
    if [[ -f "$CONFIG_FILE" ]]; then
        log_info "Loading configuration from $CONFIG_FILE"
        source "$CONFIG_FILE"
    else
        log_warn "Configuration file not found, using defaults"
        create_default_config
    fi
    
    # Validate configuration
    validate_config
}

create_default_config() {
    cat > "$CONFIG_FILE" << EOF
# File Processor Configuration

# Maximum file size in bytes (default: 10MB)
MAX_FILE_SIZE="$DEFAULT_MAX_FILE_SIZE"

# Allowed file extensions (comma-separated)
ALLOWED_EXTENSIONS="$DEFAULT_ALLOWED_EXTENSIONS"

# Enable backup creation
BACKUP_ENABLED="$DEFAULT_BACKUP_ENABLED"

# Number of parallel processing jobs
PARALLEL_JOBS="$DEFAULT_PARALLEL_JOBS"

# Custom processing commands (optional)
# CUSTOM_COMMAND="your_command_here"
EOF
    
    log_info "Created default configuration file: $CONFIG_FILE"
}

validate_config() {
    local errors=0
    
    # Validate MAX_FILE_SIZE
    if ! [[ "$MAX_FILE_SIZE" =~ ^[0-9]+$ ]] || [[ "$MAX_FILE_SIZE" -lt 1 ]]; then
        log_error "Invalid MAX_FILE_SIZE: $MAX_FILE_SIZE"
        errors=$((errors + 1))
    fi
    
    # Validate PARALLEL_JOBS
    if ! [[ "$PARALLEL_JOBS" =~ ^[0-9]+$ ]] || [[ "$PARALLEL_JOBS" -lt 1 ]] || [[ "$PARALLEL_JOBS" -gt 20 ]]; then
        log_error "Invalid PARALLEL_JOBS: $PARALLEL_JOBS (must be 1-20)"
        errors=$((errors + 1))
    fi
    
    # Validate BACKUP_ENABLED
    if [[ "$BACKUP_ENABLED" != "true" ]] && [[ "$BACKUP_ENABLED" != "false" ]]; then
        log_error "Invalid BACKUP_ENABLED: $BACKUP_ENABLED (must be true or false)"
        errors=$((errors + 1))
    fi
    
    if [[ $errors -gt 0 ]]; then
        log_error "Configuration validation failed with $errors errors"
        exit 1
    fi
    
    log_info "Configuration validated successfully"
}

# Error handling and cleanup
error_handler() {
    local exit_code=$?
    local line_number=${BASH_LINENO[0]}
    
    log_error "Script failed at line $line_number with exit code $exit_code"
    log_error "Failed command: ${BASH_COMMAND}"
    
    cleanup
    exit $exit_code
}

cleanup() {
    local exit_code=$?
    
    log_info "Starting cleanup..."
    
    # Kill any background jobs
    local jobs_count=$(jobs -r | wc -l)
    if [[ $jobs_count -gt 0 ]]; then
        log_warn "Terminating $jobs_count background jobs"
        kill $(jobs -p) 2>/dev/null || true
        sleep 1
    fi
    
    # Clean up temporary files
    if [[ -d "$WORK_DIR" ]]; then
        local temp_files=$(find "$WORK_DIR" -name "*.tmp" 2>/dev/null | wc -l)
        if [[ $temp_files -gt 0 ]]; then
            log_info "Removing $temp_files temporary files"
            find "$WORK_DIR" -name "*.tmp" -delete 2>/dev/null || true
        fi
    fi
    
    # Generate summary report
    generate_summary_report
    
    log_info "Cleanup completed"
    return $exit_code
}

handle_interrupt() {
    echo
    log_warn "Received interrupt signal (Ctrl+C)"
    INTERRUPTED=true
    
    log_info "Graceful shutdown initiated..."
    cleanup
    exit 130
}

# File validation functions
validate_file() {
    local file="$1"
    local errors=0
    
    # Check if file exists
    if [[ ! -f "$file" ]]; then
        log_error "File does not exist: $file"
        return 1
    fi
    
    # Check if file is readable
    if [[ ! -r "$file" ]]; then
        log_error "File is not readable: $file"
        return 2
    fi
    
    # Check file size
    local file_size=$(stat -c%s "$file" 2>/dev/null || echo "0")
    if [[ $file_size -gt $MAX_FILE_SIZE ]]; then
        log_warn "File too large ($file_size bytes > $MAX_FILE_SIZE): $file"
        return 3
    fi
    
    # Check file extension
    local extension="${file##*.}"
    extension="${extension,,}"  # Convert to lowercase
    
    if [[ "$ALLOWED_EXTENSIONS" != "*" ]]; then
        local allowed_array
        IFS=',' read -ra allowed_array <<< "$ALLOWED_EXTENSIONS"
        
        local extension_allowed=false
        for allowed_ext in "${allowed_array[@]}"; do
            if [[ "$extension" == "${allowed_ext,,}" ]]; then
                extension_allowed=true
                break
            fi
        done
        
        if [[ "$extension_allowed" = false ]]; then
            log_warn "File extension not allowed: $file (.$extension)"
            return 4
        fi
    fi
    
    return 0
}

# Backup functions
create_backup() {
    local source_file="$1"
    local backup_dir="$WORK_DIR/backups"
    
    if [[ "$BACKUP_ENABLED" != "true" ]]; then
        return 0
    fi
    
    mkdir -p "$backup_dir"
    
    local backup_name="$(basename "$source_file").backup.$(date +%Y%m%d_%H%M%S)"
    local backup_path="$backup_dir/$backup_name"
    
    if cp "$source_file" "$backup_path" 2>/dev/null; then
        log_info "Backup created: $backup_path"
        return 0
    else
        log_error "Failed to create backup for: $source_file"
        return 1
    fi
}

# File processing functions
process_single_file() {
    local file="$1"
    local process_id="$$_$(date +%s%N)"
    
    log_info "Processing file: $file"
    
    # Validate file
    if ! validate_file "$file"; then
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        return 1
    fi
    
    # Create backup if enabled
    if [[ "$BACKUP_ENABLED" = "true" ]]; then
        if ! create_backup "$file"; then
            log_error "Backup failed for: $file"
            ERROR_COUNT=$((ERROR_COUNT + 1))
            return 1
        fi
    fi
    
    # Process the file
    local temp_file="$WORK_DIR/${process_id}.tmp"
    
    # Example processing: count lines, words, characters
    if process_file_content "$file" "$temp_file"; then
        PROCESSED_COUNT=$((PROCESSED_COUNT + 1))
        log_success "Successfully processed: $file"
        return 0
    else
        ERROR_COUNT=$((ERROR_COUNT + 1))
        log_error "Processing failed for: $file"
        return 1
    fi
}

process_file_content() {
    local input_file="$1"
    local temp_file="$2"
    
    # Example processing: create analysis report
    {
        echo "File Analysis Report"
        echo "==================="
        echo "File: $input_file"
        echo "Timestamp: $(date)"
        echo "Size: $(stat -c%s "$input_file" 2>/dev/null || echo "unknown") bytes"
        echo
        
        # Count statistics
        local lines=$(wc -l < "$input_file" 2>/dev/null || echo "0")
        local words=$(wc -w < "$input_file" 2>/dev/null || echo "0")
        local chars=$(wc -c < "$input_file" 2>/dev/null || echo "0")
        
        echo "Statistics:"
        echo "  Lines: $lines"
        echo "  Words: $words"
        echo "  Characters: $chars"
        echo
        
        # Check for specific patterns
        if command -v grep >/dev/null 2>&1; then
            local error_count=$(grep -c -i "error" "$input_file" 2>/dev/null || echo "0")
            local warning_count=$(grep -c -i "warning" "$input_file" 2>/dev/null || echo "0")
            
            echo "Pattern Analysis:"
            echo "  Errors found: $error_count"
            echo "  Warnings found: $warning_count"
        fi
        
    } > "$temp_file"
    
    # Save analysis to results directory
    local results_dir="$WORK_DIR/results"
    mkdir -p "$results_dir"
    
    local result_file="$results_dir/$(basename "$input_file").analysis"
    mv "$temp_file" "$result_file" 2>/dev/null || return 1
    
    log_info "Analysis saved to: $result_file"
    return 0
}

# Batch processing functions
process_files_parallel() {
    local files=("$@")
    local total_files=${#files[@]}
    
    log_info "Starting parallel processing of $total_files files"
    log_info "Using $PARALLEL_JOBS parallel jobs"
    
    # Process files in batches
    local batch_size=$(( (total_files + PARALLEL_JOBS - 1) / PARALLEL_JOBS ))
    local batch_number=0
    
    for ((i=0; i<total_files; i+=batch_size)); do
        if [[ "$INTERRUPTED" = true ]]; then
            log_warn "Processing interrupted by user"
            break
        fi
        
        batch_number=$((batch_number + 1))
        local batch_files=("${files[@]:i:batch_size}")
        
        log_info "Processing batch $batch_number (${#batch_files[@]} files)"
        
        # Start background processes
        local pids=()
        for file in "${batch_files[@]}"; do
            process_single_file "$file" &
            pids+=($!)
            
            # Limit concurrent processes
            if [[ ${#pids[@]} -ge $PARALLEL_JOBS ]]; then
                wait "${pids[0]}"
                pids=("${pids[@]:1}")
            fi
        done
        
        # Wait for remaining processes
        for pid in "${pids[@]}"; do
            wait "$pid"
        done
        
        log_info "Batch $batch_number completed"
    done
    
    log_info "Parallel processing completed"
}

# Reporting functions
generate_summary_report() {
    local end_time=$(date +%s)
    local duration=$((end_time - START_TIME))
    local total_files=$((PROCESSED_COUNT + ERROR_COUNT + SKIPPED_COUNT))
    
    local report_file="$LOG_DIR/summary_$(date +%Y%m%d_%H%M%S).txt"
    
    {
        echo "FILE PROCESSOR SUMMARY REPORT"
        echo "============================="
        echo "Execution Date: $(date)"
        echo "Duration: ${duration} seconds"
        echo
        echo "STATISTICS"
        echo "----------"
        echo "Total files processed: $total_files"
        echo "Successfully processed: $PROCESSED_COUNT"
        echo "Errors encountered: $ERROR_COUNT"
        echo "Files skipped: $SKIPPED_COUNT"
        echo
        echo "Success rate: $(( total_files > 0 ? (PROCESSED_COUNT * 100) / total_files : 0 ))%"
        echo
        echo "CONFIGURATION"
        echo "-------------"
        echo "Max file size: $MAX_FILE_SIZE bytes"
        echo "Allowed extensions: $ALLOWED_EXTENSIONS"
        echo "Backup enabled: $BACKUP_ENABLED"
        echo "Parallel jobs: $PARALLEL_JOBS"
        echo
        echo "FILES PROCESSED"
        echo "---------------"
        
        # List results if any
        if [[ -d "$WORK_DIR/results" ]]; then
            ls -la "$WORK_DIR/results/" 2>/dev/null || echo "No results found"
        fi
        
    } > "$report_file"
    
    log_info "Summary report generated: $report_file"
    
    # Display summary to console
    echo
    echo "PROCESSING SUMMARY"
    echo "=================="
    echo "Duration: ${duration} seconds"
    echo "Processed: $PROCESSED_COUNT files"
    echo "Errors: $ERROR_COUNT files"
    echo "Skipped: $SKIPPED_COUNT files"
    echo "Report: $report_file"
}

# Help and usage functions
show_help() {
    cat << EOF
File Processor - Robust file processing system with error handling

USAGE:
    $SCRIPT_NAME [OPTIONS] <file1> [file2] [file3] ...
    $SCRIPT_NAME [OPTIONS] -d <directory>

OPTIONS:
    -h, --help              Show this help message
    -d, --directory DIR     Process all files in directory
    -c, --config FILE       Use custom configuration file
    -v, --verbose          Enable verbose logging
    -n, --dry-run          Show what would be processed without doing it
    --parallel JOBS        Number of parallel jobs (default: $DEFAULT_PARALLEL_JOBS)
    --max-size SIZE        Maximum file size in bytes (default: $DEFAULT_MAX_FILE_SIZE)
    --extensions EXTS      Allowed extensions, comma-separated (default: $DEFAULT_ALLOWED_EXTENSIONS)
    --no-backup            Disable backup creation

EXAMPLES:
    $SCRIPT_NAME file1.txt file2.log
    $SCRIPT_NAME -d /path/to/files
    $SCRIPT_NAME --parallel 8 --max-size 5242880 *.txt
    $SCRIPT_NAME --no-backup --extensions "txt,csv" data/*.txt

CONFIGURATION:
    Configuration file: $CONFIG_FILE
    Log directory: $LOG_DIR
    Work directory: $WORK_DIR

EOF
}

# Main functions
parse_arguments() {
    local files=()
    local directory=""
    local dry_run=false
    local verbose=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -d|--directory)
                directory="$2"
                shift 2
                ;;
            -c|--config)
                CONFIG_FILE="$2"
                shift 2
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            -n|--dry-run)
                dry_run=true
                shift
                ;;
            --parallel)
                PARALLEL_JOBS="$2"
                shift 2
                ;;
            --max-size)
                MAX_FILE_SIZE="$2"
                shift 2
                ;;
            --extensions)
                ALLOWED_EXTENSIONS="$2"
                shift 2
                ;;
            --no-backup)
                BACKUP_ENABLED="false"
                shift
                ;;
            --)
                shift
                files+=("$@")
                break
                ;;
            -*)
                log_error "Unknown option: $1"
                exit 1
                ;;
            *)
                files+=("$1")
                shift
                ;;
        esac
    done
    
    # Collect files from directory if specified
    if [[ -n "$directory" ]]; then
        if [[ ! -d "$directory" ]]; then
            log_error "Directory not found: $directory"
            exit 1
        fi
        
        log_info "Scanning directory: $directory"
        while IFS= read -r -d '' file; do
            files+=("$file")
        done < <(find "$directory" -type f -print0 2>/dev/null)
    fi
    
    if [[ ${#files[@]} -eq 0 ]]; then
        log_error "No files to process"
        show_help
        exit 1
    fi
    
    log_info "Found ${#files[@]} files to process"
    
    if [[ "$dry_run" = true ]]; then
        log_info "DRY RUN MODE - No files will be modified"
        for file in "${files[@]}"; do
            echo "Would process: $file"
        done
        exit 0
    fi
    
    # Process the files
    process_files_parallel "${files[@]}"
}

main() {
    # Set up signal handlers
    trap error_handler ERR
    trap cleanup EXIT
    trap handle_interrupt INT TERM
    
    # Initialize
    setup_logging
    mkdir -p "$WORK_DIR"
    
    # Load configuration
    load_config
    
    # Check dependencies
    if ! command -v stat >/dev/null 2>&1; then
        log_error "Required command 'stat' not found"
        exit 1
    fi
    
    # Parse arguments and start processing
    if [[ $# -eq 0 ]]; then
        show_help
        exit 0
    fi
    
    parse_arguments "$@"
}

# Demo function for testing
run_demo() {
    echo "File Processor Demo"
    echo "==================="
    echo
    echo "This is a comprehensive file processing system with:"
    echo "   - Robust error handling and recovery"
    echo "   - Configurable processing parameters"
    echo "   - Parallel processing capabilities"
    echo "   - Comprehensive logging and reporting"
    echo "   - Backup and safety features"
    echo "   - Signal handling for graceful shutdown"
    echo
    echo "Creating sample files for demonstration..."
    
    # Create sample files
    mkdir -p demo_files
    echo -e "Line 1\nLine 2\nError occurred\nLine 4" > demo_files/sample1.txt
    echo -e "Warning: high usage\nNormal operation\nError in process" > demo_files/sample2.log
    echo "This is a CSV file" > demo_files/data.csv
    echo "Invalid extension file" > demo_files/invalid.xyz
    
    # Create large file to test size limits
    yes "Large file content" | head -n 1000 > demo_files/large.txt
    
    echo "Sample files created in demo_files/"
    echo
    echo "Demo commands you can try:"
    echo "  $0 -h                           # Show help"
    echo "  $0 -n demo_files/*.txt         # Dry run"
    echo "  $0 demo_files/sample1.txt      # Process single file"
    echo "  $0 -d demo_files               # Process directory"
    echo "  $0 --parallel 2 demo_files/*   # Parallel processing"
    echo
    read -p "Would you like to run a sample processing? (y/N): " run_sample
    
    if [[ "$run_sample" =~ ^[Yy]$ ]]; then
        echo
        echo "Running sample processing..."
        main -d demo_files
    fi
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "Day 8 Challenge: Robust File Processing System"
    echo "=============================================="
    echo
    echo "This script demonstrates comprehensive error handling including:"
    echo "   - Configuration management with validation"
    echo "   - Robust error trapping and recovery"
    echo "   - Signal handling for graceful shutdown"
    echo "   - Comprehensive logging and reporting"
    echo "   - Parallel processing with job control"
    echo "   - File validation and safety checks"
    echo "   - Backup and recovery mechanisms"
    echo
    
    read -p "Would you like to run the interactive demo? (y/N): " run_interactive
    
    if [[ "$run_interactive" =~ ^[Yy]$ ]]; then
        run_demo
    else
        echo
        echo "Challenge Complete!"
        echo
        echo "You can explore the code to see:"
        echo "   - Error handling with set -euo pipefail"
        echo "   - Signal trapping with trap command"
        echo "   - Comprehensive logging system"
        echo "   - Configuration management"
        echo "   - Parallel processing techniques"
        echo "   - File validation and safety checks"
        echo "   - Cleanup and resource management"
        echo
        echo "To use the file processor:"
        echo "   chmod +x $0"
        echo "   $0 --help"
    fi
fi
