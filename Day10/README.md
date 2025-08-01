# Day 10: Process Management and Job Control

## 🎯 **Learning Goal**
Master process control for building powerful automation tools.

## 📚 **What You'll Learn Today**
- Background processes and job control
- Process monitoring and management
- Signal handling and communication
- Building concurrent scripts

## 🛠️ **Today's Concepts to Master**
```bash
&, jobs, fg, bg, kill, killall, pgrep, pkill, wait
```

## 📖 **Learning Path** (4-5 hours)

### **Step 1**: Background Jobs (90 min)
```bash
./exercises/background_jobs.sh
```

### **Step 2**: Process Monitoring (90 min)
```bash
./exercises/process_monitoring.sh
```

### **Step 3**: Signal Handling (90 min)
```bash
./exercises/signal_handling.sh
```

### **Step 4**: Build a Process Manager (150 min)
```bash
./scripts/process_manager.sh
```

## ✅ **Daily Challenge**
Create a service monitor:
```bash
#!/bin/bash

services=("ssh" "apache2" "mysql")
log_file="/tmp/service_monitor.log"

monitor_service() {
    local service="$1"
    while true; do
        if systemctl is-active "$service" >/dev/null 2>&1; then
            echo "$(date): $service is running" >> "$log_file"
        else
            echo "$(date): WARNING - $service is down!" >> "$log_file"
            # Could restart service here
        fi
        sleep 30
    done
}

# Start monitoring all services in background
for service in "${services[@]}"; do
    monitor_service "$service" &
    echo "Started monitoring $service (PID: $!)"
done

echo "Monitoring ${#services[@]} services. Check $log_file for status."
echo "Press Ctrl+C to stop all monitors."

# Wait for user interrupt
trap 'echo "Stopping all monitors..."; killall -P $$; exit' INT
wait
```

## 🎓 **Success Criteria**
- [ ] Can manage background processes
- [ ] Understand job control
- [ ] Can handle signals properly
- [ ] Built a concurrent monitoring tool

## 🚀 **Next Phase Preview**
Days 11-20: Advanced scripting and real-world projects!
