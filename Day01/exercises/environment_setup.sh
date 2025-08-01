#!/bin/bash

# Day 1 Exercise: Environment Setup
# Configure your bash environment for cybersecurity work

echo "=== Environment Setup Exercise ==="
echo

echo "1. Current Environment Information"
echo "Current shell: $SHELL"
echo "Home directory: $HOME"
echo "Current user: $USER"
echo "PATH variable:"
echo $PATH | tr ':' '\n' # This command prints each directory in PATH on a new line

echo -e "\n2. Useful Aliases for Cybersecurity"
echo "Creating temporary aliases for this session..."

# Create useful aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

# Cybersecurity specific aliases
alias ports='netstat -tuln' # Show open ports
alias processes='ps aux' # Show running processes
alias ipinfo='ip addr show' # Show IP address information
alias netinfo='ifconfig' # Show network interface information
alias meminfo='free -h'
alias diskinfo='df -h'
alias listening='netstat -tlnp'

echo "Aliases created! Try them:"
echo "- ll (detailed list)"
echo "- ports (show open ports)"
echo "- processes (show running processes)"
echo "- meminfo (memory usage)"
echo "- diskinfo (disk usage)"

echo -e "\n3. Environment Variables"
echo "Important environment variables:"
echo "USER: $USER"
echo "HOME: $HOME"
echo "PWD: $PWD"
echo "SHELL: $SHELL"
echo "TERM: $TERM"

echo -e "\n4. Setting Custom Variables"
export CYBER_TOOLS="/opt/tools"
export TARGET_NETWORK="192.168.1.0/24"
export LOG_DIR="/var/log"

echo "Custom variables set:"
echo "CYBER_TOOLS: $CYBER_TOOLS"
echo "TARGET_NETWORK: $TARGET_NETWORK"
echo "LOG_DIR: $LOG_DIR"

echo -e "\n5. Command History"
echo "View command history:"
echo "Use 'history' to see previous commands"
echo "Use Ctrl+R to search command history"
echo "Use !! to repeat last command"

echo -e "\n6. Bash Configuration Files"
echo "Important bash config files:"
echo "- ~/.bashrc (user bash configuration)"
echo "- ~/.bash_profile (user login shell configuration)"
echo "- ~/.bash_aliases (user aliases)"
echo "- /etc/bash.bashrc (system-wide bash configuration)"

if [ -f ~/.bashrc ]; then
    echo -e "\nYour ~/.bashrc exists and is $(wc -l < ~/.bashrc) lines long"
else
    echo -e "\nNo ~/.bashrc found"
fi

echo -e "\n7. Tab Completion"
echo "Bash supports tab completion:"
echo "Type 'ls /e' then press TAB to see completion"
echo "Type 'cd ~/' then press TAB twice to see options"

echo -e "\n8. Creating a Permanent Alias"
echo "To make aliases permanent, add them to ~/.bashrc"
echo "Example: echo \"alias ll='ls -la'\" >> ~/.bashrc"

echo -e "\n9. Command Prompt Customization"
echo "Current prompt: $PS1"
echo "You can customize your prompt by changing PS1 variable"

echo -e "\n10. Cybersecurity Environment Check"
echo "Checking for common security tools:"

# Check for common tools
tools=("nmap" "netcat" "curl" "wget" "ss" "netstat" "ps" "grep" "awk" "sed")

for tool in "${tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo "✓ $tool is available"
    else
        echo "✗ $tool is not found"
    fi
done

echo -e "\n=== Environment Setup Complete ==="
echo "Your bash environment is now configured for cybersecurity work!"
echo "Remember: These aliases are temporary. Add them to ~/.bashrc to make them permanent."
