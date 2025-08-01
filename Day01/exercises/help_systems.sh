#!/bin/bash
# Day 1 Exercise: Help Systems
# Learn how to get help when you need it

echo "🆘 Day 1: Getting Help"
echo "Learn to help yourself - the most important skill!"
echo

pause() {
    echo
    read -p "👆 Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Manual Pages ==="
echo
echo "Every command has a manual page with detailed information:"
echo "Command: man ls"
echo "This opens the manual for the 'ls' command"
echo "Use 'q' to quit, arrow keys to scroll"
pause

echo "💡 The manual will open. Here's what to look for:"
echo "   • NAME - what the command does"
echo "   • SYNOPSIS - how to use it"
echo "   • DESCRIPTION - detailed explanation"
echo "   • OPTIONS - all available flags"
echo "   • EXAMPLES - usage examples"
echo
echo "Try: man ls"
echo "When you're done reading, press 'q' to quit"
echo

echo "=== PART 2: Quick Help ==="
echo
echo "Most commands have a quick help option:"
echo "Command: ls --help"
echo "This shows a summary of options"
pause

echo "Quick help for ls:"
ls --help | head -10
echo "... (truncated)"
echo

echo "=== PART 3: Finding Commands ==="
echo
echo "Find where a command is located:"
echo "Command: which ls"
echo "This shows the path to the command"
pause

echo "Location of ls command:"
which ls
echo

echo "Command: type ls"
echo "This tells you what type of command it is"
pause

echo "Type of ls command:"
type ls
echo

echo "=== PART 4: Command Information ==="
echo
echo "Get basic info about commands:"
echo "Command: whatis ls"
echo "This gives a one-line description"
pause

echo "What is ls:"
whatis ls 2>/dev/null || echo "ls - list directory contents"
echo

echo "=== PART 5: Searching for Commands ==="
echo
echo "Find commands related to a topic:"
echo "Command: apropos file"
echo "This searches manual pages for the word 'file'"
pause

echo "Commands related to 'file':"
apropos file 2>/dev/null | head -5 || echo "Various file-related commands available"
echo

echo "=== PART 6: Getting System Information ==="
echo
echo "Some useful information commands:"
echo

echo "Command: whoami"
echo "Shows your username"
pause
echo "Current user: $(whoami)"
echo

echo "Command: date"
echo "Shows current date and time"
pause
echo "Current date: $(date)"
echo

echo "Command: uname -a"
echo "Shows system information"
pause
echo "System info: $(uname -a)"
echo

echo "🎓 What you learned:"
echo "   • man command - full manual pages"
echo "   • command --help - quick help"
echo "   • which command - find command location"
echo "   • type command - identify command type"
echo "   • whatis command - brief description"
echo "   • apropos keyword - search for related commands"
echo "   • whoami - your username"
echo "   • date - current date and time"
echo "   • uname -a - system information"
echo
echo "💡 Remember: When in doubt, check the manual!"
echo "   The man pages are your best friend."
echo
echo "Next: Run './exercises/daily_challenge.sh'"
