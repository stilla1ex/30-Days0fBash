#!/bin/bash
# Day 3 Exercise: Basic Conditionals
# Learn if/then/else statements

echo "Day 3: Basic Conditionals"
echo "Learn to make decisions in scripts!"
echo

pause() {
    echo
    read -p "Try this, then press Enter to continue..."
    echo
}

echo "=== PART 1: Basic If Statement ==="
echo
echo "The basic syntax is:"
echo "if [ condition ]; then"
echo "    commands"
echo "fi"
echo

echo "Let's test if a number is greater than 10:"
echo

number=15
echo "Testing if $number is greater than 10:"
echo "if [ \$number -gt 10 ]; then"
echo "    echo \"Number is greater than 10\""
echo "fi"
pause

if [ $number -gt 10 ]; then
    echo "Number is greater than 10"
fi
echo

echo "=== PART 2: If/Else Statement ==="
echo
echo "Add an else clause for alternative action:"
echo

number=5
echo "Testing if $number is greater than 10:"
echo "if [ \$number -gt 10 ]; then"
echo "    echo \"Number is greater than 10\""
echo "else"
echo "    echo \"Number is 10 or less\""
echo "fi"
pause

if [ $number -gt 10 ]; then
    echo "Number is greater than 10"
else
    echo "Number is 10 or less"
fi
echo

echo "=== PART 3: Multiple Conditions with elif ==="
echo

score=85
echo "Testing score: $score"
echo "if [ \$score -ge 90 ]; then"
echo "    echo \"Grade: A\""
echo "elif [ \$score -ge 80 ]; then"
echo "    echo \"Grade: B\""
echo "elif [ \$score -ge 70 ]; then"
echo "    echo \"Grade: C\""
echo "else"
echo "    echo \"Grade: F\""
echo "fi"
pause

if [ $score -ge 90 ]; then
    echo "Grade: A"
elif [ $score -ge 80 ]; then
    echo "Grade: B"
elif [ $score -ge 70 ]; then
    echo "Grade: C"
else
    echo "Grade: F"
fi
echo

echo "=== PART 4: Interactive Example ==="
echo

read -p "Enter your age: " age

if [ $age -ge 18 ]; then
    echo "You are an adult."
    if [ $age -ge 65 ]; then
        echo "You qualify for senior discounts."
    fi
else
    echo "You are a minor."
fi
echo

echo "=== PART 5: String Comparisons ==="
echo

read -p "Enter your favorite color: " color

if [ "$color" = "blue" ]; then
    echo "Blue is a cool color!"
elif [ "$color" = "red" ]; then
    echo "Red is a warm color!"
elif [ "$color" = "green" ]; then
    echo "Green is the color of nature!"
else
    echo "$color is a nice color too!"
fi
echo

echo "What you learned:"
echo "   • if [ condition ]; then ... fi"
echo "   • if/else for two choices"
echo "   • elif for multiple conditions"
echo "   • -gt, -ge, -lt, -le for numbers"
echo "   • = for string comparison"
echo "   • Always quote string variables"
echo
echo "Next: Run './exercises/file_tests.sh'"
