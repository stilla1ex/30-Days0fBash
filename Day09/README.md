# Day 9: Command-Line Arguments and Options

## Learning Goals
Master command-line argument processing and build professional command-line tools

## Concepts Covered
- Command-line argument processing ($1, $2, $@, $#)
- Options and flags with getopts
- Advanced argument validation
- Building user-friendly CLI interfaces
- Help systems and usage documentation

## Exercises
1. `basic_arguments.sh` - Command-line argument fundamentals
2. `getopts_processing.sh` - Professional option handling with getopts
3. `advanced_options.sh` - Complex argument validation and processing
4. `daily_challenge.sh` - Complete CLI application framework

## Success Criteria
- Process command-line arguments effectively
- Handle options and flags professionally
- Validate and sanitize user inputs
- Create intuitive command-line interfaces

## Today's Learning Path

### Step 1: Basic Arguments (60 min)
Learn argument processing fundamentals

### Step 2: Getopts Processing (75 min)
Master professional option handling

### Step 3: Advanced Options (60 min)
Build complex argument validation systems

### Step 4: CLI Framework Challenge (90 min)
Create a complete command-line application

## Success Milestone
By the end of Day 9, you'll build professional command-line tools with robust argument handling.
```bash
./exercises/advanced_options.sh
```

### **Step 4**: Build a Professional Tool (150 min)
```bash
./scripts/professional_scanner.sh
```

## Daily Challenge
Create a file analyzer with options:
```bash
#!/bin/bash

usage() {
    echo "Usage: $0 [-v] [-c] [-l] file..."
    echo "  -v  Verbose output"
    echo "  -c  Count characters"
    echo "  -l  Count lines only"
    exit 1
}

verbose=false
count_chars=false
lines_only=false

while getopts "vcl" opt; do
    case $opt in
        v) verbose=true ;;
        c) count_chars=true ;;
        l) lines_only=true ;;
        *) usage ;;
    esac
done

shift $((OPTIND-1))

[[ $# -eq 0 ]] && usage

for file in "$@"; do
    [[ $verbose == true ]] && echo "Processing: $file"
    
    if [[ $lines_only == true ]]; then
        wc -l "$file"
    elif [[ $count_chars == true ]]; then
        wc -c "$file"
    else
        wc "$file"
    fi
done
```

## Success Criteria
- [ ] Can process command-line arguments
- [ ] Can use getopts for options
- [ ] Can build professional CLIs
- [ ] Created a tool with help system

## Tomorrow Preview
Day 10: Process management and job control!
