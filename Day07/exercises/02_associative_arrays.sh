#!/bin/bash

# Day 7 Exercise 2: Associative Arrays
# Learning: Hash table operations with key-value pairs

echo "Day 7: Associative Arrays (Hash Tables)"
echo "======================================="

pause() {
    echo
    read -p "Try this command, then press Enter to continue..."
    echo
}

echo "=== PART 1: Creating Associative Arrays ==="
echo

echo "Declare associative array:"
echo "Command: declare -A person"
pause

declare -A person
echo "Associative array 'person' declared"
echo

echo "Add key-value pairs:"
echo "Command: person[\"name\"]=\"John Doe\""
echo "Command: person[\"age\"]=\"30\""
echo "Command: person[\"city\"]=\"New York\""
pause

person["name"]="John Doe"
person["age"]="30"
person["city"]="New York"
person["job"]="Developer"
echo "Person data added"
echo

echo "=== PART 2: Accessing Associative Array Data ==="
echo

echo "Access by key:"
echo "Command: echo \"\${person[\"name\"]}\""
pause

echo "Name: ${person["name"]}"
echo "Age: ${person["age"]}"
echo "City: ${person["city"]}"
echo

echo "Get all values:"
echo "Command: echo \"\${person[@]}\""
pause

echo "All values: ${person[@]}"
echo

echo "Get all keys:"
echo "Command: echo \"\${!person[@]}\""
pause

echo "All keys: ${!person[@]}"
echo

echo "=== PART 3: Multiple Associative Arrays ==="
echo

echo "Create system information arrays:"
declare -A system_info
declare -A network_info

echo "Command: system_info[\"hostname\"]=\"server01\""
echo "Command: network_info[\"ip\"]=\"192.168.1.100\""
pause

system_info["hostname"]="server01"
system_info["os"]="Ubuntu 20.04"
system_info["kernel"]="5.4.0"
system_info["memory"]="16GB"

network_info["ip"]="192.168.1.100"
network_info["subnet"]="255.255.255.0"
network_info["gateway"]="192.168.1.1"
network_info["dns"]="8.8.8.8"

echo "System and network info created"
echo

echo "=== PART 4: Iterating Through Associative Arrays ==="
echo

echo "Loop through keys and values:"
echo "Command: for key in \"\${!person[@]}\"; do echo \"\$key: \${person[\$key]}\"; done"
pause

echo "Person Information:"
for key in "${!person[@]}"; do
    echo "  $key: ${person[$key]}"
done
echo

echo "System Information:"
for key in "${!system_info[@]}"; do
    echo "  $key: ${system_info[$key]}"
done
echo

echo "Network Configuration:"
for key in "${!network_info[@]}"; do
    echo "  $key: ${network_info[$key]}"
done
echo

echo "=== PART 5: Checking Keys and Values ==="
echo

echo "Check if key exists:"
echo "Command: if [[ -v person[\"email\"] ]]; then ... fi"
pause

if [[ -v person["email"] ]]; then
    echo "Email found: ${person["email"]}"
else
    echo "Email not found in person array"
fi

if [[ -v person["name"] ]]; then
    echo "Name found: ${person["name"]}"
fi
echo

echo "Safe access with default value:"
email=${person["email"]:-"not provided"}
phone=${person["phone"]:-"not provided"}
echo "Email: $email"
echo "Phone: $phone"
echo

echo "=== PART 6: Practical Example - Configuration Management ==="
echo

echo "Create application configuration:"
declare -A app_config
declare -A db_config

app_config["name"]="WebApp"
app_config["version"]="2.1.0"
app_config["port"]="8080"
app_config["debug"]="false"
app_config["log_level"]="INFO"

db_config["host"]="localhost"
db_config["port"]="5432"
db_config["database"]="webapp_db"
db_config["user"]="webapp_user"
db_config["ssl"]="true"

echo "Configuration created"
echo

echo "Generate configuration file:"
config_file="app_config.txt"
{
    echo "APPLICATION CONFIGURATION"
    echo "========================"
    echo
    echo "[Application]"
    for key in "${!app_config[@]}"; do
        echo "$key=${app_config[$key]}"
    done
    echo
    echo "[Database]"
    for key in "${!db_config[@]}"; do
        echo "$key=${db_config[$key]}"
    done
} > "$config_file"

echo "Configuration saved to $config_file:"
cat "$config_file"
echo

echo "=== PART 7: Data Processing with Associative Arrays ==="
echo

echo "Process CSV-like data:"
declare -A inventory

# Simulate processing inventory data
items=("laptop:15:1200" "mouse:50:25" "keyboard:30:75" "monitor:8:300")

echo "Processing inventory items:"
for item_data in "${items[@]}"; do
    IFS=':' read -r item quantity price <<< "$item_data"
    inventory["${item}_qty"]="$quantity"
    inventory["${item}_price"]="$price"
    inventory["${item}_value"]=$((quantity * price))
    echo "  Processed: $item (qty: $quantity, price: \$$price, value: \$${inventory["${item}_value"]})"
done
echo

echo "Inventory summary:"
total_value=0
for key in "${!inventory[@]}"; do
    if [[ $key == *"_value" ]]; then
        item_name=${key%_value}
        value=${inventory[$key]}
        total_value=$((total_value + value))
        echo "  ${item_name}: \$${value}"
    fi
done
echo "Total inventory value: \$$total_value"
echo

echo "=== PART 8: Nested-like Structure Simulation ==="
echo

echo "Simulate user database:"
declare -A user1 user2 user3

# User 1
user1["id"]="001"
user1["username"]="alice"
user1["email"]="alice@example.com"
user1["role"]="admin"
user1["last_login"]="2024-01-01"

# User 2
user2["id"]="002"
user2["username"]="bob"
user2["email"]="bob@example.com"
user2["role"]="user"
user2["last_login"]="2024-01-02"

# User 3
user3["id"]="003"
user3["username"]="charlie"
user3["email"]="charlie@example.com"
user3["role"]="user"
user3["last_login"]="2024-01-03"

echo "User database created"
echo

# Function to display user info
display_user() {
    local -n user_ref=$1
    echo "User ID: ${user_ref["id"]}"
    echo "Username: ${user_ref["username"]}"
    echo "Email: ${user_ref["email"]}"
    echo "Role: ${user_ref["role"]}"
    echo "Last Login: ${user_ref["last_login"]}"
    echo
}

echo "User Database Report:"
echo "===================="
echo "User 1:"
display_user user1
echo "User 2:"
display_user user2
echo "User 3:"
display_user user3

# Clean up
rm -f "$config_file"

echo "What you learned:"
echo "   - declare -A to create associative arrays"
echo "   - array[\"key\"]=\"value\" for assignments"
echo "   - \${array[\"key\"]} for access"
echo "   - \${!array[@]} for all keys"
echo "   - \${array[@]} for all values"
echo "   - [[ -v array[\"key\"] ]] to check key existence"
echo "   - Key-value data processing"
echo "   - Configuration management"
echo "   - Simulating complex data structures"
echo
echo "Next: Learn advanced array processing techniques"
