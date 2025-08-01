#!/bin/bash
# Day 2 Exercise: User Input
# Learn to get input from users

echo "Day 2: User Input"
echo "Learn to make scripts interactive!"
echo

pause() {
    echo
    read -p "Try this, then press Enter to continue..."
    echo
}

echo "=== PART 1: Basic Input ==="
echo
echo "The 'read' command gets input from users:"
echo

echo "Let's try it:"
echo "Command: read name"
echo "Type this command and enter your name when prompted:"
pause

echo "Now try it yourself:"
read -p "Enter your name: " name
echo "Hello, $name! Nice to meet you."
echo

echo "=== PART 2: Input with Prompts ==="
echo
echo "You can add prompts directly:"
echo "Command: read -p \"Enter your age: \" age"
pause

read -p "Enter your age: " age
echo "You are $age years old."
echo

echo "=== PART 3: Multiple Inputs ==="
echo
echo "Let's gather more information:"

read -p "Enter your favorite color: " color
read -p "Enter your city: " city

echo
echo "Summary:"
echo "Name: $name"
echo "Age: $age"
echo "Favorite color: $color"
echo "City: $city"
echo

echo "=== PART 4: Input Validation ==="
echo
echo "Let's check if input is provided:"

echo "Enter something (or just press Enter for empty):"
read -p "Input: " test_input

if [ -z "$test_input" ]; then
    echo "No input provided!"
else
    echo "You entered: $test_input"
fi
echo

echo "=== PART 5: Building a Simple Profile ==="
echo
echo "Let's create a user profile:"

read -p "Full name: " full_name
read -p "Job title: " job_title
read -p "Years of experience: " experience
read -p "Favorite programming language: " language

echo
echo "=== USER PROFILE ==="
echo "Name: $full_name"
echo "Title: $job_title"
echo "Experience: $experience years"
echo "Favorite language: $language"
echo "Profile created on: $(date)"
echo

echo "=== PART 6: Saving Input to File ==="
echo
echo "Let's save this profile to a file:"

profile_file="${full_name// /_}_profile.txt"
echo "Saving to: $profile_file"

cat > "$profile_file" << EOF
USER PROFILE
============
Name: $full_name
Title: $job_title
Experience: $experience years
Favorite language: $language
Created: $(date)
EOF

echo "Profile saved!"
echo "View it with: cat \"$profile_file\""
echo

echo "What you learned:"
echo "   • read command gets user input"
echo "   • read -p \"prompt\" variable for prompts"
echo "   • Check empty input with [ -z \"\$var\" ]"
echo "   • Save input to files"
echo "   • Use input in other commands"
echo
echo "Next: Run './exercises/command_substitution.sh'"
