#!/bin/bash

echo "========================================"
echo "       SERVER PERFORMANCE STATS"
echo "========================================"

# CPU Usage
echo ""
echo "==== CPU USAGE ===="
top -bn1 | grep "Cpu(s)" | awk '{print "Total CPU Usage: " 100 - $8 "%"}'


# Memory Usage
echo ""
echo "==== MEMORY USAGE ===="
free -m | awk 'NR==2 {
    printf "Memory Usage: %sMB/%sMB (%.2f%%)\n", $3, $2, $3*100/$2
}'


# Disk Usage
echo ""
echo "==== DISK USAGE ===="
df -h | awk '$NF=="/" {
    printf "Disk Usage: %s/%s (%s)\n", $3, $2, $5
}'


# Top 5 Processes by CPU Usage
echo ""
echo "==== TOP 5 PROCESSES BY CPU USAGE ===="
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6


# Top 5 Processes by Memory Usage
echo ""
echo "==== TOP 5 PROCESSES BY MEMORY USAGE ===="
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6


# Additional Stats
echo ""
echo "==== ADDITIONAL STATS ===="
echo "OS Version: $(uname -a)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average: ' '{print $2}')"
echo "Logged-in Users: $(who | wc -l)"

echo "Failed Login Attempts:"
if [ -f /var/log/auth.log ]; then
    grep -i "failed password" /var/log/auth.log | wc -l
else
    echo "auth.log not found"
fi

echo ""
echo "========================================"
echo "       SCRIPT EXECUTION COMPLETED"
echo "========================================"