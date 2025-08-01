#!/bin/bash
# Day 1 Exercise: Navigation Basics
# Learn to move around the file system

echo "🧭 Day 1: Navigation Basics"
echo "Let's learn to navigate like a pro!"
echo

# Function to pause and wait for user
pause() {
    echo
    read -p "👆 Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Where Am I? ==="
echo
echo "First, let's see where we are:"
echo "Command: pwd"
echo "This shows your current directory (Print Working Directory)"
pause

echo "Your current location: $(pwd)"
echo

echo "=== PART 2: What's Here? ==="
echo
echo "Let's see what files and folders are here:"
echo "Command: ls"
echo "This lists files and directories"
pause

echo "Files in current directory:"
ls
echo

echo "For more details, try:"
echo "Command: ls -l"
echo "The -l flag shows detailed information"
pause

echo "Detailed listing:"
ls -l
echo

echo "To see hidden files too:"
echo "Command: ls -la"
echo "The -a flag shows ALL files (including hidden ones starting with .)"
pause

echo "=== PART 3: Moving Around ==="
echo
echo "Let's move to your home directory:"
echo "Command: cd"
echo "With no arguments, cd takes you home"
pause

echo "Going home..."
cd ~
echo "New location: $(pwd)"
echo

echo "Let's go to the root directory:"
echo "Command: cd /"
echo "The / is the top of the file system"
pause

echo "Going to root..."
cd /
echo "New location: $(pwd)"
echo "Contents of root:"
ls
echo

echo "Let's go back to where we started:"
echo "Command: cd -"
echo "This goes back to your previous directory"
pause

echo "=== PART 4: Exploring Directories ==="
echo
echo "Let's look at some important directories:"
echo

echo "Your home directory:"
echo "Command: ls ~"
ls ~ 2>/dev/null | head -5
echo

echo "System programs:"
echo "Command: ls /usr/bin | head -5"
ls /usr/bin | head -5
echo

echo "[OK] Navigation Basics Complete!"
echo
echo "LEARNED: What you learned:"
echo "   • pwd - shows current directory"
echo "   • ls - lists files and directories"
echo "   • ls -l - detailed listing"
echo "   • ls -la - shows all files including hidden"
echo "   • cd - change directory"
echo "   • cd ~ - go to home directory"
echo "   • cd / - go to root directory"
echo "   • cd - - go back to previous directory"
echo
echo "Next: Run './exercises/file_basics.sh'"
