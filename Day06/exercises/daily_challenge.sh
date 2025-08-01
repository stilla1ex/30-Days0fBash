#!/bin/bash

# Day 6 Daily Challenge: Comprehensive Log Analyzer
# Build a complete log analysis tool using sed, awk, and grep

echo "Day 6 Challenge: Log File Analyzer"
echo "=================================="

# Create comprehensive log file for analysis
log_file="server_access.log"
cat > "$log_file" << 'EOF'
192.168.1.100 - - [01/Aug/2025:08:15:30 +0000] "GET /index.html HTTP/1.1" 200 1024 "-" "Mozilla/5.0"
203.0.113.50 - - [01/Aug/2025:08:16:45 +0000] "POST /login HTTP/1.1" 200 512 "/index.html" "Chrome/91.0"
192.168.1.101 - - [01/Aug/2025:08:17:20 +0000] "GET /admin HTTP/1.1" 404 256 "/login" "Firefox/89.0"
198.51.100.75 - - [01/Aug/2025:08:18:15 +0000] "GET /api/users HTTP/1.1" 401 128 "-" "curl/7.68.0"
192.168.1.100 - - [01/Aug/2025:08:19:30 +0000] "GET /data.json HTTP/1.1" 200 2048 "/admin" "Mozilla/5.0"
203.0.113.50 - - [01/Aug/2025:08:20:45 +0000] "GET /images/logo.png HTTP/1.1" 200 4096 "/index.html" "Chrome/91.0"
198.51.100.75 - - [01/Aug/2025:08:21:20 +0000] "POST /api/login HTTP/1.1" 403 64 "-" "Python-requests/2.25.1"
192.168.1.102 - - [01/Aug/2025:08:22:15 +0000] "GET /dashboard HTTP/1.1" 200 8192 "/login" "Safari/14.1"
203.0.113.60 - - [01/Aug/2025:08:23:30 +0000] "GET /admin/users HTTP/1.1" 500 1024 "/admin" "Mozilla/5.0"
192.168.1.100 - - [01/Aug/2025:08:24:45 +0000] "DELETE /api/user/123 HTTP/1.1" 204 0 "/dashboard" "Mozilla/5.0"
198.51.100.75 - - [01/Aug/2025:08:25:20 +0000] "GET /config.php HTTP/1.1" 404 256 "-" "curl/7.68.0"
203.0.113.50 - - [01/Aug/2025:08:26:15 +0000] "GET /backup.sql HTTP/1.1" 404 256 "-" "wget/1.20.3"
192.168.1.103 - - [01/Aug/2025:08:27:30 +0000] "GET /health HTTP/1.1" 200 32 "-" "StatusCheck/1.0"
EOF

echo "Analyzing server access log: $log_file"
echo "Log contains $(wc -l < $log_file) entries"
echo

echo "=== BASIC STATISTICS ==="
echo

# Total requests
total_requests=$(wc -l < "$log_file")
echo "Total requests: $total_requests"

# Unique IP addresses
unique_ips=$(awk '{print $1}' "$log_file" | sort | uniq | wc -l)
echo "Unique IP addresses: $unique_ips"

# Date range
first_date=$(head -1 "$log_file" | sed 's/.*\[\([^:]*\).*/\1/')
last_date=$(tail -1 "$log_file" | sed 's/.*\[\([^:]*\).*/\1/')
echo "Date range: $first_date to $last_date"

echo

echo "=== HTTP STATUS CODE ANALYSIS ==="
echo

# Count by status code
echo "Status code distribution:"
awk '{print $9}' "$log_file" | sort | uniq -c | sort -nr | while read count code; do
    case $code in
        200) status="OK" ;;
        204) status="No Content" ;;
        401) status="Unauthorized" ;;
        403) status="Forbidden" ;;
        404) status="Not Found" ;;
        500) status="Server Error" ;;
        *) status="Other" ;;
    esac
    echo "  $code ($status): $count requests"
done

echo

echo "=== TOP IP ADDRESSES ==="
echo

echo "Most active IP addresses:"
awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -5 | while read count ip; do
    # Determine if IP is internal or external
    if echo "$ip" | grep -q "^192\.168\."; then
        location="Internal"
    else
        location="External"
    fi
    echo "  $ip: $count requests ($location)"
done

echo

echo "=== REQUEST ANALYSIS ==="
echo

echo "Most requested resources:"
awk '{print $7}' "$log_file" | sort | uniq -c | sort -nr | head -5 | while read count resource; do
    echo "  $resource: $count requests"
done

echo
echo "HTTP methods used:"
awk '{print $6}' "$log_file" | sed 's/"//g' | sort | uniq -c | sort -nr | while read count method; do
    echo "  $method: $count requests"
done

echo

echo "=== SECURITY ANALYSIS ==="
echo

echo "Potential security issues:"

# 404 errors (possible reconnaissance)
not_found_count=$(grep " 404 " "$log_file" | wc -l)
echo "  404 Not Found errors: $not_found_count"
if [ $not_found_count -gt 0 ]; then
    echo "    Requested non-existent resources:"
    grep " 404 " "$log_file" | awk '{print "      " $1 " -> " $7}' | sort | uniq
fi

echo

# Unauthorized access attempts
unauth_count=$(grep " 401 " "$log_file" | wc -l)
echo "  401 Unauthorized attempts: $unauth_count"
if [ $unauth_count -gt 0 ]; then
    echo "    Unauthorized access from:"
    grep " 401 " "$log_file" | awk '{print "      " $1 " -> " $7}' | sort | uniq
fi

echo

# Forbidden access attempts
forbidden_count=$(grep " 403 " "$log_file" | wc -l)
echo "  403 Forbidden attempts: $forbidden_count"
if [ $forbidden_count -gt 0 ]; then
    echo "    Forbidden access from:"
    grep " 403 " "$log_file" | awk '{print "      " $1 " -> " $7}' | sort | uniq
fi

echo

# Server errors
server_error_count=$(grep " 5[0-9][0-9] " "$log_file" | wc -l)
echo "  5xx Server errors: $server_error_count"
if [ $server_error_count -gt 0 ]; then
    echo "    Server errors:"
    grep " 5[0-9][0-9] " "$log_file" | awk '{print "      " $9 " " $7 " from " $1}' | sort | uniq
fi

echo

echo "=== TRAFFIC PATTERNS ==="
echo

echo "Traffic by hour:"
awk '{print $4}' "$log_file" | sed 's/.*:\([0-9][0-9]\):.*/\1/' | sort | uniq -c | while read count hour; do
    echo "  ${hour}:00 - $count requests"
done

echo

echo "=== USER AGENT ANALYSIS ==="
echo

echo "Top user agents:"
awk -F'"' '{print $6}' "$log_file" | cut -d' ' -f1 | sort | uniq -c | sort -nr | head -5 | while read count agent; do
    case $agent in
        Mozilla*) category="Browser" ;;
        Chrome*) category="Browser" ;;
        Firefox*) category="Browser" ;;
        Safari*) category="Browser" ;;
        curl*) category="CLI Tool" ;;
        wget*) category="CLI Tool" ;;
        Python*) category="Script" ;;
        *) category="Other" ;;
    esac
    echo "  $agent: $count requests ($category)"
done

echo

echo "=== BANDWIDTH ANALYSIS ==="
echo

# Calculate total bytes transferred
total_bytes=$(awk '{sum += $10} END {print sum}' "$log_file")
total_kb=$((total_bytes / 1024))
total_mb=$((total_kb / 1024))

echo "Total bandwidth:"
echo "  Bytes: $total_bytes"
echo "  KB: $total_kb"
echo "  MB: $total_mb"

echo
echo "Average response size:"
avg_bytes=$(awk '{sum += $10; count++} END {print int(sum/count)}' "$log_file")
echo "  $avg_bytes bytes per request"

echo

echo "=== EXTERNAL IP ANALYSIS ==="
echo

echo "External IP addresses (potential threats):"
awk '{print $1}' "$log_file" | grep -v "^192\.168\." | sort | uniq -c | sort -nr | while read count ip; do
    # Count different status codes for this IP
    error_count=$(grep "$ip" "$log_file" | grep -E " (4[0-9][0-9]|5[0-9][0-9]) " | wc -l)
    echo "  $ip: $count requests ($error_count errors)"
done

echo

echo "=== SUMMARY REPORT ==="
echo

echo "Security Recommendations:"
if [ $not_found_count -gt 3 ]; then
    echo "  - HIGH: Multiple 404 errors detected - possible reconnaissance"
fi
if [ $unauth_count -gt 0 ]; then
    echo "  - MEDIUM: Unauthorized access attempts detected"
fi
if [ $forbidden_count -gt 0 ]; then
    echo "  - MEDIUM: Forbidden access attempts detected"
fi
if [ $server_error_count -gt 0 ]; then
    echo "  - HIGH: Server errors detected - check application health"
fi

external_requests=$(awk '{print $1}' "$log_file" | grep -v "^192\.168\." | wc -l)
if [ $external_requests -gt $((total_requests / 2)) ]; then
    echo "  - INFO: High external traffic ratio ($external_requests/$total_requests)"
fi

echo
echo "Analysis complete!"
echo "Log file: $log_file (kept for further analysis)"

echo
echo "Challenge completed! You have:"
echo "   - Analyzed HTTP status codes and trends"
echo "   - Identified security threats and anomalies"
echo "   - Processed IP addresses and traffic patterns"
echo "   - Generated comprehensive security report"
echo "   - Used sed, awk, and grep for complex text processing"
