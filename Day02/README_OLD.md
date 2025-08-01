# Day 2: Variables, Input/Output & Interactive Scripting

## 🎯 Learning Objectives
By the end of Day 2, you will be able to:
- Master variables and their manipulation in bash scripts
- Handle user input and create interactive cybersecurity tools
- Use input/output redirection for log analysis and data processing
- Work with environment variables and command-line arguments
- Build practical security scripts with proper error handling

## 📚 Topics Covered

### 1. Variables and Data Handling
- **Variable Creation**: Naming conventions and best practices
- **Variable Types**: Strings, numbers, arrays, and environment variables
- **Variable Operations**: Concatenation, length, default values
- **Command Substitution**: Capturing command output
- **Variable Scope**: Local vs global variables

### 2. Interactive User Input
- **Input Methods**: `read` command and its options
- **Input Validation**: Ensuring data integrity and security
- **Menu Systems**: Creating professional cybersecurity tools
- **Silent Input**: Handling passwords and sensitive data
- **Timeouts**: Preventing script hangs

### 3. Command-Line Arguments
- **Positional Parameters**: `$1`, `$2`, `$@`, `$#`
- **Argument Processing**: Handling script parameters
- **Script Configuration**: Making scripts flexible and reusable

### 4. Input/Output Redirection
- **Output Redirection**: `>`, `>>`, and error handling
- **Input Redirection**: Processing files and data streams
- **Pipes**: Chaining commands for complex operations
- **Here Documents**: Creating configuration files
- **Process Substitution**: Advanced I/O techniques

### 5. Text Processing for Security
- **Log Analysis**: Parsing security logs efficiently
- **Data Extraction**: Using `grep`, `awk`, `sed` for forensics
- **Report Generation**: Creating structured security reports

## 🛠️ Hands-On Exercises

### Practice Scripts (Building Skills Progressively)
1. **Variables and Scripting Basics** (`exercises/variables_basics.sh`)
   - Variable creation and manipulation
   - Environment variables and arrays
   - Command substitution examples
   - Practical cybersecurity variable usage

2. **Interactive User Input** (`exercises/user_input.sh`)
   - Input validation and menu systems
   - Building cybersecurity tool interfaces
   - Handling passwords and sensitive data
   - Command-line argument processing

3. **I/O Redirection Mastery** (`exercises/io_redirection.sh`)
   - Output and error redirection
   - Log file processing and analysis
   - Creating automated reports
   - Advanced text processing techniques

### Practical Security Tools
1. **System Information Gatherer** (`scripts/system_info_gatherer.sh`)
   - Interactive system reconnaissance tool
   - Automated report generation
   - Security tool detection
   - Network configuration analysis

2. **Log Analyzer** (`scripts/log_analyzer.sh`)
   - Authentication log analysis
   - Failed login detection
   - Pattern searching in logs
   - Security event reporting

## 📖 Learning Path

### Recommended Progression:
1. **Start with Variables**: `exercises/variables_basics.sh`
   - Understand variable creation and manipulation
   - Practice command substitution
   - Learn array basics

2. **Master User Input**: `exercises/user_input.sh` 
   - Create interactive scripts
   - Build menu systems
   - Handle user validation

3. **I/O Redirection**: `exercises/io_redirection.sh`
   - Process files and logs
   - Create automated workflows
   - Build analysis pipelines

4. **Apply Knowledge**: Practice with real tools
   - Run `scripts/system_info_gatherer.sh`
   - Analyze logs with `scripts/log_analyzer.sh`
   - Modify scripts for your environment

## 🔍 Cybersecurity Applications

### Real-World Use Cases:
- **Automated Reconnaissance**: System information gathering
- **Log Analysis**: Security event detection and analysis
- **Report Generation**: Creating structured security assessments
- **Tool Configuration**: Dynamic security tool setup
- **Data Processing**: Handling large security datasets

### Security Best Practices:
- **Input Validation**: Always validate user input
- **Error Handling**: Graceful failure management
- **Secure Defaults**: Safe variable initialization
- **Logging**: Track script execution for auditing
- **Permission Checks**: Verify access before operations

## 💡 Key Concepts to Master

### Variable Best Practices:
- Use meaningful names (e.g., `target_ip` not `x`)
- Quote variables to prevent word splitting: `"$variable"`
- Use `${variable}` for clarity in concatenation
- Initialize variables with default values

### Interactive Script Design:
- Provide clear prompts and instructions
- Validate all user input
- Offer help and usage information
- Handle interrupts gracefully (Ctrl+C)

### I/O Redirection Patterns:
- `command > file` - Redirect output
- `command >> file` - Append output  
- `command 2> file` - Redirect errors
- `command 2>&1` - Combine output and errors
- `command < file` - Input from file

## ✅ Knowledge Check
Before moving to Day 3, ensure you can:
- [ ] Create and manipulate variables effectively
- [ ] Build interactive menus with input validation
- [ ] Use I/O redirection for log analysis
- [ ] Process command-line arguments in scripts
- [ ] Create practical cybersecurity tools
- [ ] Handle errors and edge cases gracefully

## 🚀 Next Steps
**Day 3 Preview**: Conditional statements, loops, functions, and advanced scripting techniques for building robust cybersecurity tools!

## 📚 Additional Resources
- [Bash Variables Guide](https://www.gnu.org/software/bash/manual/html_node/Shell-Variables.html)
- [I/O Redirection Reference](https://www.gnu.org/software/bash/manual/html_node/Redirections.html)
- [Security Log Analysis Best Practices](./resources/)

---
🎓 **Learning Tip**: Practice building your own variations of the example scripts. Try modifying them to work with different log files or gather different types of information!

## Security Considerations
- Input sanitization
- Avoiding command injection
- Safe variable handling
- Proper quoting practices

## Resources
- Bash manual on variables
- Security best practices for bash scripting
- Environment variable reference

## Practice Project
Create a system information gathering script that:
- Accepts user input for what information to display
- Uses variables to store system data
- Provides formatted output
- Handles command-line arguments
