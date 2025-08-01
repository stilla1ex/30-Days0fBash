# Day 7: Arrays and Advanced Data Structures

## Learning Goals
Master arrays to handle multiple pieces of data efficiently and build data-driven scripts

## Concepts Covered
- Creating and using indexed arrays
- Associative arrays (hash tables)
- Array operations and loops
- Data storage and retrieval
- Configuration management with arrays

## Today's Commands to Master
```bash
array=(), ${array[@]}, ${!array[@]}, declare -A, unset
```

## Exercises
1. `basic_arrays.sh` - Indexed array fundamentals
2. `associative_arrays.sh` - Hash table operations
3. `array_processing.sh` - Array loops and manipulation
4. `daily_challenge.sh` - Configuration manager

## Success Criteria
- Create and manipulate indexed arrays
- Use associative arrays for key-value storage
- Process arrays with loops efficiently
- Build data-driven configuration systems

## Today's Learning Path

### Step 1: Basic Arrays (45 min)
Learn indexed array creation and manipulation

### Step 2: Associative Arrays (60 min)
Master key-value pair storage and retrieval

### Step 3: Array Processing (45 min)
Process arrays with loops and operations

### Step 4: Configuration Challenge (45 min)
Build a configuration management system

## Success Milestone
By the end of Day 7, you'll manage complex data structures and build sophisticated data-driven scripts.

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

## Daily Challenge
Create a port scanner tracker using associative arrays to monitor the status of specific ports.
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

## Success Criteria
- [ ] Can create and manipulate arrays
- [ ] Understand associative arrays
- [ ] Can loop through array data
- [ ] Built a data management script

## Tomorrow Preview
Day 8: Error handling and debugging!
