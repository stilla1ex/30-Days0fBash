#!/bin/bash

# Day 2 Script: Log Analyzer
# Interactive log analysis tool for cybersecurity

# Configuration
DEFAULT_LOG_DIR="/var/log"
OUTPUT_DIR="log_analysis_reports"
SCRIPT_VERSION="1.0"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Helper functions
print_banner() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════╗"
    echo "║           LOG ANALYZER v1.0          ║"
    echo "║        Cybersecurity Edition         ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${NC}"
}

print_section() {
    echo -e "${CYAN}=== $1 ===${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Create output directory
setup_environment() {
    mkdir -p "$OUTPUT_DIR"
    print_success "Output directory created: $OUTPUT_DIR"
}

# Function to list available log files
list_log_files() {
    print_section "Available Log Files"
    
    if [[ -d "$DEFAULT_LOG_DIR" && -r "$DEFAULT_LOG_DIR" ]]; then
        echo "Log files in $DEFAULT_LOG_DIR:"
        ls -la "$DEFAULT_LOG_DIR"/*.log 2>/dev/null | while read -r line; do
            echo "  $line"
        done
        
        # Check for common security logs
        common_logs=("auth.log" "secure" "syslog" "messages" "kern.log")
        echo -e "\nCommon security logs:"
        for log in "${common_logs[@]}"; do
            if [[ -f "$DEFAULT_LOG_DIR/$log" ]]; then
                print_success "$log (accessible)"
            else
                print_warning "$log (not found or no access)"
            fi
        done
    else
        print_error "Cannot access $DEFAULT_LOG_DIR"
        echo "Try running with elevated privileges or specify a custom log directory"
    fi
}

# Function to analyze authentication logs
analyze_auth_logs() {
    local log_file="$1"
    local output_file="$OUTPUT_DIR/auth_analysis_$(date +%Y%m%d_%H%M%S).txt"
    
    print_section "Authentication Log Analysis"
    
    if [[ ! -f "$log_file" ]]; then
        print_error "Log file not found: $log_file"
        return 1
    fi
    
    if [[ ! -r "$log_file" ]]; then
        print_error "Cannot read log file: $log_file"
        return 1
    fi
    
    {
        echo "=== AUTHENTICATION LOG ANALYSIS ==="
        echo "File: $log_file"
        echo "Analysis Date: $(date)"
        echo "File Size: $(ls -lh "$log_file" | awk '{print $5}')"
        echo "Last Modified: $(ls -l "$log_file" | awk '{print $6, $7, $8}')"
        echo
        
        echo "=== FAILED LOGIN ATTEMPTS ==="
        failed_attempts=$(grep -i "failed password\|authentication failure\|invalid user" "$log_file" 2>/dev/null | wc -l)
        echo "Total failed login attempts: $failed_attempts"
        
        if [[ $failed_attempts -gt 0 ]]; then
            echo -e "\nTop 10 IPs with failed attempts:"
            grep -i "failed password\|authentication failure" "$log_file" 2>/dev/null | \
                awk '{for(i=1;i<=NF;i++) if($i ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/) print $i}' | \
                sort | uniq -c | sort -rn | head -10
            
            echo -e "\nFailed login usernames:"
            grep -i "failed password" "$log_file" 2>/dev/null | \
                awk '/user/ {for(i=1;i<=NF;i++) if($i=="user") print $(i+1)}' | \
                sort | uniq -c | sort -rn | head -10
        fi
        echo
        
        echo "=== SUCCESSFUL LOGINS ==="
        successful_logins=$(grep -i "accepted password\|session opened" "$log_file" 2>/dev/null | wc -l)
        echo "Total successful logins: $successful_logins"
        
        if [[ $successful_logins -gt 0 ]]; then
            echo -e "\nRecent successful logins:"
            grep -i "accepted password\|session opened" "$log_file" 2>/dev/null | tail -10
        fi
        echo
        
        echo "=== UNUSUAL ACTIVITIES ==="
        echo "Root login attempts:"
        grep -i "root" "$log_file" 2>/dev/null | grep -i "failed\|invalid" | wc -l
        
        echo "After-hours activities (outside 9-17):"
        grep -E "(0[0-8]|1[89]|2[0-3]):" "$log_file" 2>/dev/null | wc -l
        
        echo "Weekend activities:"
        grep -E "(Sat|Sun)" "$log_file" 2>/dev/null | wc -l
        echo
        
        echo "=== SUMMARY ==="
        echo "Analysis completed: $(date)"
        echo "Report saved to: $output_file"
        
    } | tee "$output_file"
    
    print_success "Authentication analysis completed: $output_file"
}

# Function to analyze system logs
analyze_system_logs() {
    local log_file="$1"
    local output_file="$OUTPUT_DIR/system_analysis_$(date +%Y%m%d_%H%M%S).txt"
    
    print_section "System Log Analysis"
    
    if [[ ! -f "$log_file" ]]; then
        print_error "Log file not found: $log_file"
        return 1
    fi
    
    {
        echo "=== SYSTEM LOG ANALYSIS ==="
        echo "File: $log_file"
        echo "Analysis Date: $(date)"
        echo
        
        echo "=== ERROR MESSAGES ==="
        error_count=$(grep -i "error\|fail\|critical" "$log_file" 2>/dev/null | wc -l)
        echo "Total error messages: $error_count"
        
        if [[ $error_count -gt 0 ]]; then
            echo -e "\nRecent errors:"
            grep -i "error\|fail\|critical" "$log_file" 2>/dev/null | tail -10
        fi
        echo
        
        echo "=== WARNING MESSAGES ==="
        warning_count=$(grep -i "warning\|warn" "$log_file" 2>/dev/null | wc -l)
        echo "Total warning messages: $warning_count"
        
        if [[ $warning_count -gt 0 ]]; then
            echo -e "\nRecent warnings:"
            grep -i "warning\|warn" "$log_file" 2>/dev/null | tail -5
        fi
        echo
        
        echo "=== NETWORK ACTIVITIES ==="
        network_count=$(grep -i "network\|connection\|interface" "$log_file" 2>/dev/null | wc -l)
        echo "Network-related entries: $network_count"
        
        echo "=== SERVICE STATUS ==="
        service_starts=$(grep -i "started\|starting" "$log_file" 2>/dev/null | wc -l)
        service_stops=$(grep -i "stopped\|stopping" "$log_file" 2>/dev/null | wc -l)
        echo "Service starts: $service_starts"
        echo "Service stops: $service_stops"
        
    } | tee "$output_file"
    
    print_success "System log analysis completed: $output_file"
}

# Function to search for specific patterns
search_patterns() {
    local log_file="$1"
    local pattern="$2"
    local output_file="$OUTPUT_DIR/pattern_search_$(date +%Y%m%d_%H%M%S).txt"
    
    print_section "Pattern Search Results"
    
    if [[ ! -f "$log_file" ]]; then
        print_error "Log file not found: $log_file"
        return 1
    fi
    
    {
        echo "=== PATTERN SEARCH RESULTS ==="
        echo "File: $log_file"
        echo "Pattern: $pattern"
        echo "Search Date: $(date)"
        echo
        
        echo "=== MATCHES ==="
        matches=$(grep -i "$pattern" "$log_file" 2>/dev/null | wc -l)
        echo "Total matches: $matches"
        
        if [[ $matches -gt 0 ]]; then
            echo -e "\nMatching entries:"
            grep -i "$pattern" "$log_file" 2>/dev/null | head -20
            
            if [[ $matches -gt 20 ]]; then
                echo "... (showing first 20 of $matches matches)"
            fi
        fi
        
    } | tee "$output_file"
    
    print_success "Pattern search completed: $output_file"
}

# Function to generate summary report
generate_summary() {
    local log_directory="$1"
    local output_file="$OUTPUT_DIR/log_summary_$(date +%Y%m%d_%H%M%S).txt"
    
    print_section "Generating Summary Report"
    
    {
        echo "=== LOG DIRECTORY SUMMARY ==="
        echo "Directory: $log_directory"
        echo "Report Date: $(date)"
        echo
        
        echo "=== AVAILABLE LOG FILES ==="
        if [[ -d "$log_directory" ]]; then
            ls -la "$log_directory"/*.log 2>/dev/null || echo "No .log files found"
        else
            echo "Directory not accessible: $log_directory"
        fi
        echo
        
        echo "=== DISK USAGE ==="
        if [[ -d "$log_directory" ]]; then
            du -sh "$log_directory" 2>/dev/null || echo "Cannot calculate disk usage"
            echo
            echo "Largest log files:"
            find "$log_directory" -name "*.log" -type f -exec ls -lh {} \; 2>/dev/null | sort -k5 -hr | head -5
        fi
        echo
        
        echo "=== RECENT ACTIVITY ==="
        echo "Files modified in the last 24 hours:"
        find "$log_directory" -name "*.log" -mtime -1 2>/dev/null | head -10
        
    } | tee "$output_file"
    
    print_success "Summary report completed: $output_file"
}

# Interactive menu
show_menu() {
    echo
    echo "Log Analysis Options:"
    echo "1. List available log files"
    echo "2. Analyze authentication logs"
    echo "3. Analyze system logs"
    echo "4. Search for specific patterns"
    echo "5. Generate summary report"
    echo "6. Custom log file analysis"
    echo "7. Exit"
    echo
}

# Main execution loop
main() {
    print_banner
    setup_environment
    
    while true; do
        show_menu
        read -p "Select an option (1-7): " choice
        
        case $choice in
            1)
                list_log_files
                ;;
            2)
                read -p "Enter path to auth log file (or press Enter for /var/log/auth.log): " auth_log
                auth_log=${auth_log:-"/var/log/auth.log"}
                analyze_auth_logs "$auth_log"
                ;;
            3)
                read -p "Enter path to system log file (or press Enter for /var/log/syslog): " sys_log
                sys_log=${sys_log:-"/var/log/syslog"}
                analyze_system_logs "$sys_log"
                ;;
            4)
                read -p "Enter log file path: " search_file
                read -p "Enter search pattern: " search_pattern
                search_patterns "$search_file" "$search_pattern"
                ;;
            5)
                read -p "Enter log directory (or press Enter for /var/log): " log_dir
                log_dir=${log_dir:-"/var/log"}
                generate_summary "$log_dir"
                ;;
            6)
                read -p "Enter custom log file path: " custom_log
                if [[ -f "$custom_log" ]]; then
                    echo "Select analysis type:"
                    echo "1. Authentication analysis"
                    echo "2. System analysis"
                    read -p "Choice (1-2): " analysis_type
                    case $analysis_type in
                        1) analyze_auth_logs "$custom_log" ;;
                        2) analyze_system_logs "$custom_log" ;;
                        *) print_error "Invalid choice" ;;
                    esac
                else
                    print_error "File not found: $custom_log"
                fi
                ;;
            7)
                print_success "Goodbye!"
                exit 0
                ;;
            *)
                print_error "Invalid choice. Please select 1-7."
                ;;
        esac
        
        echo
        read -p "Press Enter to continue..."
    done
}

# Run the script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
