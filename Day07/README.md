# Day 7: Arrays and Advanced Data Structures

## 🎯 **Learning Goal**
Master arrays to handle multiple pieces of data efficiently.

## 📚 **What You'll Learn Today**
- Creating and using arrays
- Associative arrays (hash tables)
- Processing array data
- Building data-driven scripts

## 🛠️ **Today's Concepts to Master**
```bash
array=(), ${array[@]}, ${!array[@]}, declare -A
```

## 📖 **Learning Path** (3-4 hours)

### **Step 1**: Basic Arrays (60 min)
```bash
./exercises/basic_arrays.sh
```

### **Step 2**: Associative Arrays (90 min)
```bash
./exercises/associative_arrays.sh
```

### **Step 3**: Array Processing (90 min)
```bash
./exercises/array_processing.sh
```

### **Step 4**: Build a Contact Manager (120 min)
```bash
./scripts/contact_manager.sh
```

## ✅ **Daily Challenge**
Create a port scanner tracker:
```bash
#!/bin/bash
declare -A port_status
ports=(22 80 443 3389 5432)

for port in "${ports[@]}"; do
    if nc -z localhost $port 2>/dev/null; then
        port_status[$port]="OPEN"
    else
        port_status[$port]="CLOSED"
    fi
done

for port in "${!port_status[@]}"; do
    echo "Port $port: ${port_status[$port]}"
done
```

## 🎓 **Success Criteria**
- [ ] Can create and manipulate arrays
- [ ] Understand associative arrays
- [ ] Can loop through array data
- [ ] Built a data management script

## 🚀 **Tomorrow Preview**
Day 8: Error handling and debugging!
