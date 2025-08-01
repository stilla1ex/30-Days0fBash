# Day 6: Text Processing and Pattern Matching

## 🎯 **Learning Goal**
Master text processing tools for log analysis and data extraction.

## 📚 **What You'll Learn Today**
- grep, sed, awk fundamentals
- Regular expressions basics
- Text filtering and transformation
- Log analysis techniques

## 🛠️ **Today's Tools to Master**
```bash
grep, egrep, sed, awk, cut, sort, uniq, tr
```

## 📖 **Learning Path** (4-5 hours)

### **Step 1**: Grep and Pattern Matching (90 min)
```bash
./exercises/grep_patterns.sh
```

### **Step 2**: Sed Text Replacement (90 min)
```bash
./exercises/sed_basics.sh
```

### **Step 3**: Awk Field Processing (90 min)
```bash
./exercises/awk_basics.sh
```

### **Step 4**: Build a Log Analyzer (120 min)
```bash
./scripts/advanced_log_analyzer.sh
```

## ✅ **Daily Challenge**
Create an IP extractor:
```bash
#!/bin/bash
# Extract all IP addresses from access logs
grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/log/apache2/access.log | \
awk '{print $1}' | sort | uniq -c | sort -nr
```

## 🎓 **Success Criteria**
- [ ] Can use grep with patterns
- [ ] Can replace text with sed
- [ ] Can process fields with awk
- [ ] Built a text processing tool

## 🚀 **Tomorrow Preview**
Day 7: Arrays and advanced data structures!
