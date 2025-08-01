#!/bin/bash

# Day 2 Exercise: Simple Variables 
# Basic variable concepts without complexity

echo "=== Day 2: Simple Variables Exercise ==="
echo

echo "🎯 PART 1: Creating Variables"
echo

# Basic variables (no spaces around =)
my_name="Security Student"
favorite_tool="nmap"
target_ip="192.168.1.1"
scan_date=$(date +%Y-%m-%d)

echo "My name: $my_name"
echo "Favorite tool: $favorite_tool"
echo "Target IP: $target_ip"
echo "Today's date: $scan_date"
echo

echo "🎯 PART 2: Using Variables in Commands"
echo

# Use variables in commands
echo "Creating a directory with today's date..."
mkdir -p "scan_$scan_date"
echo "Directory created: scan_$scan_date"

echo "Creating a report file..."
report_file="scan_${scan_date}_report.txt"
echo "Scan report for $target_ip" > "$report_file"
echo "Generated on: $scan_date" >> "$report_file"
echo "Report saved as: $report_file"
echo

echo "🎯 PART 3: Environment Variables"
echo

echo "Your username: $USER"
echo "Your home directory: $HOME"
echo "Current directory: $PWD"
echo "Your shell: $SHELL"
echo

echo "🎯 PART 4: Variable Length and Basic Operations"
echo

password="secretpassword123"
echo "Password length: ${#password} characters"

filename="security_scan"
extension=".txt"
full_filename="${filename}${extension}"
echo "Full filename: $full_filename"
echo

echo "🎯 PART 5: Default Values"
echo

# Default values for variables
default_port=${PORT:-80}
default_timeout=${TIMEOUT:-30}

echo "Default port: $default_port"
echo "Default timeout: $default_timeout seconds"
echo

echo "✅ Variables Exercise Complete!"
echo "💡 Key Points:"
echo "   • No spaces around = when creating variables"
echo "   • Use \$variable or \${variable} to access values"
echo "   • Quote variables to prevent word splitting"
echo "   • Environment variables are already set by the system"
