# Day 1: Your First Steps - Command Line Basics

## 🎯 **Learning Goal**
Master the essential commands you'll use every day. By the end of today, you'll navigate Linux like a pro.

## 📚 **What You'll Learn Today**
- Navigate directories confidently
- Create, view, and manage files
- Understand command structure
- Use help systems effectively

## 🛠️ **Today's Commands to Master**
```bash
ls, cd, pwd, mkdir, touch, cat, cp, mv, rm, echo, man, which
```

## 📖 **Learning Path** (2-3 hours)

### **Step 1**: Run the Welcome Script (5 min)
```bash
./scripts/welcome.sh
```

### **Step 2**: Interactive Command Practice (45 min)
```bash
./exercises/command_practice.sh
```

### **Step 3**: File Operations Workshop (30 min)
```bash
./exercises/file_operations.sh
```

### **Step 4**: Command Structure & Help (30 min)
```bash
./exercises/basic_commands.sh
```

### **Step 5**: Error Handling Basics (20 min)
```bash
./exercises/basic_error_handling.sh
```

## ✅ **Daily Challenge**
Create a directory structure for a security project:
```bash
mkdir -p security_project/{logs,tools,reports,configs}
echo "Project started on $(date)" > security_project/README.txt
```

## 🎓 **Success Criteria**
- [ ] Can navigate directories without thinking
- [ ] Can create/copy/move/delete files confidently
- [ ] Understand command syntax: `command [options] [arguments]`
- [ ] Know how to get help with `man` and `--help`

## 🚀 **Tomorrow Preview**
Day 2: Variables and making your first interactive script!

---

## 📋 **Commands Reference**

### **Navigation**
- `pwd` - Print working directory
- `ls` - List files (`ls -la` for detailed view)
- `cd` - Change directory (`cd ..` for parent, `cd -` for previous)

### **File Operations**
- `touch filename` - Create empty file
- `mkdir dirname` - Create directory
- `cp source dest` - Copy files
- `mv source dest` - Move/rename files
- `rm filename` - Delete files (CAREFUL!)

### **Viewing Files**
- `cat filename` - Display file content
- `echo "text"` - Display text
- `wc filename` - Count lines/words/characters

### **Getting Help**
- `man command` - Manual page
- `command --help` - Quick help
- `which command` - Find command location

## 💡 **Pro Tips**
- Use Tab completion to avoid typing full filenames
- Use `history` to see previous commands
- Use `!!` to repeat the last command
- Use Ctrl+C to cancel a running command
