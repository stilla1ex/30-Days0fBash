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

echo "=== PART 1: Basic grep Patterns ==="
echo

# Create sample text
cat > sample_text.txt << 'EOF'
The quick brown fox jumps over the lazy dog
Linux system administration
Email: admin@example.com
Phone: 555-123-4567
IP Address: 192.168.1.100
Another email: user@domain.org
Date: 2025-08-01
Time: 14:30:25
URL: https://www.example.com
Error: File not found
Warning: Low disk space
Info: System startup complete
EOF

echo "Sample text file:"
cat sample_text.txt
echo

echo "Search for lines containing 'Email':"
echo "Command: grep 'Email' sample_text.txt"
pause

grep 'Email' sample_text.txt
echo

echo "Case-insensitive search for 'error':"
echo "Command: grep -i 'error' sample_text.txt"
pause

grep -i 'error' sample_text.txt
echo

echo "=== PART 2: Character Classes ==="
echo

echo "Find lines with digits:"
echo "Command: grep '[0-9]' sample_text.txt"
pause

grep '[0-9]' sample_text.txt
echo

echo "Find lines starting with capital letters:"
echo "Command: grep '^[A-Z]' sample_text.txt"
pause

grep '^[A-Z]' sample_text.txt
echo

echo "Find lines ending with numbers:"
echo "Command: grep '[0-9]$' sample_text.txt"
pause

grep '[0-9]$' sample_text.txt
echo

echo "=== PART 3: Special Characters ==="
echo

echo "Find email addresses (contains @):"
echo "Command: grep '@' sample_text.txt"
pause

grep '@' sample_text.txt
echo

echo "Find IP addresses (pattern with dots):"
echo "Command: grep '[0-9]\\+\\.[0-9]\\+\\.[0-9]\\+\\.[0-9]\\+' sample_text.txt"
pause

grep '[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' sample_text.txt
echo

echo "Find phone numbers (pattern with dashes):"
echo "Command: grep '[0-9]\\+-[0-9]\\+-[0-9]\\+' sample_text.txt"
pause

grep '[0-9]\+-[0-9]\+-[0-9]\+' sample_text.txt
echo

echo "=== PART 4: Extended Regular Expressions ==="
echo

echo "Use -E for extended regex (or egrep):"
echo "Find email addresses with better pattern:"
echo "Command: grep -E '[a-zA-Z0-9]+@[a-zA-Z0-9]+\\.[a-zA-Z]+' sample_text.txt"
pause

grep -E '[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+' sample_text.txt
echo

echo "Find URLs starting with http:"
echo "Command: grep -E 'https?://[a-zA-Z0-9.-]+' sample_text.txt"
pause

grep -E 'https?://[a-zA-Z0-9.-]+' sample_text.txt
echo

echo "Find dates in YYYY-MM-DD format:"
echo "Command: grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2}' sample_text.txt"
pause

grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2}' sample_text.txt
echo

echo "=== PART 5: Multiple Patterns ==="
echo

echo "Find lines with 'Error' OR 'Warning':"
echo "Command: grep -E '(Error|Warning)' sample_text.txt"
pause

grep -E '(Error|Warning)' sample_text.txt
echo

echo "Find lines NOT containing numbers:"
echo "Command: grep -v '[0-9]' sample_text.txt"
pause

grep -v '[0-9]' sample_text.txt
echo

echo "=== PART 6: Log File Analysis ==="
echo

# Create realistic log file
cat > system.log << 'EOF'
2025-08-01 10:15:30 INFO System startup initiated
2025-08-01 10:15:32 INFO Loading configuration files
2025-08-01 10:15:35 WARNING Configuration file /etc/app.conf not found
2025-08-01 10:15:36 INFO Using default configuration
2025-08-01 10:16:00 INFO Service apache2 started successfully
2025-08-01 10:16:05 ERROR Failed to connect to database server 192.168.1.50
2025-08-01 10:16:06 INFO Retrying database connection
2025-08-01 10:16:10 INFO Database connection established
2025-08-01 10:17:15 WARNING High memory usage detected: 85%
2025-08-01 10:18:30 ERROR User authentication failed for admin@company.com
2025-08-01 10:19:45 INFO Backup process completed successfully
2025-08-01 10:20:00 ERROR Disk space critical on /var/log partition
EOF

echo "System log file:"
cat system.log
echo

echo "Find all ERROR messages:"
echo "Command: grep 'ERROR' system.log"
pause

grep 'ERROR' system.log
echo

echo "Find log entries from 10:16:"
echo "Command: grep '10:16' system.log"
pause

grep '10:16' system.log
echo

echo "Find entries with email addresses:"
echo "Command: grep -E '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}' system.log"
pause

grep -E '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' system.log
echo

echo "Find entries with IP addresses:"
echo "Command: grep -E '([0-9]{1,3}\\.){3}[0-9]{1,3}' system.log"
pause

grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}' system.log
echo

echo "Count error messages:"
echo "Command: grep -c 'ERROR' system.log"
pause

grep -c 'ERROR' system.log
echo

echo "Show line numbers for warnings:"
echo "Command: grep -n 'WARNING' system.log"
pause

grep -n 'WARNING' system.log
echo

echo "=== PART 7: Practical Security Analysis ==="
echo

# Create security log
cat > security.log << 'EOF'
Aug 01 10:15:01 server sshd[1234]: Accepted password for admin from 192.168.1.10
Aug 01 10:16:15 server sshd[1235]: Failed password for root from 203.0.113.5
Aug 01 10:16:20 server sshd[1236]: Failed password for root from 203.0.113.5
Aug 01 10:16:25 server sshd[1237]: Failed password for admin from 203.0.113.5
Aug 01 10:17:30 server sudo[1238]: admin : TTY=pts/0 ; PWD=/home/admin ; USER=root
Aug 01 10:18:45 server sshd[1239]: Accepted password for user1 from 192.168.1.20
Aug 01 10:19:10 server sshd[1240]: Failed password for guest from 198.51.100.1
EOF

echo "Security log file:"
cat security.log
echo

echo "Find failed login attempts:"
echo "Command: grep 'Failed password' security.log"
pause

grep 'Failed password' security.log
echo

echo "Find external IP addresses (not 192.168.x.x):"
echo "Command: grep -E 'from [^1][0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+' security.log"
pause

grep -E 'from [^1][0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' security.log
echo

echo "Find sudo usage:"
echo "Command: grep 'sudo' security.log"
pause

grep 'sudo' security.log
echo

# Cleanup
rm -f sample_text.txt system.log security.log

echo
echo "What you learned:"
echo "   - Basic patterns: grep 'pattern' file"
echo "   - Character classes: [0-9], [A-Z], [a-z]"
echo "   - Anchors: ^ (start), $ (end)"
echo "   - Extended regex: -E flag"
echo "   - Quantifiers: +, *, {n}"
echo "   - Alternation: (pattern1|pattern2)"
echo "   - Email and IP address patterns"
echo "   - Log analysis techniques"
echo
echo "Next: Build a comprehensive log analyzer"
