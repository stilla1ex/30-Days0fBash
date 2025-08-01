#!/bin/bash
# Day 1 Exercise: File Operations Basics
# Learn to create, copy, move, and delete files

echo "Day 1: File Operations Basics"
echo "Let's learn to manage files and directories!"
echo

# Function to pause
pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

# Create a practice area
echo "First, let's create a practice area:"
echo "Command: mkdir day1_practice"
echo "mkdir creates a new directory"
pause

mkdir -p day1_practice
cd day1_practice
echo "Created and moved into: $(pwd)"
echo

echo "=== PART 1: Creating Files ==="
echo
echo "Let's create an empty file:"
echo "Command: touch hello.txt"
echo "touch creates an empty file"
pause

touch hello.txt
echo "[OK] Created hello.txt"
ls -l hello.txt
echo

echo "Let's put some content in it:"
echo "Command: echo 'Hello World!' > hello.txt"
echo "The > symbol redirects output to a file"
pause

echo 'Hello World!' > hello.txt
echo "[OK] Added content to hello.txt"
echo

echo "Let's see what's in the file:"
echo "Command: cat hello.txt"
echo "cat displays the contents of a file"
pause

echo "Content of hello.txt:"
cat hello.txt
echo

echo "=== PART 2: Copying Files ==="
echo
echo "Let's make a copy:"
echo "Command: cp hello.txt hello_backup.txt"
echo "cp copies files"
pause

cp hello.txt hello_backup.txt
echo "[OK] Created backup"
ls -l hello*
echo

echo "=== PART 3: Creating Directories ==="
echo
echo "Let's create some directories:"
echo "Command: mkdir projects"
pause

mkdir projects
echo "[OK] Created projects directory"

echo "Command: mkdir -p work/important/secret"
echo "The -p flag creates parent directories if needed"
pause

mkdir -p work/important/secret
echo "[OK] Created nested directory structure"
echo "Let's see what we built:"
ls -la
echo

echo "=== PART 4: Moving and Renaming ==="
echo
echo "Let's move our file to the projects directory:"
echo "Command: mv hello.txt projects/"
echo "mv moves files (also used for renaming)"
pause

mv hello.txt projects/
echo "[OK] Moved hello.txt to projects/"
echo "Current directory contents:"
ls -la
echo "Projects directory contents:"
ls -la projects/
echo

echo "Let's rename our backup file:"
echo "Command: mv hello_backup.txt greeting.txt"
pause

mv hello_backup.txt greeting.txt
echo "[OK] Renamed file"
ls -la
echo

echo "=== PART 5: Viewing File Information ==="
echo
echo "Let's get information about our files:"
echo "Command: wc greeting.txt"
echo "wc counts lines, words, and characters"
pause

echo "File statistics:"
wc greeting.txt
echo

echo "Command: file greeting.txt"
echo "file tells us what type of file it is"
pause

echo "File type:"
file greeting.txt
echo

echo "=== PART 6: Cleanup ==="
echo
echo "Let's clean up our practice files:"
echo "Command: rm greeting.txt"
echo "rm deletes files (be careful!)"
pause

rm greeting.txt
echo "[OK] Removed greeting.txt"
echo

echo "Command: rm -r work"
echo "rm -r removes directories and their contents recursively"
pause

rm -r work
echo "[OK] Removed work directory"
echo

echo "Let's go back to parent directory and clean up:"
cd ..
echo "Command: rm -r day1_practice"
pause

rm -r day1_practice
echo "[OK] Cleanup complete!"
echo

echo "LEARNED: What you learned:"
echo "   - touch - creates empty files"
echo "   - echo 'text' > file - puts text in a file"
echo "   - cat - displays file contents"
echo "   - cp - copies files"
echo "   - mkdir - creates directories"
echo "   - mkdir -p - creates nested directories"
echo "   - mv - moves and renames files"
echo "   - rm - deletes files"
echo "   - rm -r - deletes directories recursively"
echo "   - wc - counts lines, words, characters"
echo "   - file - identifies file types"
echo
echo "WARNING:  IMPORTANT: rm deletes permanently - there's no trash!"
echo
echo "Next: Run './exercises/help_systems.sh'"
