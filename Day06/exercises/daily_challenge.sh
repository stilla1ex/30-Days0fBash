#!/bin/bash

# Day 6 Daily Challenge: Advanced Log File Analyzer
# Create a comprehensive log analysis tool

echo "Day 6 Challenge: Advanced Log File Analyzer"
echo "==========================================="

# Create comprehensive sample log file
cat > webserver.log << 'EOF'
192.168.1.100 - - [01/Jan/2024:08:00:01 +0000] "GET /index.html HTTP/1.1" 200 1234 "-" "Mozilla/5.0"
10.0.0.55 - - [01/Jan/2024:08:00:15 +0000] "POST /login HTTP/1.1" 401 567 "-" "curl/7.68.0"
172.16.0.10 - - [01/Jan/2024:08:01:30 +0000] "GET /admin HTTP/1.1" 403 234 "-" "Mozilla/5.0"
192.168.1.100 - - [01/Jan/2024:08:02:45 +0000] "GET /data.json HTTP/1.1" 200 5678 "/index.html" "Mozilla/5.0"
203.0.113.5 - - [01/Jan/2024:08:03:12 +0000] "GET /api/users HTTP/1.1" 500 0 "-" "Python-requests/2.25.1"
192.168.1.101 - - [01/Jan/2024:08:05:23 +0000] "DELETE /files HTTP/1.1" 200 89 "/admin" "Mozilla/5.0"
10.0.0.66 - - [01/Jan/2024:08:07:11 +0000] "GET /login HTTP/1.1" 200 1111 "-" "Mozilla/5.0"
192.168.1.100 - - [01/Jan/2024:08:08:33 +0000] "POST /upload HTTP/1.1" 413 0 "/admin" "Mozilla/5.0"
172.16.0.15 - - [01/Jan/2024:08:10:45 +0000] "GET /backup.zip HTTP/1.1" 404 333 "-" "wget/1.20.3"
203.0.113.5 - - [01/Jan/2024:08:12:01 +0000] "GET /admin HTTP/1.1" 401 567 "-" "Python-requests/2.25.1"
EOF

echo "Sample web server log created (webserver.log):"
echo "Analyzing access patterns, errors, and security events..."
echo

echo "=== LOG ANALYSIS REPORT ==="
echo

echo "1. BASIC STATISTICS"
echo "==================="
total_requests=$(wc -l < webserver.log)
echo "Total requests: $total_requests"

unique_ips=$(awk '{print $1}' webserver.log | sort | uniq | wc -l)
echo "Unique IP addresses: $unique_ips"

echo

echo "2. STATUS CODE ANALYSIS"
echo "======================"
echo "Status code distribution:"
awk '{print $9}' webserver.log | sort | uniq -c | sort -nr | while read count code; do
    case $code in
        200) echo "  $code (Success): $count requests" ;;
        401) echo "  $code (Unauthorized): $count requests" ;;
        403) echo "  $code (Forbidden): $count requests" ;;
        404) echo "  $code (Not Found): $count requests" ;;
        413) echo "  $code (Payload Too Large): $count requests" ;;
        500) echo "  $code (Server Error): $count requests" ;;
        *) echo "  $code (Other): $count requests" ;;
    esac
done

echo

echo "3. ERROR ANALYSIS"
echo "================"
error_count=$(awk '$9 >= 400 {print}' webserver.log | wc -l)
echo "Total error requests (4xx/5xx): $error_count"

echo
echo "Error breakdown:"
awk '$9 >= 400 {print $9}' webserver.log | sort | uniq -c | sort -nr

echo
echo "Top error URLs:"
awk '$9 >= 400 {print $7}' webserver.log | sort | uniq -c | sort -nr

echo

echo "4. TRAFFIC ANALYSIS"
echo "=================="
echo "Top IP addresses by request count:"
awk '{print $1}' webserver.log | sort | uniq -c | sort -nr | head -5

echo
echo "Most requested URLs:"
awk '{print $7}' webserver.log | sort | uniq -c | sort -nr | head -5

echo
echo "Request methods:"
awk '{print $6}' webserver.log | sed 's/"//g' | sort | uniq -c | sort -nr

echo

echo "5. SECURITY ANALYSIS"
echo "==================="
echo "Failed login attempts (401 status):"
awk '$9 == 401 {print $1, $4, $7}' webserver.log

echo
echo "Admin access attempts:"
awk '$7 ~ /admin/ {print $1, $4, $9, $7}' webserver.log

echo
echo "Suspicious user agents:"
grep -E "(curl|wget|Python)" webserver.log | awk '{for(i=12;i<=NF;i++) printf "%s ", $i; print ""}'

echo

echo "6. TRAFFIC PATTERNS"
echo "=================="
echo "Hourly request distribution:"
awk '{print $4}' webserver.log | sed 's/\[//g' | cut -d: -f2 | sort | uniq -c

echo
echo "Bytes transferred analysis:"
total_bytes=$(awk '{sum += $10} END {print sum}' webserver.log)
avg_bytes=$(awk '{sum += $10; count++} END {print int(sum/count)}' webserver.log)
echo "Total bytes transferred: $total_bytes"
echo "Average bytes per request: $avg_bytes"

echo

echo "7. DETAILED FILTERING EXAMPLES"
echo "=============================="

echo "Large file requests (>1000 bytes):"
awk '$10 > 1000 {print $1, $7, $10}' webserver.log

echo
echo "Private IP addresses:"
grep -E '^(192\.168|10\.|172\.16)' webserver.log | awk '{print $1}' | sort | uniq

echo
echo "External IP addresses:"
grep -vE '^(192\.168|10\.|172\.16)' webserver.log | awk '{print $1}' | sort | uniq

echo

echo "8. SECURITY SUMMARY"
echo "=================="
failed_logins=$(awk '$9 == 401' webserver.log | wc -l)
admin_attempts=$(awk '$7 ~ /admin/' webserver.log | wc -l)
external_requests=$(grep -vE '^(192\.168|10\.|172\.16)' webserver.log | wc -l)

echo "Security metrics:"
echo "  Failed authentication attempts: $failed_logins"
echo "  Admin page access attempts: $admin_attempts"
echo "  External IP requests: $external_requests"

if [ $failed_logins -gt 2 ]; then
    echo "  [WARNING] High number of failed logins detected"
fi

if [ $admin_attempts -gt 3 ]; then
    echo "  [WARNING] High number of admin access attempts"
fi

echo

echo "9. CUSTOM REPORT GENERATION"
echo "=========================="
report_file="log_analysis_$(date +%Y%m%d_%H%M%S).txt"

cat > "$report_file" << EOF
WEB SERVER LOG ANALYSIS REPORT
==============================
Generated: $(date)
Log file: webserver.log
Analysis period: $(head -1 webserver.log | awk '{print $4}' | sed 's/\[//g') to $(tail -1 webserver.log | awk '{print $4}' | sed 's/\[//g')

SUMMARY STATISTICS:
- Total requests: $total_requests
- Unique IPs: $unique_ips
- Error requests: $error_count
- Failed logins: $failed_logins
- Admin attempts: $admin_attempts

TOP IP ADDRESSES:
$(awk '{print $1}' webserver.log | sort | uniq -c | sort -nr | head -3)

TOP REQUESTED URLs:
$(awk '{print $7}' webserver.log | sort | uniq -c | sort -nr | head -3)

SECURITY ALERTS:
$([ $failed_logins -gt 2 ] && echo "- High failed login count: $failed_logins")
$([ $admin_attempts -gt 3 ] && echo "- High admin access attempts: $admin_attempts")
EOF

echo "Detailed report saved to: $report_file"

# Clean up
rm -f webserver.log

echo
echo "Challenge Complete!"
echo
echo "What you accomplished:"
echo "   - Analyzed web server logs comprehensively"
echo "   - Used awk for field extraction and calculations"
echo "   - Applied grep for pattern matching"
echo "   - Created detailed statistical analysis"
echo "   - Identified security issues and patterns"
echo "   - Generated automated reports"
echo "   - Combined multiple text processing tools"
echo
echo "Skills demonstrated:"
echo "   - Log parsing and analysis"
echo "   - Statistical data processing"
echo "   - Security monitoring techniques"
echo "   - Report generation automation"
echo "   - Advanced text processing pipelines"
