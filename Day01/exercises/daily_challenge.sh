#!/bin/bash
# Day 1 Challenge: Build Your First Project Structure
# Apply what you've learned to create a real project

echo "🏆 Day 1 Challenge: Create Your Security Project"
echo "Time to apply everything you've learned!"
echo

echo "🎯 YOUR MISSION:"
echo "Create a directory structure for a cybersecurity project"
echo "and practice all the commands you've learned today."
echo

pause() {
    echo
    read -p "Press Enter when you've completed this step..."
    echo
}

echo "=== CHALLENGE STEPS ==="
echo

echo "STEP 1: Create the main project directory"
echo "Command to use: mkdir security_project"
echo "Create a directory called 'security_project'"
pause

if [ -d "security_project" ]; then
    echo "✅ Great! security_project directory created"
else
    echo "❌ Directory not found. Did you create it?"
    echo "Hint: mkdir security_project"
    exit 1
fi

echo "STEP 2: Create subdirectories"
echo "Create these directories inside security_project:"
echo "  • logs"
echo "  • tools" 
echo "  • reports"
echo "  • configs"
echo
echo "Commands to use: cd security_project, then mkdir for each"
pause

if [ -d "security_project/logs" ] && [ -d "security_project/tools" ] && [ -d "security_project/reports" ] && [ -d "security_project/configs" ]; then
    echo "✅ Excellent! All subdirectories created"
else
    echo "❌ Some directories are missing. Check your work:"
    echo "Expected: logs, tools, reports, configs"
    echo "Found:"
    ls security_project/ 2>/dev/null || echo "  (none - did you cd into security_project?)"
    exit 1
fi

echo "STEP 3: Create project files"
echo "Create these files in the security_project directory:"
echo "  • README.txt (with project description)"
echo "  • project_info.txt (with your name and date)"
echo
echo "Commands to use: touch filename, echo 'content' > filename"
pause

if [ -f "security_project/README.txt" ] && [ -f "security_project/project_info.txt" ]; then
    echo "✅ Perfect! Project files created"
else
    echo "❌ Some files are missing:"
    echo "Expected: README.txt, project_info.txt" 
    echo "Found:"
    ls security_project/*.txt 2>/dev/null || echo "  (no .txt files found)"
    exit 1
fi

echo "STEP 4: Add content to files"
echo "Add meaningful content to your files:"
echo "  • README.txt should describe what this project is for"
echo "  • project_info.txt should have your name and today's date"
echo
echo "Hint: Use echo 'your content' > filename"
pause

# Check if files have content
readme_size=$(wc -c < security_project/README.txt 2>/dev/null || echo 0)
info_size=$(wc -c < security_project/project_info.txt 2>/dev/null || echo 0)

if [ "$readme_size" -gt 0 ] && [ "$info_size" -gt 0 ]; then
    echo "✅ Awesome! Files have content"
else
    echo "❌ Files appear to be empty. Add some content!"
    exit 1
fi

echo "STEP 5: Create a backup copy"
echo "Make a backup copy of your project_info.txt file"
echo "Name the backup: project_info_backup.txt"
echo
echo "Command to use: cp"
pause

if [ -f "security_project/project_info_backup.txt" ]; then
    echo "✅ Great! Backup created"
else
    echo "❌ Backup file not found"
    echo "Hint: cp project_info.txt project_info_backup.txt"
    exit 1
fi

echo "STEP 6: Explore your creation"
echo "Use commands to explore what you've built:"
echo "  • List all files and directories (with details)"
echo "  • Show the contents of your files"
echo "  • Check the current directory"
echo
echo "Commands to try: ls -la, cat filename, pwd"
pause

echo "=== FINAL VERIFICATION ==="
echo "Let's see what you've built:"
echo

echo "📁 Project structure:"
echo "Current directory: $(pwd)"
echo
echo "Project overview:"
ls -la security_project/ 2>/dev/null || echo "Project directory not accessible"
echo

echo "📄 File contents:"
if [ -f "security_project/README.txt" ]; then
    echo "README.txt:"
    cat security_project/README.txt
    echo
fi

if [ -f "security_project/project_info.txt" ]; then
    echo "project_info.txt:"
    cat security_project/project_info.txt
    echo
fi

echo "🎉 CHALLENGE COMPLETE!"
echo
echo "🏆 What you accomplished:"
echo "   ✅ Created a project directory structure"
echo "   ✅ Used mkdir to create directories"
echo "   ✅ Used touch and echo to create files"
echo "   ✅ Added content to files"
echo "   ✅ Made backup copies with cp"
echo "   ✅ Explored your work with ls and cat"
echo
echo "🎓 Skills demonstrated:"
echo "   • Directory navigation"
echo "   • File and directory creation"
echo "   • File content management"
echo "   • File copying"
echo "   • Project organization"
echo
echo "🚀 You're ready for Day 2!"
echo "Tomorrow you'll learn about variables and make your first interactive script!"

# Optional cleanup prompt
echo
read -p "Would you like to keep your project or clean it up? (keep/clean): " choice
if [ "$choice" = "clean" ]; then
    rm -rf security_project
    echo "🧹 Project cleaned up!"
else
    echo "📁 Project saved for your portfolio!"
fi
