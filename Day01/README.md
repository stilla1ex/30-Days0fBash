# Day 1: Foundation - Basic Commands & Environment

## 🎯 Learning Objectives
By the end of Day 1, you will be able to:
- Navigate the Linux file system confidently
- Use essential commands for cybersecurity tasks
- Understand command structure and syntax
- Set up useful aliases for security work
- Recognize why bash is crucial for cybersecurity professionals

## 📚 Topics Covered

### 1. Essential Navigation Commands
- **Directory Navigation**: `ls`, `cd`, `pwd`, `find`
- **File Operations**: `cat`, `cp`, `mv`, `rm`, `touch`, `mkdir`
- **Information Gathering**: `echo`, `man`, `which`, `type`, `file`
- **System Information**: `whoami`, `date`, `uname`

### 2. Command Structure & Syntax
- Basic syntax: `command [options] [arguments]`
- Using flags and options (`-l`, `--help`)
- Combining commands with pipes (`|`)
- Redirection operators (`>`, `>>`)
- Understanding exit codes and error handling

### 3. Cybersecurity Context
- Why bash is essential for security professionals
- File system security fundamentals
- Log file locations and analysis basics
- Common directories for security tools

### 4. Environment Configuration
- Understanding shell environment variables
- Creating temporary aliases for efficiency
- Basic terminal customization
- PATH variable and command execution

## 🛠️ Hands-On Exercises

### Practice Scripts (Interactive Learning)
1. **Basic Commands Practice** (`exercises/basic_commands.sh`)
   - Step-by-step command demonstration
   - File system navigation and operations
   - System information gathering

2. **File Operations Mastery** (`exercises/file_operations.sh`) 
   - Creating cybersecurity workspace structure
   - File manipulation and organization
   - Working with log files and directories

3. **Environment Configuration** (`exercises/environment_setup.sh`)
   - Setting up useful aliases
   - Understanding environment variables
   - Basic terminal customization

### Demonstration Scripts
- **Welcome Script** (`scripts/welcome.sh`) - Introduction to scripting concepts

## 📖 Learning Path

### Start Here:
1. Run `scripts/welcome.sh` for a gentle introduction
2. Work through `exercises/basic_commands.sh` step by step
3. Practice with `exercises/file_operations.sh`
4. Configure your environment with `exercises/environment_setup.sh`

### 💡 Key Concepts to Master:
- **File permissions** and security implications
- **Directory structure** of Linux systems
- **Command chaining** with pipes and redirects
- **Basic scripting** concepts and variables

## 🔍 Cybersecurity Focus Areas

### Important System Directories:
- `/etc` - Configuration files
- `/var/log` - System and application logs  
- `/home` - User directories
- `/tmp` - Temporary files (security concern)
- `/usr/bin` - User commands and tools

### Essential Security Commands Introduced:
- `find` for locating files and SUID binaries
- `ps` for process monitoring
- `netstat` for network connections
- `grep` for log analysis
- File permission commands (`ls -la`, `chmod`)

## 📚 Additional Resources
- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- [Linux Command Reference](https://www.linux.org/docs/)
- [Cybersecurity File System Guide](./LEARNING_PATH.md)

## ✅ Knowledge Check
Before moving to Day 2, ensure you can:
- [ ] Navigate directories using `cd`, `ls`, `pwd`
- [ ] Create, copy, move, and delete files/directories
- [ ] Use `man` pages to understand command options
- [ ] Combine commands with pipes (`|`) and redirection (`>`)
- [ ] Explain why these skills matter for cybersecurity

## 🚀 Next Steps
**Day 2 Preview**: Variables, user input, conditional statements, and your first custom security scripts!

---
🎓 **Learning Tip**: Focus on understanding each command rather than memorizing syntax. Practice regularly to build muscle memory!
