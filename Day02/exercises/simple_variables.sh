#!/bin/bash
# Day 2 Exercise: Simple Variables
# Learn to create and use variables

echo "Day 2: Simple Variables"
echo "Learn to store and use information!"
echo

pause() {
    echo
    read -p "Try this in your terminal, then press Enter to continue..."
    echo
}

echo "=== PART 1: Creating Variables ==="
echo
echo "In bash, variables store information for later use."
echo "To create a variable, use: name=value"
echo "IMPORTANT: No spaces around the = sign!"
echo

echo "Let's create our first variable:"
echo "Command: username=\"student\""
pause

username="student"
echo "Variable created! Now let's use it:"
echo "Command: echo \$username"
pause

echo "The value is: $username"
echo

echo "Let's create more variables:"
echo "Command: age=25"
echo "Command: city=\"New York\""
pause

age=25
city="New York"
echo "Created: age=$age, city=$city"
echo

echo "=== PART 2: Using Variables ==="
echo
echo "Access variables with \$ in front of the name:"
echo "Command: echo \"Hello \$username\""
pause

echo "Hello $username"
echo

echo "You can use variables in any command:"
echo "Command: echo \"User \$username is \$age years old\""
pause

echo "User $username is $age years old"
echo

echo "=== PART 3: Environment Variables ==="
echo
echo "Some variables are already set by the system:"
echo

echo "Your username: $USER"
echo "Your home directory: $HOME"
echo "Current directory: $PWD"
echo "Your shell: $SHELL"
echo

echo "Command: echo \"Welcome \$USER to \$PWD\""
pause

echo "Welcome $USER to $PWD"
echo

echo "=== PART 4: Variable Safety ==="
echo
echo "Use curly braces for clarity:"
echo "Command: filename=\"report\""
echo "Command: echo \"\${filename}.txt\""
pause

filename="report"
echo "Without braces: $filename.txt"
echo "With braces: ${filename}.txt"
echo

echo "=== PART 5: Practical Examples ==="
echo
echo "Let's create some useful variables:"
echo

# Set practical variables
today=$(date +%Y-%m-%d)
backup_dir="backup_$today"
log_file="system_${USER}.log"

echo "Today's date: $today"
echo "Backup directory name: $backup_dir"
echo "Log file name: $log_file"
echo

echo "What you learned:"
echo "   • Variables store information: name=value"
echo "   • Access with \$name or \${name}"
echo "   • No spaces around = when creating"
echo "   • Environment variables like \$USER, \$HOME"
echo "   • Use quotes for values with spaces"
echo "   • Curly braces \${} for clarity"
echo
echo "Next: Run './exercises/user_input.sh'"
