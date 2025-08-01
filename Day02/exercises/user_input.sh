#!/bin/bash

# Day 2 Exercise 2: User Input and Interactive Scripts
# Learn to create interactive cybersecurity tools

echo "=== Day 2: User Input and Interactive Scripts ==="
echo

# 1. BASIC USER INPUT
echo "1. Basic User Input with read command"
echo

# Simple input
echo -n "Enter your name: "
read user_name
echo "Hello, $user_name! Welcome to cybersecurity scripting."

# Input with prompt
read -p "Enter target IP address: " target_ip
echo "You entered: $target_ip"

# 2. INPUT VALIDATION
echo -e "\n2. Input Validation"

# Validate IP address format (basic)
while true; do
    read -p "Enter a valid IP address (e.g., 192.168.1.1): " ip_address
    
    # Basic IP validation using regex
    if [[ $ip_address =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        echo "✓ Valid IP format: $ip_address"
        break
    else
        echo "✗ Invalid IP format. Please try again."
    fi
done

# 3. DIFFERENT INPUT TYPES
echo -e "\n3. Different Types of Input"

# Silent input (for passwords)
echo -n "Enter password (hidden): "
read -s password
echo  # New line after hidden input
echo "Password entered (length: ${#password} characters)"

# Input with timeout
echo -n "You have 5 seconds to enter your choice (y/n): "
if read -t 5 -n 1 choice; then
    echo -e "\nYou chose: $choice"
else
    echo -e "\nTimeout! Defaulting to 'n'"
    choice="n"
fi

# 4. MENU SYSTEM
echo -e "\n4. Interactive Menu System"

show_menu() {
    echo "=== Cybersecurity Tool Menu ==="
    echo "1. Network Scan"
    echo "2. Port Scan"
    echo "3. System Information"
    echo "4. Log Analysis"
    echo "5. Exit"
    echo "=========================="
}

while true; do
    show_menu
    read -p "Choose an option (1-5): " choice
    
    case $choice in
        1)
            echo "🌐 Starting network scan..."
            read -p "Enter network range (e.g., 192.168.1.0/24): " network
            echo "Scanning network: $network"
            # Here you would run: nmap -sn $network
            echo "✓ Network scan completed"
            ;;
        2)
            echo "🔍 Starting port scan..."
            read -p "Enter target IP: " target
            read -p "Enter port range (e.g., 1-1000): " ports
            echo "Scanning ports $ports on $target"
            # Here you would run: nmap -p $ports $target
            echo "✓ Port scan completed"
            ;;
        3)
            echo "💻 Gathering system information..."
            echo "Hostname: $(hostname)"
            echo "OS: $(uname -s)"
            echo "Kernel: $(uname -r)"
            echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
            ;;
        4)
            echo "📊 Log analysis options:"
            echo "Available log files:"
            ls -la /var/log/ 2>/dev/null | head -5 || echo "No access to /var/log/"
            read -p "Enter log file to analyze: " logfile
            if [[ -f "$logfile" ]]; then
                echo "Last 5 lines of $logfile:"
                tail -5 "$logfile" 2>/dev/null || echo "Cannot read file"
            else
                echo "File not found or not accessible"
            fi
            ;;
        5)
            echo "👋 Goodbye!"
            break
            ;;
        *)
            echo "❌ Invalid option. Please choose 1-5."
            ;;
    esac
    
    echo
    read -p "Press Enter to continue..."
    echo
done

# 5. COMMAND LINE ARGUMENTS
echo -e "\n5. Command Line Arguments"
echo "This script was called with $# arguments"

if [[ $# -gt 0 ]]; then
    echo "Arguments provided:"
    echo "  Script name: $0"
    echo "  First argument: $1"
    echo "  Second argument: $2"
    echo "  All arguments: $@"
    echo "  All arguments (quoted): \"\$@\""
else
    echo "No arguments provided. Try running:"
    echo "  $0 target_ip scan_type"
    echo "  Example: $0 192.168.1.1 nmap"
fi

# 6. PRACTICAL EXAMPLE: SECURITY SCANNER CONFIGURATOR
echo -e "\n6. Practical Example: Security Scanner Setup"

configure_scanner() {
    echo "=== Security Scanner Configuration ==="
    
    # Get scan parameters
    read -p "Target IP or range: " scan_target
    
    echo "Select scan type:"
    echo "1. Quick scan (top 100 ports)"
    echo "2. Full scan (all 65535 ports)"
    echo "3. Stealth scan (SYN scan)"
    echo "4. UDP scan"
    
    read -p "Choose scan type (1-4): " scan_type
    
    case $scan_type in
        1) scan_options="-F" ;;
        2) scan_options="-p-" ;;
        3) scan_options="-sS" ;;
        4) scan_options="-sU" ;;
        *) scan_options="-sS"; echo "Invalid choice, using stealth scan" ;;
    esac
    
    read -p "Output file name (without extension): " output_name
    output_file="${output_name}_$(date +%Y%m%d_%H%M%S).txt"
    
    echo
    echo "=== Scan Configuration Summary ==="
    echo "Target: $scan_target"
    echo "Options: $scan_options"
    echo "Output: $output_file"
    echo
    
    read -p "Proceed with scan? (y/n): " confirm
    
    if [[ $confirm == "y" || $confirm == "Y" ]]; then
        echo "Would execute: nmap $scan_options $scan_target -oN $output_file"
        echo "✓ Configuration saved for manual execution"
    else
        echo "Scan cancelled"
    fi
}

configure_scanner

echo -e "\n=== User Input Exercise Complete! ==="
echo "💡 Key Points:"
echo "   • Use 'read' command for user input"
echo "   • Validate input to prevent errors"
echo "   • Use 'case' statements for menu systems"
echo "   • Command line arguments: \$1, \$2, \$@, \$#"
echo "   • Silent input with 'read -s' for passwords"
