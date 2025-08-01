#!/bin/bash

# Day 6 Exercise 2: awk Processing
# Learning: Pattern matching and field processing

echo "Day 6: awk Pattern Processing"
echo "============================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

# Create sample log data
cat > system.log << 'EOF'
2024-01-01 10:00:01 INFO apache2 started successfully
2024-01-01 10:00:15 WARNING high memory usage detected 85%
2024-01-01 10:01:30 ERROR database connection failed
2024-01-01 10:02:45 INFO backup process completed
2024-01-01 10:03:12 ERROR authentication failed for user admin
2024-01-01 10:05:23 WARNING disk space low on /var 92%
2024-01-01 10:07:11 INFO user login successful for john
EOF

echo "Sample log file created:"
cat system.log
echo

echo "=== PART 1: Field Processing ==="
echo

echo "Print just the time (field 2):"
echo "Command: awk '{print \$2}' system.log"
pause

awk '{print $2}' system.log
echo

echo "Print time and log level:"
echo "Command: awk '{print \$2, \$3}' system.log"
pause

awk '{print $2, $3}' system.log
echo

echo "Print with custom formatting:"
echo "Command: awk '{print \"Time:\" \$2 \" Level:\" \$3}' system.log"
pause

awk '{print "Time:" $2 " Level:" $3}' system.log
echo

echo "=== PART 2: Pattern Matching ==="
echo

echo "Show only ERROR entries:"
echo "Command: awk '/ERROR/ {print}' system.log"
pause

awk '/ERROR/ {print}' system.log
echo

echo "Show WARNING and ERROR entries:"
echo "Command: awk '/WARNING|ERROR/ {print}' system.log"
pause

awk '/WARNING|ERROR/ {print}' system.log
echo

echo "=== PART 3: Field-based Conditions ==="
echo

echo "Show entries where field 3 is ERROR:"
echo "Command: awk '\$3 == \"ERROR\" {print}' system.log"
pause

awk '$3 == "ERROR" {print}' system.log
echo

echo "Show entries from 10:02 onwards:"
echo "Command: awk '\$2 >= \"10:02:00\" {print}' system.log"
pause

awk '$2 >= "10:02:00" {print}' system.log
echo

echo "=== PART 4: Built-in Variables ==="
echo

echo "Add line numbers:"
echo "Command: awk '{print NR \": \" \$0}' system.log"
pause

awk '{print NR ": " $0}' system.log
echo

echo "Show number of fields per line:"
echo "Command: awk '{print \"Line \" NR \" has \" NF \" fields\"}' system.log"
pause

awk '{print "Line " NR " has " NF " fields"}' system.log
echo

echo "=== PART 5: Calculations and Summaries ==="
echo

# Create numerical data
cat > sales.txt << 'EOF'
apple 50 2.50
banana 30 1.20
orange 25 3.00
grape 40 4.50
EOF

echo "Sample sales data:"
cat sales.txt
echo

echo "Calculate total value (quantity * price):"
echo "Command: awk '{print \$1, \$2 * \$3}' sales.txt"
pause

awk '{print $1, $2 * $3}' sales.txt
echo

echo "Sum all quantities:"
echo "Command: awk '{total += \$2} END {print \"Total quantity:\" total}' sales.txt"
pause

awk '{total += $2} END {print "Total quantity:" total}' sales.txt
echo

echo "Calculate average price:"
echo "Command: awk '{sum += \$3; count++} END {print \"Average price:\" sum/count}' sales.txt"
pause

awk '{sum += $3; count++} END {print "Average price:" sum/count}' sales.txt
echo

echo "=== PART 6: Advanced Processing ==="
echo

echo "Create summary report:"
echo "Command: awk 'BEGIN {print \"SALES REPORT\"} {total += \$2*\$3; print \$1 \": \" \$2*\$3} END {print \"TOTAL: \" total}' sales.txt"
pause

awk 'BEGIN {print "SALES REPORT"} {total += $2*$3; print $1 ": " $2*$3} END {print "TOTAL: " total}' sales.txt
echo

# Clean up
rm -f system.log sales.txt

echo "What you learned:"
echo "   - \$1, \$2, \$3 for field access"
echo "   - Pattern matching with /pattern/"
echo "   - Field-based conditions"
echo "   - NR (line number) and NF (field count)"
echo "   - BEGIN and END blocks"
echo "   - Mathematical operations"
echo "   - Variable accumulation"
echo
echo "Next: Learn regular expressions with grep"
