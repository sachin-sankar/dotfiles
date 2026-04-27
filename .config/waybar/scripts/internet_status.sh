#!/bin/bash

TARGET="http://1.1.1.1"

if curl -s -f ipinfo.io | jq -e .ip > /dev/null; then
  # Online State
  RESPONSE=$(curl -s -f --connect-timeout 3 ipinfo.io)
  IP=$(echo "$RESPONSE" | jq -r .ip)
  ICON=""
  STATE="connected"
  TEXT=""
  CLASS="connected"
  printf '{"text": "%s", "alt": "%s", "tooltip": "󰩟 %s", "class": "%s"}\n' "$ICON" "$STATE" "$IP" "$CLASS"
else
  # Offline State
  echo '{"text": "", "class": "disconnected"}'
fi
