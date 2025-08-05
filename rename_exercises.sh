#!/bin/bash

echo "🔄 Renaming exercise files with proper numbering"
echo

rename_day_exercises() {
    local day_dir=$1
    echo "📁 Processing $day_dir exercises..."
    
    cd "$day_dir/exercises" || return
    
    # Define the proper order based on main README for each day
    case "$(basename "$day_dir")" in
        "Day01")
            # Day 1: Command Line Basics
            [ -f "navigation_basics.sh" ] && mv "navigation_basics.sh" "01_navigation_basics.sh"
            [ -f "file_basics.sh" ] && mv "file_basics.sh" "02_file_basics.sh"
            [ -f "help_systems.sh" ] && mv "help_systems.sh" "03_help_systems.sh"
            [ -f "basic_error_handling.sh" ] && mv "basic_error_handling.sh" "04_basic_error_handling.sh"
            [ -f "daily_challenge.sh" ] && mv "daily_challenge.sh" "05_daily_challenge.sh"
            ;;
        "Day02")
            # Day 2: Variables and Basic Scripting
            [ -f "variables_intro.sh" ] && mv "variables_intro.sh" "01_variables_intro.sh"
            [ -f "user_input.sh" ] && mv "user_input.sh" "02_user_input.sh"
            [ -f "environment_vars.sh" ] && mv "environment_vars.sh" "03_environment_vars.sh"
            [ -f "daily_challenge.sh" ] && mv "daily_challenge.sh" "04_daily_challenge.sh"
            ;;
        "Day03")
            # Day 3: Conditionals and Decision Making
            [ -f "if_statements.sh" ] && mv "if_statements.sh" "01_if_statements.sh"
            [ -f "test_conditions.sh" ] && mv "test_conditions.sh" "02_test_conditions.sh"
            [ -f "case_statements.sh" ] && mv "case_statements.sh" "03_case_statements.sh"
            [ -f "daily_challenge.sh" ] && mv "daily_challenge.sh" "04_daily_challenge.sh"
            ;;
        *)
            # Generic numbering for other days
            counter=1
            for file in *.sh; do
                if [[ "$file" != "0"* && -f "$file" ]]; then
                    new_name=$(printf "%02d_%s" $counter "$file")
                    mv "$file" "$new_name"
                    echo "  - Renamed: $file → $new_name"
                    ((counter++))
                fi
            done
            ;;
    esac
    
    echo "  ✅ $day_dir exercises numbered"
    cd ../..
}

# Process all Day directories
for day_dir in Day*/; do
    if [ -d "$day_dir/exercises" ]; then
        rename_day_exercises "$day_dir"
    fi
done

echo
echo "🎉 All exercise files renamed with proper numbering!"
echo
echo "Updated structure:"
for day_dir in Day*/; do
    if [ -d "$day_dir/exercises" ]; then
        echo "📂 $day_dir/exercises/:"
        ls "$day_dir/exercises/" | sed 's/^/  /'
    fi
done
