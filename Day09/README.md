# Day 9: Command-Line Arguments and Options

## 🎯 **Learning Goal**
Make professional command-line tools with proper argument processing.

## 📚 **What You'll Learn Today**
- Processing command-line arguments
- Handling flags and options
- Using getopts for professional tools
- Building user-friendly interfaces

## 🛠️ **Today's Concepts to Master**
```bash
$1, $2, $@, $#, getopts, shift, case
```

## 📖 **Learning Path** (4-5 hours)

### **Step 1**: Basic Arguments (60 min)
```bash
./exercises/basic_arguments.sh
```

### **Step 2**: Getopts Processing (120 min)
```bash
./exercises/getopts_processing.sh
```

### **Step 3**: Advanced Option Handling (90 min)
```bash
./exercises/advanced_options.sh
```

### **Step 4**: Build a Professional Tool (150 min)
```bash
./scripts/professional_scanner.sh
```

## ✅ **Daily Challenge**
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

## 🎓 **Success Criteria**
- [ ] Can process command-line arguments
- [ ] Can use getopts for options
- [ ] Can build professional CLIs
- [ ] Created a tool with help system

## 🚀 **Tomorrow Preview**
Day 10: Process management and job control!
