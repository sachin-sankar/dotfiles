#!/bin/bash

if curl -s -f https://checkip.amazonaws.com -o /dev/null; then
  # Online State
  IP=$(curl -s -f --connect-timeout 3 https://checkip.amazonaws.com)
  
  ICON=""
  STATE="connected"
  TEXT=""
  CLASS="connected"
  printf '{"text": "%s", "alt": "%s", "tooltip": "󰩟 %s", "class": "%s"}\n' "$ICON" "$STATE" "$IP" "$CLASS"
else
  # Offline State
  echo '{"text": "", "class": "disconnected"}'
fi
