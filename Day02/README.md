# Day 2: Variables, Input/Output & Basic Scripting

## Learning Objectives
By the end of today, you will be able to:
- Understand and use variables in bash scripts
- Handle user input and command-line arguments
- Work with environment variables
- Create basic interactive scripts
- Understand different types of quotes and their effects
- Use basic input/output redirection

## Topics Covered

### 1. Variables
- Defining and using variables
- Variable naming conventions
- Local vs global variables
- Read-only variables
- Unsetting variables

### 2. Environment Variables
- Understanding PATH, HOME, USER, etc.
- Creating custom environment variables
- Exporting variables to subshells
- Using env and printenv commands

### 3. User Input
- Reading input with `read` command
- Command-line arguments ($1, $2, $@, $#)
- Interactive prompts
- Input validation basics

### 4. Quoting and Escaping
- Single quotes vs double quotes
- Escape characters
- Command substitution
- Variable expansion

### 5. Basic Input/Output
- echo vs printf
- Output redirection (>, >>)
- Input redirection (<)
- Pipes and basic text processing

## Exercises
1. **Variable Basics**: Create and manipulate variables
2. **User Input Script**: Interactive script with input validation
3. **Environment Setup**: Working with environment variables
4. **Command Arguments**: Script that processes command-line arguments

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
