#!/bin/bash
# Day 2 Challenge: Personal Information Manager
# Build a complete personal information system

echo "Day 2 Challenge: Personal Information Manager"
echo "Create a system to store and retrieve personal information"
echo

pause() {
    echo
    read -p "Complete this step, then press Enter to continue..."
    echo
}

echo "=== YOUR MISSION ==="
echo "Build a personal information manager that:"
echo "1. Collects personal information"
echo "2. Stores it in files"
echo "3. Can retrieve and display it"
echo "4. Creates reports with timestamps"
echo

echo "=== CHALLENGE PART 1: Data Collection ==="
echo "Create variables to store personal information:"
echo "- Full name"
echo "- Email address"
echo "- Phone number"
echo "- Favorite programming language"
echo "- Years of experience"
pause

# Collect information
read -p "Full name: " full_name
read -p "Email address: " email
read -p "Phone number: " phone
read -p "Favorite programming language: " fav_language
read -p "Years of experience: " experience

echo "Information collected successfully!"
echo

echo "=== CHALLENGE PART 2: File Creation ==="
echo "Create a data file with timestamp:"
data_file="personal_info_$(date +%Y%m%d_%H%M%S).txt"
echo "Creating file: $data_file"
pause

# Create the data file
cat > "$data_file" << EOF
PERSONAL INFORMATION
==================
Name: $full_name
Email: $email
Phone: $phone
Favorite Language: $fav_language
Experience: $experience years
Created: $(date)
Created by: $(whoami)
System: $(hostname)
EOF

echo "Data file created successfully!"
echo

echo "=== CHALLENGE PART 3: Report Generation ==="
echo "Generate different types of reports:"
echo

# Quick summary
echo "QUICK SUMMARY:"
echo "Name: $full_name"
echo "Language: $fav_language"
echo "Experience: $experience years"
echo

# Contact card
contact_file="contact_card_$(date +%Y%m%d).txt"
echo "Creating contact card: $contact_file"

cat > "$contact_file" << EOF
CONTACT CARD
============
$full_name
$email
$phone
Generated: $(date +%Y-%m-%d)
EOF

echo "Contact card created!"
echo

echo "=== CHALLENGE PART 4: System Integration ==="
echo "Add system information to your profile:"

# Enhanced profile
profile_file="complete_profile_$(date +%Y%m%d).txt"

cat > "$profile_file" << EOF
COMPLETE PROFILE
===============
Personal Information:
  Name: $full_name
  Email: $email
  Phone: $phone
  Favorite Language: $fav_language
  Experience: $experience years

System Information:
  Username: $(whoami)
  Hostname: $(hostname)
  Operating System: $(uname -s)
  Current Directory: $(pwd)
  Home Directory: $HOME
  Shell: $SHELL

Session Information:
  Created: $(date)
  Day of year: $(date +%j)
  Week number: $(date +%U)
EOF

echo "Complete profile created: $profile_file"
echo

echo "=== CHALLENGE PART 5: File Management ==="
echo "Organize your files:"

# Create directory structure
info_dir="personal_info_$(date +%Y%m%d)"
mkdir -p "$info_dir"

# Move files to directory
mv "$data_file" "$info_dir/"
mv "$contact_file" "$info_dir/"
mv "$profile_file" "$info_dir/"

echo "Files organized in directory: $info_dir"
echo "Directory contents:"
ls -la "$info_dir"
echo

echo "=== FINAL VERIFICATION ==="
echo "Let's verify everything was created correctly:"

echo
echo "Files created:"
ls -la "$info_dir"

echo
echo "Data file contents:"
cat "$info_dir/personal_info_"*.txt

echo
echo "Contact card contents:"
cat "$info_dir/contact_card_"*.txt

echo
echo "CHALLENGE COMPLETED!"
echo
echo "What you accomplished:"
echo "  - Collected user input with validation"
echo "  - Used variables to store information"
echo "  - Applied command substitution for timestamps"
echo "  - Created multiple file types"
echo "  - Organized files in directories"
echo "  - Generated reports with system information"
echo
echo "Skills demonstrated:"
echo "  - Variable creation and usage"
echo "  - User input handling"
echo "  - Command substitution"
echo "  - File creation and management"
echo "  - Directory organization"
echo "  - Report generation"
echo
echo "You're ready for Day 3!"
echo "Tomorrow you'll learn conditional statements (if/then/else)!"

# Cleanup option
echo
read -p "Keep your files or clean up? (keep/clean): " cleanup_choice
if [ "$cleanup_choice" = "clean" ]; then
    rm -rf "$info_dir"
    echo "Files cleaned up!"
else
    echo "Files saved in $info_dir for your portfolio!"
fi
