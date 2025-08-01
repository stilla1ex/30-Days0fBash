#!/bin/bash

# Day 2 Exercise 1: Variables and Basic Scripting
# Learn how to create, use, and manipulate variables in bash

echo "=== Day 2: Variables and Basic Scripting ==="
echo

# 1. BASIC VARIABLE CREATION AND USAGE
echo "1. Basic Variable Creation"
echo "Creating variables..."

# Variables in bash (no spaces around =)
username="cybersec_analyst"
target_ip="192.168.1.100"
scan_date=$(date +%Y-%m-%d)
port_count=65535

echo "Username: $username"
echo "Target IP: $target_ip"
echo "Scan Date: $scan_date"
echo "Total Ports: $port_count"

echo -e "\n2. Variable Naming Conventions"
# Good variable names for cybersecurity
EXPLOIT_DB_PATH="/usr/share/exploitdb"
LOG_FILE="/var/log/security.log"
nmap_output_file="scan_results_$(date +%H%M%S).txt"

echo "Exploit DB Path: $EXPLOIT_DB_PATH"
echo "Log File: $LOG_FILE"
echo "Nmap Output: $nmap_output_file"

# 3. ENVIRONMENT VARIABLES
echo -e "\n3. Working with Environment Variables"
echo "Current User: $USER"
echo "Home Directory: $HOME"
echo "Current Shell: $SHELL"
echo "Current Path: $PWD"

# Show PATH variable (formatted)
echo -e "\nPATH directories:"
echo $PATH | tr ':' '\n' | head -5

# 4. VARIABLE OPERATIONS
echo -e "\n4. Variable Operations and Manipulation"

# String concatenation
base_filename="security_scan"
timestamp=$(date +%Y%m%d_%H%M%S)
full_filename="${base_filename}_${timestamp}.log"
echo "Generated filename: $full_filename"

# Variable length
target_domain="example.com"
echo "Domain length: ${#target_domain} characters"

# Default values
backup_dir=${BACKUP_DIR:-"/tmp/backups"}
echo "Backup directory: $backup_dir"

# 5. COMMAND SUBSTITUTION
echo -e "\n5. Command Substitution in Cybersecurity Context"

# Capture command output
current_connections=$(netstat -an | wc -l)
echo "Current network connections: $current_connections"

# System information gathering
system_info=$(uname -a)
echo "System info: $system_info"

# Process monitoring
running_processes=$(ps aux | wc -l)
echo "Running processes: $running_processes"

# 6. ARRAYS (Basic Introduction)
echo -e "\n6. Basic Arrays for Cybersecurity"

# Create array of common ports
common_ports=(22 80 443 21 23 25 53 110 143 993 995)
echo "Common ports to scan: ${common_ports[@]}"
echo "First port: ${common_ports[0]}"
echo "Number of ports: ${#common_ports[@]}"

# Array of target IPs
target_ips=("192.168.1.1" "192.168.1.100" "192.168.1.254")
echo "Target IPs: ${target_ips[@]}"

# 7. VARIABLE SCOPE DEMONSTRATION
echo -e "\n7. Variable Scope"

# Global variable
global_var="Available everywhere"

test_function() {
    local local_var="Only in this function"
    echo "Inside function - Global: $global_var"
    echo "Inside function - Local: $local_var"
}

test_function
echo "Outside function - Global: $global_var"
echo "Outside function - Local: $local_var"  # This will be empty

# 8. PRACTICAL CYBERSECURITY EXAMPLE
echo -e "\n8. Practical Example: Security Scan Preparation"

# Set up variables for a security scan
SCAN_TYPE="nmap"
TARGET="192.168.1.0/24"
OUTPUT_DIR="$HOME/scans"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SCAN_FILE="${OUTPUT_DIR}/${SCAN_TYPE}_${TIMESTAMP}.txt"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "Scan configuration:"
echo "  Type: $SCAN_TYPE"
echo "  Target: $TARGET"
echo "  Output: $SCAN_FILE"
echo "  Timestamp: $TIMESTAMP"

# Simulate creating the scan file
echo "# Security Scan Results" > "$SCAN_FILE"
echo "# Date: $TIMESTAMP" >> "$SCAN_FILE"
echo "# Target: $TARGET" >> "$SCAN_FILE"
echo "✓ Scan file created: $SCAN_FILE"

echo -e "\n=== Variables Exercise Complete! ==="
echo "💡 Key Points:"
echo "   • No spaces around = when assigning variables"
echo "   • Use \${variable} for clarity and concatenation"
echo "   • Command substitution: \$(command) or \`command\`"
echo "   • Environment variables are UPPERCASE by convention"
echo "   • Local variables in functions prevent global pollution"
