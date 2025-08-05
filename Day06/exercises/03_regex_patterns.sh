#!/bin/bash

# Day 6 Exercise 3: Regular Expression Patterns
# Learning: Pattern matching with grep and regex

echo "Day 6: Regular Expression Patterns"
echo "=================================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

# Create sample text for regex practice
cat > emails.txt << 'EOF'
john.doe@example.com
admin@company.org
user123@test-site.net
invalid.email@
@missinguser.com
support@help.co.uk
sales@business.info
EOF

cat > access.log << 'EOF'
192.168.1.100 - - [01/Jan/2024:10:00:01] "GET /index.html" 200
10.0.0.55 - - [01/Jan/2024:10:00:15] "POST /login" 401
172.16.0.10 - - [01/Jan/2024:10:01:30] "GET /admin" 403
192.168.1.100 - - [01/Jan/2024:10:02:45] "GET /data.json" 200
203.0.113.5 - - [01/Jan/2024:10:03:12] "GET /api/users" 500
192.168.1.101 - - [01/Jan/2024:10:05:23] "DELETE /files" 200
EOF

echo "Sample data files created:"
echo "emails.txt:"
cat emails.txt
echo
echo "access.log:"
cat access.log
echo

echo "=== PART 1: Basic Pattern Matching ==="
echo

echo "Find lines containing 'example':"
echo "Command: grep 'example' emails.txt"
pause

grep 'example' emails.txt
echo

echo "Case-insensitive search:"
echo "Command: grep -i 'EXAMPLE' emails.txt"
pause

grep -i 'EXAMPLE' emails.txt
echo

echo "Invert match (lines NOT containing pattern):"
echo "Command: grep -v '@' emails.txt"
pause

grep -v '@' emails.txt
echo

echo "=== PART 2: Character Classes ==="
echo

echo "Find emails with numbers:"
echo "Command: grep '[0-9]' emails.txt"
pause

grep '[0-9]' emails.txt
echo

echo "Find lines starting with 'a' or 's':"
echo "Command: grep '^[as]' emails.txt"
pause

grep '^[as]' emails.txt
echo

echo "Find lines ending with '.com':"
echo "Command: grep '\.com$' emails.txt"
pause

grep '\.com$' emails.txt
echo

echo "=== PART 3: Special Characters ==="
echo

echo "Find IPs starting with 192:"
echo "Command: grep '^192' access.log"
pause

grep '^192' access.log
echo

echo "Find GET requests:"
echo "Command: grep 'GET' access.log"
pause

grep 'GET' access.log
echo

echo "Find error codes (4xx or 5xx):"
echo "Command: grep '[45][0-9][0-9]' access.log"
pause

grep '[45][0-9][0-9]' access.log
echo

echo "=== PART 4: Extended Regular Expressions ==="
echo

echo "Find emails with .com OR .org:"
echo "Command: grep -E '\.(com|org)' emails.txt"
pause

grep -E '\.(com|org)' emails.txt
echo

echo "Find valid email format (basic):"
echo "Command: grep -E '^[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' emails.txt"
pause

grep -E '^[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' emails.txt
echo

echo "Find private IP addresses:"
echo "Command: grep -E '^(192\.168|10\.|172\.16)' access.log"
pause

grep -E '^(192\.168|10\.|172\.16)' access.log
echo

echo "=== PART 5: Practical Examples ==="
echo

echo "Count successful requests (200 status):"
echo "Command: grep ' 200$' access.log | wc -l"
pause

grep ' 200$' access.log | wc -l
echo

echo "Extract just the IP addresses:"
echo "Command: grep -o '^[0-9.]*' access.log"
pause

grep -o '^[0-9.]*' access.log
echo

echo "Find unique IP addresses:"
echo "Command: grep -o '^[0-9.]*' access.log | sort | uniq"
pause

grep -o '^[0-9.]*' access.log | sort | uniq
echo

echo "=== PART 6: Advanced Patterns ==="
echo

# Create system data
cat > system_info.txt << 'EOF'
CPU: Intel Core i7-9700K 3.60GHz
Memory: 16GB DDR4
Disk: SSD 512GB
Network: Ethernet 1Gbps
Temperature: CPU 45C GPU 38C
Load: 1.25 0.89 0.67
EOF

echo "System information file:"
cat system_info.txt
echo

echo "Extract numbers with units:"
echo "Command: grep -o '[0-9]*[A-Z][A-Za-z]*' system_info.txt"
pause

grep -o '[0-9]*[A-Z][A-Za-z]*' system_info.txt
echo

echo "Find temperature readings:"
echo "Command: grep -o '[0-9]*C' system_info.txt"
pause

grep -o '[0-9]*C' system_info.txt
echo

echo "Extract load averages:"
echo "Command: grep -o '[0-9]\.[0-9]*' system_info.txt"
pause

grep -o '[0-9]\.[0-9]*' system_info.txt
echo

# Clean up
rm -f emails.txt access.log system_info.txt

echo "What you learned:"
echo "   - Basic pattern matching with grep"
echo "   - Character classes [a-z] [0-9]"
echo "   - Anchors ^ (start) and $ (end)"
echo "   - Extended regex with -E"
echo "   - Alternation with | (pipe)"
echo "   - Quantifiers * + ? {n,m}"
echo "   - Extracting patterns with -o"
echo "   - Combining grep with other tools"
echo
echo "Next: Complete the daily challenge"
