#!/usr/bin/env bash

# Get the raw status
STATUS_RAW=$(warp-cli status)

# Extract the status (e.g., Connected, Disconnected, Connecting)
STATE=$(echo "$STATUS_RAW" | grep "Status update" | awk '{print $3}')

# Extract network health
HEALTH=$(echo "$STATUS_RAW" | grep "Network" | awk '{print $2}')

# Set Icon and Class based on state
if [[ "$STATE" == "Connected" ]]; then
  ICON="󰅟" # Or use "VPN"
  CLASS="connected"
  TEXT="WARP: $HEALTH"
  STATE="CONN"
elif [[ "$STATE" == "Connecting" ]]; then
  ICON="󰔪"
  CLASS="connecting"
  TEXT="Connecting..."
  STATE="CONP"
else
  ICON="󰧠"
  CLASS="disconnected"
  TEXT="Disconnected"
  STATE="NCON"
fi

# Output JSON for Waybar
printf '{"text": "%s %s", "alt": "%s", "tooltip": "%s", "class": "%s"}\n' "$ICON" "$STATE" "$STATE" "$TEXT" "$CLASS"
