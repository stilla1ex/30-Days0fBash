# Day 3: Making Decisions - If/Then/Else

## 🎯 **Learning Goal**
Make your scripts smart! Learn to make decisions based on conditions.

## 📚 **What You'll Learn Today**
- If/then/else statements
- Testing conditions
- File and string comparisons
- Building logic into scripts

## 🛠️ **Today's Concepts to Master**
```bash
if, then, else, elif, fi, test, [, [[, -f, -d, -z, -n
```

## 📖 **Learning Path** (3-4 hours)

### **Step 1**: Basic Conditionals (45 min)
```bash
./exercises/basic_conditionals.sh
```

### **Step 2**: File Testing (45 min)
```bash
./exercises/file_tests.sh
```

### **Step 3**: String Comparisons (45 min)
```bash
./exercises/string_tests.sh
```

### **Step 4**: Build a Security Checker (60 min)
```bash
./scripts/basic_security_check.sh
```

## ✅ **Daily Challenge**
Create a file backup script:
```bash
#!/bin/bash
read -p "Enter filename to backup: " file
if [ -f "$file" ]; then
    cp "$file" "${file}.backup.$(date +%Y%m%d)"
    echo "Backup created!"
else
    echo "File not found!"
fi
```

## 🎓 **Success Criteria**
- [ ] Can write if/then/else statements
- [ ] Understand file testing (`-f`, `-d`, `-r`, `-w`)
- [ ] Can compare strings and numbers
- [ ] Built a decision-making script

## 🚀 **Tomorrow Preview**
Day 4: Loops - Making scripts do repetitive tasks!
