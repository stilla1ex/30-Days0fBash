#!/bin/bash

# Day 7 Daily Challenge: Contact Management System
# Build a complete contact management application using arrays

echo "Day 7 Challenge: Contact Management System"
echo "=========================================="

# Global associative arrays for contact storage
declare -A contacts_name
declare -A contacts_email  
declare -A contacts_phone
declare -A contacts_company
declare -A contacts_notes

# Array to track contact IDs
contact_ids=()
next_id=1

# Function to display menu
show_menu() {
    echo
    echo "CONTACT MANAGEMENT SYSTEM"
    echo "========================"
    echo "1. Add Contact"
    echo "2. View All Contacts"
    echo "3. Search Contact"
    echo "4. Update Contact"
    echo "5. Delete Contact"
    echo "6. Export Contacts"
    echo "7. Import Contacts"
    echo "8. Statistics"
    echo "9. Exit"
    echo
}

# Function to add a new contact
add_contact() {
    echo
    echo "ADD NEW CONTACT"
    echo "==============="
    
    local id=$next_id
    
    read -p "Name: " name
    read -p "Email: " email
    read -p "Phone: " phone
    read -p "Company: " company
    read -p "Notes: " notes
    
    # Store contact data
    contacts_name[$id]="$name"
    contacts_email[$id]="$email"
    contacts_phone[$id]="$phone"
    contacts_company[$id]="$company"
    contacts_notes[$id]="$notes"
    
    # Add ID to tracking array
    contact_ids+=($id)
    
    echo
    echo "Contact added successfully! (ID: $id)"
    next_id=$((next_id + 1))
}

# Function to view all contacts
view_all_contacts() {
    echo
    echo "ALL CONTACTS"
    echo "============"
    
    if [ ${#contact_ids[@]} -eq 0 ]; then
        echo "No contacts found."
        return
    fi
    
    printf "%-4s %-20s %-25s %-15s %-20s\n" "ID" "Name" "Email" "Phone" "Company"
    printf "%-4s %-20s %-25s %-15s %-20s\n" "---" "----" "-----" "-----" "-------"
    
    for id in "${contact_ids[@]}"; do
        printf "%-4s %-20s %-25s %-15s %-20s\n" \
            "$id" \
            "${contacts_name[$id]}" \
            "${contacts_email[$id]}" \
            "${contacts_phone[$id]}" \
            "${contacts_company[$id]}"
    done
    
    echo
    echo "Total contacts: ${#contact_ids[@]}"
}

# Function to search contacts
search_contact() {
    echo
    echo "SEARCH CONTACTS"
    echo "==============="
    
    read -p "Enter search term (name, email, phone, or company): " search_term
    
    local found=false
    
    echo
    echo "Search Results:"
    printf "%-4s %-20s %-25s %-15s %-20s\n" "ID" "Name" "Email" "Phone" "Company"
    printf "%-4s %-20s %-25s %-15s %-20s\n" "---" "----" "-----" "-----" "-------"
    
    for id in "${contact_ids[@]}"; do
        if [[ "${contacts_name[$id]}" == *"$search_term"* ]] || \
           [[ "${contacts_email[$id]}" == *"$search_term"* ]] || \
           [[ "${contacts_phone[$id]}" == *"$search_term"* ]] || \
           [[ "${contacts_company[$id]}" == *"$search_term"* ]]; then
            
            printf "%-4s %-20s %-25s %-15s %-20s\n" \
                "$id" \
                "${contacts_name[$id]}" \
                "${contacts_email[$id]}" \
                "${contacts_phone[$id]}" \
                "${contacts_company[$id]}"
            found=true
        fi
    done
    
    if [ "$found" = false ]; then
        echo "No contacts found matching '$search_term'"
    fi
}

# Function to display detailed contact info
show_contact_details() {
    local id=$1
    
    echo "Contact Details (ID: $id)"
    echo "========================"
    echo "Name: ${contacts_name[$id]}"
    echo "Email: ${contacts_email[$id]}"
    echo "Phone: ${contacts_phone[$id]}"
    echo "Company: ${contacts_company[$id]}"
    echo "Notes: ${contacts_notes[$id]}"
    echo
}

# Function to update contact
update_contact() {
    echo
    echo "UPDATE CONTACT"
    echo "=============="
    
    read -p "Enter contact ID to update: " id
    
    # Check if contact exists
    local exists=false
    for existing_id in "${contact_ids[@]}"; do
        if [ "$existing_id" = "$id" ]; then
            exists=true
            break
        fi
    done
    
    if [ "$exists" = false ]; then
        echo "Contact ID $id not found."
        return
    fi
    
    echo
    show_contact_details "$id"
    
    echo "Enter new values (press Enter to keep current value):"
    
    read -p "Name [${contacts_name[$id]}]: " new_name
    read -p "Email [${contacts_email[$id]}]: " new_email
    read -p "Phone [${contacts_phone[$id]}]: " new_phone
    read -p "Company [${contacts_company[$id]}]: " new_company
    read -p "Notes [${contacts_notes[$id]}]: " new_notes
    
    # Update only if new value provided
    [ -n "$new_name" ] && contacts_name[$id]="$new_name"
    [ -n "$new_email" ] && contacts_email[$id]="$new_email"
    [ -n "$new_phone" ] && contacts_phone[$id]="$new_phone"
    [ -n "$new_company" ] && contacts_company[$id]="$new_company"
    [ -n "$new_notes" ] && contacts_notes[$id]="$new_notes"
    
    echo
    echo "Contact updated successfully!"
}

# Function to delete contact
delete_contact() {
    echo
    echo "DELETE CONTACT"
    echo "=============="
    
    read -p "Enter contact ID to delete: " id
    
    # Check if contact exists
    local exists=false
    local index=0
    for existing_id in "${contact_ids[@]}"; do
        if [ "$existing_id" = "$id" ]; then
            exists=true
            break
        fi
        index=$((index + 1))
    done
    
    if [ "$exists" = false ]; then
        echo "Contact ID $id not found."
        return
    fi
    
    echo
    show_contact_details "$id"
    
    read -p "Are you sure you want to delete this contact? (y/N): " confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        # Remove from associative arrays
        unset contacts_name[$id]
        unset contacts_email[$id]
        unset contacts_phone[$id]
        unset contacts_company[$id]
        unset contacts_notes[$id]
        
        # Remove from ID tracking array
        unset contact_ids[$index]
        # Rebuild array to remove gaps
        contact_ids=("${contact_ids[@]}")
        
        echo "Contact deleted successfully!"
    else
        echo "Delete cancelled."
    fi
}

# Function to export contacts to file
export_contacts() {
    echo
    echo "EXPORT CONTACTS"
    echo "==============="
    
    local filename="contacts_$(date +%Y%m%d_%H%M%S).csv"
    
    echo "ID,Name,Email,Phone,Company,Notes" > "$filename"
    
    for id in "${contact_ids[@]}"; do
        echo "$id,\"${contacts_name[$id]}\",\"${contacts_email[$id]}\",\"${contacts_phone[$id]}\",\"${contacts_company[$id]}\",\"${contacts_notes[$id]}\"" >> "$filename"
    done
    
    echo "Contacts exported to: $filename"
    echo "Total contacts exported: ${#contact_ids[@]}"
}

# Function to import contacts from file
import_contacts() {
    echo
    echo "IMPORT CONTACTS"
    echo "==============="
    
    read -p "Enter CSV filename to import: " filename
    
    if [ ! -f "$filename" ]; then
        echo "File '$filename' not found."
        return
    fi
    
    local imported=0
    local line_num=0
    
    while IFS=',' read -r id name email phone company notes; do
        line_num=$((line_num + 1))
        
        # Skip header line
        if [ $line_num -eq 1 ]; then
            continue
        fi
        
        # Clean quotes from fields
        name=$(echo "$name" | sed 's/"//g')
        email=$(echo "$email" | sed 's/"//g')
        phone=$(echo "$phone" | sed 's/"//g')
        company=$(echo "$company" | sed 's/"//g')
        notes=$(echo "$notes" | sed 's/"//g')
        
        # Use next available ID
        local new_id=$next_id
        
        contacts_name[$new_id]="$name"
        contacts_email[$new_id]="$email"
        contacts_phone[$new_id]="$phone"
        contacts_company[$new_id]="$company"
        contacts_notes[$new_id]="$notes"
        
        contact_ids+=($new_id)
        next_id=$((next_id + 1))
        imported=$((imported + 1))
        
    done < "$filename"
    
    echo "Successfully imported $imported contacts from $filename"
}

# Function to show statistics
show_statistics() {
    echo
    echo "CONTACT STATISTICS"
    echo "=================="
    
    local total=${#contact_ids[@]}
    echo "Total contacts: $total"
    
    if [ $total -eq 0 ]; then
        return
    fi
    
    # Count contacts by company
    declare -A company_count
    local no_company=0
    
    for id in "${contact_ids[@]}"; do
        local company="${contacts_company[$id]}"
        if [ -z "$company" ] || [ "$company" = " " ]; then
            no_company=$((no_company + 1))
        else
            if [[ -v company_count["$company"] ]]; then
                company_count["$company"]=$((company_count["$company"] + 1))
            else
                company_count["$company"]=1
            fi
        fi
    done
    
    echo
    echo "Contacts by company:"
    for company in "${!company_count[@]}"; do
        echo "  $company: ${company_count[$company]}"
    done
    
    if [ $no_company -gt 0 ]; then
        echo "  (No company): $no_company"
    fi
    
    # Count emails vs phone numbers
    local has_email=0
    local has_phone=0
    
    for id in "${contact_ids[@]}"; do
        [ -n "${contacts_email[$id]}" ] && has_email=$((has_email + 1))
        [ -n "${contacts_phone[$id]}" ] && has_phone=$((has_phone + 1))
    done
    
    echo
    echo "Contact information completeness:"
    echo "  Contacts with email: $has_email ($((has_email * 100 / total))%)"
    echo "  Contacts with phone: $has_phone ($((has_phone * 100 / total))%)"
}

# Function to create sample data
create_sample_data() {
    echo "Creating sample contacts..."
    
    # Sample contact 1
    contacts_name[1]="Alice Johnson"
    contacts_email[1]="alice@techcorp.com"
    contacts_phone[1]="555-0101"
    contacts_company[1]="TechCorp"
    contacts_notes[1]="Project manager for web development"
    
    # Sample contact 2
    contacts_name[2]="Bob Smith"
    contacts_email[2]="bob@example.com"
    contacts_phone[2]="555-0102"
    contacts_company[2]="Example Inc"
    contacts_notes[2]="Marketing director"
    
    # Sample contact 3
    contacts_name[3]="Carol Davis"
    contacts_email[3]="carol@startup.io"
    contacts_phone[3]="555-0103"
    contacts_company[3]="StartupIO"
    contacts_notes[3]="Lead developer"
    
    contact_ids=(1 2 3)
    next_id=4
    
    echo "Sample data created!"
}

# Main program loop
main() {
    echo "Welcome to Contact Management System"
    echo "===================================="
    echo
    read -p "Would you like to load sample data? (y/N): " load_sample
    
    if [[ "$load_sample" =~ ^[Yy]$ ]]; then
        create_sample_data
    fi
    
    while true; do
        show_menu
        read -p "Choose an option (1-9): " choice
        
        case $choice in
            1) add_contact ;;
            2) view_all_contacts ;;
            3) search_contact ;;
            4) update_contact ;;
            5) delete_contact ;;
            6) export_contacts ;;
            7) import_contacts ;;
            8) show_statistics ;;
            9) 
                echo "Thank you for using Contact Management System!"
                break
                ;;
            *)
                echo "Invalid option. Please choose 1-9."
                ;;
        esac
        
        read -p "Press Enter to continue..."
    done
}

echo "Challenge: Contact Management System"
echo "==================================="
echo
echo "This is a complete contact management application demonstrating:"
echo "   - Associative arrays for data storage"
echo "   - Array manipulation and processing"
echo "   - Interactive menu system"
echo "   - CRUD operations (Create, Read, Update, Delete)"
echo "   - Data import/export functionality"
echo "   - Search and filtering"
echo "   - Statistical analysis"
echo
echo "You can explore the code to understand how arrays are used"
echo "to build a real-world application."
echo

read -p "Would you like to run the interactive demo? (y/N): " run_demo

if [[ "$run_demo" =~ ^[Yy]$ ]]; then
    main
else
    echo
    echo "Challenge Complete!"
    echo
    echo "What you accomplished:"
    echo "   - Built a complete contact management system"
    echo "   - Used associative arrays for structured data"
    echo "   - Implemented CRUD operations"
    echo "   - Created interactive user interface"
    echo "   - Added search and filtering capabilities"
    echo "   - Built data import/export features"
    echo "   - Implemented statistical analysis"
    echo
    echo "Skills demonstrated:"
    echo "   - Complex data structure management"
    echo "   - Interactive application development"
    echo "   - File I/O operations"
    echo "   - User input validation"
    echo "   - Menu-driven program design"
    echo "   - Data processing and analysis"
fi
