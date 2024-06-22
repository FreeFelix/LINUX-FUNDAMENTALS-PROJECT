#!/bin/bash

# Program that retrieves all information about PC status

# Defining system version information module
function get_system_version() {
   echo "System version: $(uname -srm)"
    lsb_release -a | grep "Release"
}
S
# Defining network details information module
function get_network_details() {
    echo "System Network Details:"
    echo "***************"
    echo
    # Private IP Address
    PRIVATE_IP=$(ip addr | grep 'dynamic' | awk '{print $2}')
    echo "Private IP Address is $PRIVATE_IP"
    echo

    # Public IP Address
    PUBLIC_IP=$(curl -s ifconfig.co | awk '{print $1}')
    echo "Public IP Address is $PUBLIC_IP"
    echo

    # Default Gateway
    GATEWAY=$(ip route | awk '{print $3}' | head -n 1)
    echo "Default Gateway is $GATEWAY"
    echo

    #Mac address
    MAC_ADDRESS=$(ip addr | grep ether | awk '{print $2}')
    echo "MAC Address is $MAC_ADDRESS"
    echo
}


# Defining disk statistics information module
function get_disk_statistics() {
    echo "Disk Usage Statistics:"
    echo "****************"
    echo
    # Disk Usage
    DISK_USAGE=$(df -h | grep '/dev/sda1' | awk '{print $3}')
    echo "Disk Usage is $DISK_USAGE"
    echo

    # Disk Space
    DISK_SPACE=$(df -h | grep '/dev/sda1' | awk '{print $2}')
    echo "Disk Space is $DISK_SPACE"
    echo

    # Disk available
    DISK_AVAILABLE=$(df -h | grep '/dev/sda1' | awk '{print $4}')
    echo "Disk storage available is $DISK_AVAILABLE"
    echo

    # Disk usage percentage
    DISK_USAGE_PERCENTAGE=$(df -h | grep '/dev/sda1' | awk '{print $5}')
    echo "Disk Usage Percentage is $DISK_USAGE_PERCENTAGE"
    echo
}

function get_Mem_statistics() {
    echo "Memory Usage Statistics:"
    echo "************************"
    echo
    # Memory Usage
    MEMORY_USAGE=$(free -h | grep Mem | awk '{print $3}')
    echo "Disk Usage is $MEMORY_USAGE"
    echo

    # Memory Space
    MEMORY_SPACE=$(free -h | grep Mem | awk '{print $2}')
    echo "Disk Space is $MEMORY_SPACE"
    echo

    # Memory available
    MEMORY_AVAILABLE=$(free -h | grep Mem | awk '{print $7}')
    echo "Disk storage available is $MEMORY_AVAILABLE"
    echo
}

# Defining largest directory information module
function get_largest_directory() {
    echo "Largest Directory:"
    echo "*****************"
    echo
    # Largest Directory
    LARGEST_DIR=$(find /home -type f -exec du -h {} + | sort -rh | head -n 10 | awk '{print $1"  " $(NF-1)}')
    echo "Largest Directory is $LARGEST_DIR"
    echo
}

# Function to display CPU usage for top 5 processes
function get_top_cpu_processes() {
    echo "Top 5 process currently running in the system."
    echo "**********************************************"
    echo
    top -b -n 1 | grep -A 5 '%CPU'
    echo
}
# Defining CPU usage information module
function get_cpu_usage() {
    echo "CPU Usage:"
    echo "**********"
    echo
    # CPU Usage
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | awk '{print 100 - $1"%"}')
    echo "CPU Usage is $CPU_USAGE"
    echo
}

# Function to list active system services with their status
function get_active_services() {
    echo "Active System Services:"
    echo "***********************"
    echo
    systemctl list-units --type=service --state=running
}

# Display menu function
function display_menu() {
    clear
    get_system_version
    get_network_details
    get_disk_statistics
    get_largest_directory
    get_Mem_statistics
    get_top_cpu_processes
    get_cpu_usage
    get_active_services
}
S
# Main loop
while true; do
    display_menu
    sleep 10
done
