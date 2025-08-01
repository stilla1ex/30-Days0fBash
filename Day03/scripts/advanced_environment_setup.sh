#!/bin/bash
# Day 1 Script: Cybersecurity Environment Setup

echo "=== Cybersecurity Bash Environment Setup ==="

# Create cybersecurity directory structure
create_directories() {
    echo "Creating cybersecurity workspace..."
    
    # Create main directory structure
    local dirs=(
        "~/cybersec/tools/scanners"
        "~/cybersec/tools/analyzers" 
        "~/cybersec/tools/monitors"
        "~/cybersec/data/logs"
        "~/cybersec/data/captures"
        "~/cybersec/data/reports"
        "~/cybersec/scripts/recon"
        "~/cybersec/scripts/analysis"
        "~/cybersec/scripts/automation"
        "~/cybersec/resources/wordlists"
        "~/cybersec/resources/configs"
        "~/cybersec/resources/documentation"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "${dir/#~/$HOME}"
        if [[ $? -eq 0 ]]; then
            echo "✓ Created: $dir"
        else
            echo "✗ Failed to create: $dir"
            return 1
        fi
    done
    
    echo "✓ Directory structure created successfully"
}

# Set up useful aliases for cybersecurity work
setup_aliases() {
    echo "Setting up cybersecurity aliases..."
    
    # Check if .bashrc exists
    if [[ ! -f ~/.bashrc ]]; then
        echo "⚠️  ~/.bashrc not found, creating one..."
        touch ~/.bashrc
    fi
    
    # Backup existing bashrc
    local timestamp=$(date +%Y%m%d_%H%M%S)
    if cp ~/.bashrc ~/.bashrc.backup.$timestamp; then
        echo "✓ Backup created: ~/.bashrc.backup.$timestamp"
    else
        echo "✗ Failed to backup ~/.bashrc"
        return 1
    fi
    
    cat >> ~/.bashrc << 'EOF'

# Cybersecurity Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

# System Information
alias sysinfo='uname -a && lsb_release -a'
alias netports='netstat -tuln'
alias listening='netstat -tuln | grep LISTEN'
alias processes='ps aux'
alias topproc='ps aux --sort=-%cpu | head'
alias diskspace='df -h'
alias meminfo='free -h'
alias cpuinfo='lscpu'

# Network & Security
alias myip='curl -s --connect-timeout 5 ifconfig.me || echo "Network unavailable"'
alias ports='command -v nmap >/dev/null && nmap localhost || echo "nmap not installed"'
alias connections='ss -tuln'
alias firewall='sudo iptables -L 2>/dev/null || echo "iptables not accessible"'

# Log Analysis
alias lastlogins='last -10 2>/dev/null || echo "last command not available"'
alias failedlogins='sudo grep "Failed password" /var/log/auth.log 2>/dev/null | tail -10 || echo "Auth log not accessible"'
alias logwatch='sudo tail -f /var/log/syslog 2>/dev/null || echo "Syslog not accessible"'

# Quick Security Checks
alias checkroot='find / -perm -4000 2>/dev/null'
alias checkworld='find / -perm -002 2>/dev/null'
alias checkusers='cut -d: -f1 /etc/passwd'

EOF
    echo "✓ Aliases added to ~/.bashrc"
}

# Create sample configuration files
create_configs() {
    echo "Creating sample configuration files..."
    
    # Basic nmap targets file
    cat > ~/cybersec/resources/configs/nmap_targets.txt << 'EOF'
# Common target ranges for authorized testing
192.168.1.0/24
10.0.0.0/24
172.16.0.0/24
EOF

    # Basic port list
    cat > ~/cybersec/resources/configs/common_ports.txt << 'EOF'
21,22,23,25,53,80,110,111,135,139,143,443,993,995,1723,3306,3389,5432,5900,8080
EOF

    # Quick reference file
    cat > ~/cybersec/resources/documentation/quick_reference.md << 'EOF'
# Cybersecurity Quick Reference

## Network Discovery
- `nmap -sn 192.168.1.0/24` - Ping sweep
- `nmap -sS -O target` - SYN scan with OS detection
- `netstat -tuln` - Show listening ports

## System Analysis
- `ps aux` - All running processes
- `ss -tuln` - Network connections
- `find / -perm -4000` - SUID files

## Log Analysis
- `tail -f /var/log/syslog` - Monitor system log
- `grep "Failed password" /var/log/auth.log` - Failed logins
- `last` - Login history

## File Analysis
- `file filename` - Determine file type
- `strings filename` - Extract strings
- `hexdump -C filename` - Hex dump
EOF

    echo "✓ Configuration files created"
}

# Set proper permissions
set_permissions() {
    echo "Setting proper permissions..."
    chmod 700 ~/cybersec
    chmod +x ~/cybersec/scripts/*/*.sh 2>/dev/null
    echo "✓ Permissions set"
}

# Main execution
main() {
    echo "Starting cybersecurity environment setup..."
    
    create_directories
    setup_aliases
    create_configs
    set_permissions
    
    echo -e "\n=== Setup Complete! ==="
    echo "Your cybersecurity workspace is ready at ~/cybersec/"
    echo "Restart your terminal or run 'source ~/.bashrc' to use new aliases"
    echo -e "\nDirectory structure:"
    tree ~/cybersec 2>/dev/null || find ~/cybersec -type d
}

# Run the setup
main
