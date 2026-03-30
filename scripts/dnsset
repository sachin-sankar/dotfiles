#!/bin/bash

# Get the current active network connection
CURRENT_CONN=$(nmcli -t -f NAME connection show --active | head -n 1)

# Check if a connection was found
if [ -z "$CURRENT_CONN" ]; then
  echo "No active network connection found"
  exit 1
fi

echo "Setting DNS for connection: $CURRENT_CONN"

# Set IPv4 DNS servers
nmcli connection modify "$CURRENT_CONN" ipv4.dns "94.140.15.15 94.140.14.14"

# Ignore auto DNS from DHCP for IPv4
nmcli connection modify "$CURRENT_CONN" ipv4.ignore-auto-dns yes

# Set IPv6 DNS servers
nmcli connection modify "$CURRENT_CONN" ipv6.dns "2a10:50c0::ad1:ff 2a10:50c0::ad2:ff"

# Ignore auto DNS from DHCP for IPv6
nmcli connection modify "$CURRENT_CONN" ipv6.ignore-auto-dns yes

# Restart the connection to apply changes
nmcli connection down "$CURRENT_CONN"
nmcli connection up "$CURRENT_CONN"

# Verify the changes
echo "DNS settings applied. Current DNS configuration:"
nmcli connection show "$CURRENT_CONN" | grep dns
