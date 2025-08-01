#!/bin/bash

# Day 2 Exercise 3: Input/Output Redirection and Text Processing
# Master I/O operations for cybersecurity tasks

echo "=== Day 2: Input/Output Redirection ==="
echo

# Create a working directory for this exercise
mkdir -p io_exercise_workspace
cd io_exercise_workspace

# 1. BASIC OUTPUT REDIRECTION
echo "1. Basic Output Redirection"

# Redirect output to file
echo "Creating sample security data..."
echo "192.168.1.100 - Successful login" > security.log
echo "192.168.1.101 - Failed login attempt" >> security.log
echo "192.168.1.102 - Successful login" >> security.log
echo "192.168.1.103 - Failed login attempt" >> security.log

echo "✓ Security log created:"
cat security.log

# 2. ERROR REDIRECTION
echo -e "\n2. Error Redirection"

# Redirect errors to separate file
echo "Testing error redirection..."
ls /nonexistent_directory 2> errors.log
ls /etc/passwd >> output.log 2>> errors.log

echo "Standard output:"
cat output.log 2>/dev/null
echo -e "\nErrors captured:"
cat errors.log 2>/dev/null

# 3. COMBINING OUTPUT AND ERRORS
echo -e "\n3. Combining Output and Errors"

# Redirect both stdout and stderr
echo "Testing combined redirection..."
(ls /etc/passwd && ls /nonexistent) > combined.log 2>&1

echo "Combined output and errors:"
cat combined.log

# 4. INPUT REDIRECTION
echo -e "\n4. Input Redirection"

# Create a list of IPs to process
cat << EOF > ip_list.txt
192.168.1.1
192.168.1.100
192.168.1.200
10.0.0.1
172.16.0.1
EOF

echo "Processing IPs from file..."
while read -r ip; do
    echo "Processing IP: $ip"
    # In real scenario: ping -c 1 "$ip" >/dev/null && echo "$ip is up"
done < ip_list.txt

# 5. HERE DOCUMENTS AND HERE STRINGS
echo -e "\n5. Here Documents and Here Strings"

# Here document to create configuration file
cat << 'CONFIG' > nmap_config.txt
# Nmap Configuration
# Common scan options

# Quick scan
nmap -F target

# Stealth scan  
nmap -sS target

# UDP scan
nmap -sU target

# OS detection
nmap -O target
CONFIG

echo "Configuration file created:"
cat nmap_config.txt

# Here string example
echo -e "\nProcessing with here string:"
grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' <<< "Server IP: 192.168.1.50 connected"

# 6. PIPES AND TEXT PROCESSING
echo -e "\n6. Pipes and Text Processing"

# Create sample log data
cat << 'LOGS' > sample_access.log
192.168.1.100 - - [01/Aug/2025:10:15:23] "GET /login.php HTTP/1.1" 200 1234
192.168.1.101 - - [01/Aug/2025:10:16:45] "POST /login.php HTTP/1.1" 401 567
192.168.1.102 - - [01/Aug/2025:10:17:12] "GET /admin.php HTTP/1.1" 403 234
192.168.1.100 - - [01/Aug/2025:10:18:33] "GET /index.html HTTP/1.1" 200 5678
192.168.1.103 - - [01/Aug/2025:10:19:44] "POST /login.php HTTP/1.1" 401 567
LOGS

echo "Sample access log created. Analyzing..."

# Extract unique IP addresses
echo -e "\nUnique IP addresses:"
cat sample_access.log | cut -d' ' -f1 | sort | uniq

# Count failed login attempts (401 status)
echo -e "\nFailed login attempts:"
grep "401" sample_access.log | wc -l

# Show failed login IPs
echo -e "\nIPs with failed logins:"
grep "401" sample_access.log | cut -d' ' -f1 | sort | uniq

# 7. ADVANCED TEXT PROCESSING
echo -e "\n7. Advanced Text Processing with awk and sed"

# Using awk for log analysis
echo "Top IPs by request count:"
awk '{print $1}' sample_access.log | sort | uniq -c | sort -nr

# Using sed for text replacement
echo -e "\nMasking IPs for privacy:"
sed 's/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/XXX.XXX.XXX.XXX/g' sample_access.log | head -2

# 8. PRACTICAL CYBERSECURITY EXAMPLES
echo -e "\n8. Practical Cybersecurity I/O Examples"

# Function to analyze logs
analyze_logs() {
    local logfile=$1
    echo "=== Log Analysis Report ==="
    echo "File: $logfile"
    echo "Total entries: $(wc -l < "$logfile")"
    echo "Unique IPs: $(cut -d' ' -f1 "$logfile" | sort | uniq | wc -l)"
    echo "Failed attempts (401): $(grep -c "401" "$logfile")"
    echo "Success attempts (200): $(grep -c "200" "$logfile")"
}

analyze_logs sample_access.log

# Create a security monitoring script template
cat << 'MONITOR' > security_monitor.sh
#!/bin/bash
# Security Monitoring Script Template

LOG_FILE="/var/log/auth.log"
REPORT_FILE="security_report_$(date +%Y%m%d).txt"

# Monitor failed login attempts
echo "=== Security Report $(date) ===" > "$REPORT_FILE"
echo >> "$REPORT_FILE"

echo "Recent Failed SSH Attempts:" >> "$REPORT_FILE"
grep "Failed password" "$LOG_FILE" 2>/dev/null | tail -10 >> "$REPORT_FILE" || echo "No SSH log access" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"
echo "Unique Failed Login IPs:" >> "$REPORT_FILE"
grep "Failed password" "$LOG_FILE" 2>/dev/null | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr >> "$REPORT_FILE" || echo "No data available" >> "$REPORT_FILE"

echo "Report saved to: $REPORT_FILE"
MONITOR

chmod +x security_monitor.sh
echo "✓ Security monitoring script created: security_monitor.sh"

# 9. COMMAND SUBSTITUTION AND PROCESS SUBSTITUTION
echo -e "\n9. Command Substitution and Process Substitution"

# Command substitution
current_time=$(date)
echo "Report generated at: $current_time"

# Process substitution example
echo "Comparing two file lists:"
echo "Files in current directory:" > dir1.txt
ls -1 >> dir1.txt
echo "Files in /etc (first 10):" > dir2.txt
ls -1 /etc 2>/dev/null | head -10 >> dir2.txt || echo "No access to /etc" >> dir2.txt

# Show difference (if files exist)
if [[ -f dir1.txt && -f dir2.txt ]]; then
    echo "Different files between directories:"
    diff <(sort dir1.txt) <(sort dir2.txt) | head -5
fi

# 10. CLEANUP AND SUMMARY
echo -e "\n10. File Summary"
echo "Files created in this exercise:"
ls -la

# Go back to original directory
cd ..

echo -e "\n=== I/O Redirection Exercise Complete! ==="
echo "💡 Key Points:"
echo "   • > redirects output (overwrites)"
echo "   • >> redirects output (appends)"
echo "   • 2> redirects errors"
echo "   • 2>&1 combines output and errors"
echo "   • < redirects input from file"
echo "   • | pipes output to next command"
echo "   • << creates here documents"
echo "   • <<< creates here strings"
echo "   • Command substitution: \$(command)"
echo "   • Process substitution: <(command)"
