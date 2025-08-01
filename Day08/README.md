# Day 8: Error Handling and Debugging

## 🎯 **Learning Goal**
Make your scripts bulletproof with proper error handling and debugging.

## 📚 **What You'll Learn Today**
- Exit codes and error detection
- Try/catch equivalents in bash
- Debugging techniques
- Logging and error reporting

## 🛠️ **Today's Concepts to Master**
```bash
set -e, set -u, trap, $?, ||, &&, 2>&1, logger
```

## 📖 **Learning Path** (3-4 hours)

### **Step 1**: Exit Codes and Detection (60 min)
```bash
./exercises/exit_codes.sh
```

### **Step 2**: Error Trapping (90 min)
```bash
./exercises/error_trapping.sh
```

### **Step 3**: Debugging Techniques (90 min)
```bash
./exercises/debugging.sh
```

### **Step 4**: Build a Robust Script (120 min)
```bash
./scripts/bulletproof_script.sh
```

## ✅ **Daily Challenge**
Create a safe file processor:
```bash
#!/bin/bash
set -e
set -u

process_file() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        echo "ERROR: File $file not found" >&2
        return 1
    fi
    
    if [[ ! -r "$file" ]]; then
        echo "ERROR: Cannot read $file" >&2
        return 1
    fi
    
    wc -l "$file" || {
        echo "ERROR: Failed to process $file" >&2
        return 1
    }
}

trap 'echo "Script interrupted!" >&2; exit 1' INT TERM

for file in "$@"; do
    process_file "$file" || echo "Skipping $file due to errors"
done
```

## 🎓 **Success Criteria**
- [ ] Can handle errors gracefully
- [ ] Understand exit codes and trapping
- [ ] Can debug script problems
- [ ] Built a production-ready script

## 🚀 **Tomorrow Preview**
Day 9: Command-line argument processing!
