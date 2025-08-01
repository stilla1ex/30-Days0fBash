# Day 5: Functions - Organizing Your Code

## 🎯 **Learning Goal**
Learn to organize code with functions. Write once, use many times!

## 📚 **What You'll Learn Today**
- Creating and calling functions
- Function parameters and return values
- Local vs global variables
- Building modular scripts

## 🛠️ **Today's Concepts to Master**
```bash
function, return, local, $1, $2, $@, $#
```

## 📖 **Learning Path** (3-4 hours)

### **Step 1**: Basic Functions (60 min)
```bash
./exercises/basic_functions.sh
```

### **Step 2**: Function Parameters (60 min)
```bash
./exercises/function_parameters.sh
```

### **Step 3**: Advanced Functions (60 min)
```bash
./exercises/advanced_functions.sh
```

### **Step 4**: Build a Utility Library (90 min)
```bash
./scripts/utility_functions.sh
```

## ✅ **Daily Challenge**
Create a system info function library:
```bash
#!/bin/bash
get_system_info() {
    echo "System: $(uname -s)"
    echo "User: $(whoami)"
    echo "Date: $(date)"
}

get_disk_space() {
    df -h | head -5
}

# Call functions
get_system_info
echo "---"
get_disk_space
```

## 🎓 **Success Criteria**
- [ ] Can create and call functions
- [ ] Understand function parameters and scope
- [ ] Can pass arguments to functions
- [ ] Built a reusable function library

## 🚀 **Tomorrow Preview**
Day 6: Text processing and regular expressions!
