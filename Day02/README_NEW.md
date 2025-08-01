# Day 2: Variables and Your First Script

## 🎯 **Learning Goal**
Master variables and create your first interactive script. Today you'll make the computer remember things!

## 📚 **What You'll Learn Today**
- Create and use variables
- Get input from users
- Build your first interactive script
- Understand basic script structure

## 🛠️ **Today's Concepts to Master**
```bash
Variables, $USER, $HOME, read, echo, command substitution $()
```

## 📖 **Learning Path** (2-3 hours)

### **Step 1**: Simple Variables (30 min)
```bash
./exercises/simple_variables.sh
```

### **Step 2**: User Input Basics (45 min)
```bash
./exercises/user_input.sh
```

### **Step 3**: Build Your First Tool (60 min)
```bash
./exercises/variables_basics.sh
```

### **Step 4**: Practice Script (30 min)
```bash
./scripts/simple_system_info.sh
```

## ✅ **Daily Challenge**
Create a personal information script:
```bash
#!/bin/bash
read -p "Enter your name: " name
read -p "Enter your favorite tool: " tool
echo "Hello $name! Your favorite tool is $tool"
echo "Report generated on $(date)" > my_report.txt
```

## 🎓 **Success Criteria**
- [ ] Can create and use variables
- [ ] Can get user input with `read`
- [ ] Understand the difference between `$variable` and `${variable}`
- [ ] Can use command substitution `$(command)`
- [ ] Built your first interactive script

## 🚀 **Tomorrow Preview**
Day 3: Making decisions with if/then statements!
