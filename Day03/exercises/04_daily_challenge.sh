#!/bin/bash

# Day 3 Daily Challenge: Security Check Script
# Create a script that checks system security basics

echo "System Security Check"
echo "===================="

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "WARNING: Running as root user"
else
    echo "Running as regular user: $USER"
fi

# Check for common security files
echo
echo "Security File Check:"
if [ -f "/etc/passwd" ]; then
    echo "[OK] Password file exists"
else
    echo "[FAIL] Password file missing"
fi

if [ -f "/etc/shadow" ]; then
    echo "[OK] Shadow file exists"
else
    echo "[FAIL] Shadow file missing"
fi

# Check SSH configuration
if [ -f "/etc/ssh/sshd_config" ]; then
    echo "[OK] SSH config exists"
    if grep -q "PermitRootLogin no" /etc/ssh/sshd_config 2>/dev/null; then
        echo "[OK] Root login disabled"
    else
        echo "[WARNING] Root login may be enabled"
    fi
else
    echo "[FAIL] SSH config not found"
fi

# Check for firewall
if command -v ufw >/dev/null 2>&1; then
    echo "[OK] UFW firewall available"
else
    echo "[WARNING] UFW firewall not found"
fi

# Check system updates (basic)
echo
echo "System Information:"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p 2>/dev/null || uptime)"

echo
echo "Challenge complete! You've created a basic security checker."
