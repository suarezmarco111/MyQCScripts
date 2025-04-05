#!/bin/bash

# Firewall Rules Installation Script for Rocky Linux 9.x using firewalld

# Ensure the script is run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

echo "Applying firewall rules for Rocky Linux 9.x using firewalld..."

# Ensure firewalld is running
systemctl enable firewalld --now

# Set default zone (work)
DEFAULT_ZONE="work"

# Change default zone if needed
firewall-cmd --set-default-zone=$DEFAULT_ZONE

# Allow specific source networks in the default zone
firewall-cmd --permanent --zone=$DEFAULT_ZONE --add-source=128.164.0.0/16
firewall-cmd --permanent --zone=$DEFAULT_ZONE --add-source=161.253.0.0/16

# Allow required services and ports
firewall-cmd --permanent --zone=$DEFAULT_ZONE --add-service=ssh
firewall-cmd --permanent --zone=$DEFAULT_ZONE --add-service=ntp
firewall-cmd --permanent --zone=$DEFAULT_ZONE --add-port=546/udp   # DHCPv6 client

# Reload to apply changes
firewall-cmd --reload

# Show firewall status
echo "Firewall rules have been applied. Current settings:"
firewall-cmd --list-all --zone=$DEFAULT_ZONE

