# Day 4: Loops - Automating Repetitive Tasks

## 🎯 **Learning Goal**
Master loops to automate repetitive tasks. No more manual work!

## 📚 **What You'll Learn Today**
- For loops with lists and ranges
- While loops with conditions
- Processing multiple files
- Building efficient automation

## 🛠️ **Today's Concepts to Master**
```bash
for, while, do, done, in, seq, break, continue
```

## 📖 **Learning Path** (3-4 hours)

### **Step 1**: For Loops Basics (60 min)
```bash
./exercises/for_loops.sh
```

### **Step 2**: While Loops (45 min)
```bash
./exercises/while_loops.sh
```

### **Step 3**: File Processing (60 min)
```bash
./exercises/file_processing.sh
```

### **Step 4**: Build a Batch Processor (90 min)
```bash
./scripts/batch_file_processor.sh
```

## ✅ **Daily Challenge**
Create a log analyzer:
```bash
#!/bin/bash
for log in /var/log/*.log; do
    if [ -r "$log" ]; then
        echo "=== $log ==="
        wc -l "$log"
        echo
    fi
done
```

## 🎓 **Success Criteria**
- [ ] Can write for loops with lists and ranges
- [ ] Can create while loops with conditions
- [ ] Can process multiple files efficiently
- [ ] Built an automation script

## 🚀 **Tomorrow Preview**
Day 5: Functions - Organizing your code like a pro!
