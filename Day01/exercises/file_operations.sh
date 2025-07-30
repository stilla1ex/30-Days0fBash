#!/bin/bash

# Day 1 Exercise: File Operations
# Master file manipulation commands

echo "=== File Operations Exercise ==="
echo

# Create a workspace
mkdir -p cybersec_workspace
cd cybersec_workspace

echo "1. Creating Files and Directories"
# Create directory structure
mkdir -p logs/{web,system,security}
mkdir -p tools/{scanners,analyzers}
mkdir -p reports

# Create sample files
echo "192.168.1.1 - - [30/Jul/2025:10:15:23] GET /login.php" > logs/web/access.log
echo "Jul 30 10:15:23 server sshd[1234]: Failed password for root from 192.168.1.100" > logs/security/auth.log
echo "nmap -sS -O target" > tools/scanners/nmap_commands.txt

echo "Directory structure created:"
find . -type d

echo -e "\n2. File Information"
echo "File details:"
ls -la logs/web/access.log

echo -e "\nFile size:"
du -h logs/web/access.log

echo -e "\nFile type:"
file logs/web/access.log

echo -e "\n3. File Content Operations"
echo "View file content:"
cat logs/web/access.log

echo -e "\nAppend to file:"
echo "192.168.1.2 - - [30/Jul/2025:10:16:45] GET /admin.php" >> logs/web/access.log
echo "Updated content:"
cat logs/web/access.log

echo -e "\n4. Copy Operations"
# Copy single file
cp logs/web/access.log logs/web/access_backup.log

# Copy directory recursively
cp -r logs logs_backup

echo "Backup created:"
ls logs_backup/

echo -e "\n5. Move/Rename Operations"
# Rename file
mv tools/scanners/nmap_commands.txt tools/scanners/scan_commands.txt

# Move file to different directory
mv logs/security/auth.log logs/system/

echo "Files moved:"
find . -name "*.log"

echo -e "\n6. Search Operations"
echo "Find all .log files:"
find . -name "*.log"

echo -e "\nSearch for specific content:"
grep -r "192.168.1.1" .

echo -e "\n7. File Permissions (Security Important!)"
echo "Current permissions:"
ls -la logs/web/access.log

echo "Making file executable:"
chmod +x tools/scanners/scan_commands.txt
ls -la tools/scanners/scan_commands.txt

echo -e "\n8. Cleanup"
cd ..
rm -rf cybersec_workspace

echo -e "\n=== Exercise Complete ==="
echo "File operations are fundamental for cybersecurity tasks!"
