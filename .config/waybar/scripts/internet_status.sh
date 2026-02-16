#!/bin/bash

TARGET="http://1.1.1.1"

if curl -s -f --connect-timeout 3 "$TARGET" -o /dev/null; then
  # Online State
  echo '{"text": "", "class": "connected" }'
else
  # Offline State
  echo '{"text": "", "class": "disconnected"}'
fi
