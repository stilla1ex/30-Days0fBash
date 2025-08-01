# Day 7: Arrays and Advanced Data Structures

## Learning Goal
Master arrays to handle multiple pieces of data efficiently.

## What You'll Learn Today
- Creating and using arrays
- Associative arrays (hash tables)
- Processing array data
- Building data-driven scripts

## Today's Concepts to Master
```bash
array=(), ${array[@]}, ${!array[@]}, declare -A
```

## Exercises
1. `basic_arrays.sh` - Indexed array fundamentals
2. `associative_arrays.sh` - Hash table operations
3. `array_processing.sh` - Data manipulation with arrays
4. `daily_challenge.sh` - Contact management system

## Success Criteria
- Create and manipulate indexed arrays
- Use associative arrays for key-value storage
- Process arrays with loops and conditions
- Build practical data management tools

## Today's Learning Path

### Step 1: Basic Arrays (60 min)
Learn indexed array creation and manipulation

### Step 2: Associative Arrays (75 min)
Master key-value data structures

### Step 3: Array Processing (60 min)
Advanced array operations and algorithms

### Step 4: Contact Manager Challenge (90 min)
Build a complete contact management system

## Success Milestone
By the end of Day 7, you'll manage complex data structures and build data-driven applications.
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
