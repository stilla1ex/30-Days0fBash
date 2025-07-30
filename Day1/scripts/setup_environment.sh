#!/bin/bash
# Day 1 Script: Cybersecurity Environment Setup

echo "=== Cybersecurity Bash Environment Setup ==="

# Create cybersecurity directory structure
create_directories() {
    echo "Creating cybersecurity workspace..."
    mkdir -p ~/cybersec/{
        tools/{scanners,analyzers,monitors},
        data/{logs,captures,reports},
        scripts/{recon,analysis,automation},
        resources/{wordlists,configs,documentation}
    }
    echo "✓ Directory structure created"
}

# Set up useful aliases for cybersecurity work
setup_aliases() {
    echo "Setting up cybersecurity aliases..."
    
    # Backup existing bashrc
    cp ~/.bashrc ~/.bashrc.backup.$(date +%Y%m%d)
    
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
alias myip='curl -s ifconfig.me'
alias ports='nmap localhost'
alias connections='ss -tuln'
alias firewall='sudo iptables -L'

# Log Analysis
alias lastlogins='last -10'
alias failedlogins='grep "Failed password" /var/log/auth.log | tail -10'
alias logwatch='tail -f /var/log/syslog'

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
