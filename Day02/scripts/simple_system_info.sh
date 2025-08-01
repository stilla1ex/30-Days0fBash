#!/bin/bash

# Day 2 Script: Simple System Info
# A basic script demonstrating variables and user input

echo "=== Simple System Information Tool ==="
echo

# Get user input
read -p "Enter your name: " user_name
read -p "What information would you like? (system/network/files): " info_type

# Store system info in variables
hostname=$(hostname)
current_user=$(whoami)
current_date=$(date)
home_dir=$HOME

# Display basic info
echo
echo "=== System Information for $user_name ==="
echo "Generated on: $current_date"
echo "Hostname: $hostname"
echo "Current User: $current_user"
echo "Home Directory: $home_dir"

# Simple conditional based on user choice
case $info_type in
    "system")
        echo
        echo "=== System Details ==="
        echo "Operating System: $(uname -s)"
        echo "Kernel: $(uname -r)"
        echo "Architecture: $(uname -m)"
        ;;
    "network")
        echo
        echo "=== Network Information ==="
        echo "IP Address: $(hostname -I | cut -d' ' -f1)"
        echo "Network Interfaces:"
        ls /sys/class/net/
        ;;
    "files")
        echo
        echo "=== File System Information ==="
        echo "Files in home directory:"
        ls -la $HOME | head -5
        echo "Current directory: $(pwd)"
        ;;
    *)
        echo
        echo "Unknown option. Available options: system, network, files"
        ;;
esac

echo
echo "=== End of Report ==="
