#!/bin/bash

# Day 6 Exercise 2: awk Processing
# Learning: Pattern matching and field processing

echo "Day 6: awk Field Processing"
echo "==========================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Basic Field Processing ==="
echo
echo "awk processes text by fields (columns)"
echo "Default field separator is space/tab"
echo

# Create sample data
cat > users.txt << 'EOF'
john smith 25 admin
jane doe 30 user
bob johnson 35 admin
alice brown 28 user
charlie wilson 42 manager
EOF

echo "Sample user data:"
cat users.txt
echo

echo "Print first field (first names):"
echo "Command: awk '{print \$1}' users.txt"
pause

awk '{print $1}' users.txt
echo

echo "Print last field (roles):"
echo "Command: awk '{print \$NF}' users.txt"
pause

awk '{print $NF}' users.txt
echo

echo "=== PART 2: Custom Output Format ==="
echo
echo "Format output with custom text:"
echo "Command: awk '{print \"Name: \" \$1 \" \" \$2 \", Age: \" \$3}' users.txt"
pause

awk '{print "Name: " $1 " " $2 ", Age: " $3}' users.txt
echo

echo "=== PART 3: Pattern Matching ==="
echo
echo "Show only admin users:"
echo "Command: awk '/admin/ {print \$1 \" \" \$2}' users.txt"
pause

awk '/admin/ {print $1 " " $2}' users.txt
echo

echo "Show users over 30:"
echo "Command: awk '\$3 > 30 {print \$1 \" \" \$2 \" is \" \$3}' users.txt"
pause

awk '$3 > 30 {print $1 " " $2 " is " $3}' users.txt
echo

echo "=== PART 4: Built-in Variables ==="
echo
echo "NR = Number of Records (line number)"
echo "NF = Number of Fields in current record"
echo

echo "Add line numbers:"
echo "Command: awk '{print NR \": \" \$0}' users.txt"
pause

awk '{print NR ": " $0}' users.txt
echo

echo "Show records with exactly 4 fields:"
echo "Command: awk 'NF == 4 {print \"Line \" NR \": \" \$0}' users.txt"
pause

awk 'NF == 4 {print "Line " NR ": " $0}' users.txt
echo

echo "=== PART 5: Field Separators ==="
echo

# Create CSV data
cat > data.csv << 'EOF'
name,age,city,salary
John,25,NYC,50000
Jane,30,LA,60000
Bob,35,Chicago,55000
Alice,28,Boston,58000
EOF

echo "CSV data:"
cat data.csv
echo

echo "Process CSV with comma separator:"
echo "Command: awk -F',' '{print \$1 \" earns \$\" \$4}' data.csv"
pause

awk -F',' '{print $1 " earns $" $4}' data.csv
echo

echo "Skip header and process data:"
echo "Command: awk -F',' 'NR > 1 {print \$1 \" lives in \" \$3}' data.csv"
pause

awk -F',' 'NR > 1 {print $1 " lives in " $3}' data.csv
echo

echo "=== PART 6: Mathematical Operations ==="
echo

echo "Calculate average age:"
echo "Command: awk '{sum += \$2; count++} END {print \"Average age: \" sum/count}' users.txt"
pause

awk '{sum += $3; count++} END {print "Average age: " sum/count}' users.txt
echo

echo "Find highest salary in CSV:"
echo "Command: awk -F',' 'NR > 1 {if(\$4 > max) max = \$4} END {print \"Highest salary: \$\" max}' data.csv"
pause

awk -F',' 'NR > 1 {if($4 > max) max = $4} END {print "Highest salary: $" max}' data.csv
echo

echo "=== PART 7: Log Processing Example ==="
echo

# Create log file
cat > access.log << 'EOF'
192.168.1.100 - - [01/Aug/2025:10:15:30] "GET /index.html" 200 1024
192.168.1.101 - - [01/Aug/2025:10:16:45] "POST /login" 200 512
192.168.1.102 - - [01/Aug/2025:10:17:20] "GET /admin" 404 256
192.168.1.100 - - [01/Aug/2025:10:18:15] "GET /data.json" 200 2048
192.168.1.103 - - [01/Aug/2025:10:19:30] "GET /index.html" 200 1024
EOF

echo "Web server access log:"
cat access.log
echo

echo "Extract IP addresses:"
echo "Command: awk '{print \$1}' access.log"
pause

awk '{print $1}' access.log
echo

echo "Show 404 errors:"
echo "Command: awk '/404/ {print \$1 \" requested \" \$7}' access.log"
pause

awk '/404/ {print $1 " requested " $7}' access.log
echo

echo "Count requests by IP:"
echo "Command: awk '{ip[\$1]++} END {for(i in ip) print i \": \" ip[i]}' access.log"
pause

awk '{ip[$1]++} END {for(i in ip) print i ": " ip[i]}' access.log
echo

# Cleanup
rm -f users.txt data.csv access.log

echo
echo "What you learned:"
echo "   - Field processing: $1, $2, $NF"
echo "   - Pattern matching: /pattern/ {action}"
echo "   - Conditions: $3 > 30 {action}"
echo "   - Built-in variables: NR, NF"
echo "   - Field separators: -F','"
echo "   - Mathematical operations and arrays"
echo "   - Log file analysis"
echo
echo "Next: Learn regular expressions"
