#!/bin/bash

# Day 4 Daily Challenge: Log File Analyzer
# Create a script that analyzes system logs

echo "Log File Analyzer"
echo "================="

# Create sample log file for demonstration
log_file="sample_system.log"
cat > "$log_file" << 'EOF'
2024-01-01 10:00:01 INFO: System startup
2024-01-01 10:00:15 INFO: Service apache2 started
2024-01-01 10:01:30 WARNING: High memory usage detected
2024-01-01 10:02:45 ERROR: Failed to connect to database
2024-01-01 10:03:12 INFO: Database connection restored
2024-01-01 10:05:23 ERROR: Authentication failed for user admin
2024-01-01 10:07:11 INFO: User login successful
2024-01-01 10:10:55 WARNING: Disk space low on /var
2024-01-01 10:12:33 INFO: System backup completed
2024-01-01 10:15:44 ERROR: Network timeout
EOF

echo "Analyzing log file: $log_file"
echo

# Count different log levels
echo "=== Log Level Summary ==="
info_count=0
warning_count=0
error_count=0

while IFS= read -r line; do
    if [[ $line == *"INFO:"* ]]; then
        info_count=$((info_count + 1))
    elif [[ $line == *"WARNING:"* ]]; then
        warning_count=$((warning_count + 1))
    elif [[ $line == *"ERROR:"* ]]; then
        error_count=$((error_count + 1))
    fi
done < "$log_file"

echo "INFO messages: $info_count"
echo "WARNING messages: $warning_count" 
echo "ERROR messages: $error_count"
echo "Total lines: $((info_count + warning_count + error_count))"

echo
echo "=== Error Analysis ==="
echo "Error messages found:"
while IFS= read -r line; do
    if [[ $line == *"ERROR:"* ]]; then
        echo "  - $line"
    fi
done < "$log_file"

echo
echo "=== Time Range Analysis ==="
first_entry=$(head -n 1 "$log_file" | cut -d' ' -f1-2)
last_entry=$(tail -n 1 "$log_file" | cut -d' ' -f1-2)
echo "First log entry: $first_entry"
echo "Last log entry: $last_entry"

echo
echo "=== Service Activity ==="
echo "Services mentioned:"
for service in apache2 database network; do
    count=$(grep -c "$service" "$log_file")
    if [ $count -gt 0 ]; then
        echo "  - $service: $count mentions"
    fi
done

echo
echo "=== Critical Issues ==="
critical_keywords="failed error timeout authentication"
for keyword in $critical_keywords; do
    matches=$(grep -i "$keyword" "$log_file")
    if [ -n "$matches" ]; then
        echo "Critical keyword '$keyword' found:"
        echo "$matches" | head -3
        echo
    fi
done

# Clean up
rm -f "$log_file"

echo "Analysis complete!"
echo
echo "Challenge: Modify this script to:"
echo "1. Accept log file as parameter"
echo "2. Generate reports for different time periods"
echo "3. Send alerts for critical errors"
echo "4. Create summary reports"
