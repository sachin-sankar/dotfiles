#!/bin/bash

# Simple HTTP Connection Monitor
HTTP_TIMEOUT=9
CHECK_INTERVAL=10
TEST_URL="https://1.1.1.1"

check_http_connection() {
  if command -v curl >/dev/null 2>&1; then
    # Use curl with specific HTTP options
    if curl -Is \
      --connect-timeout "$HTTP_TIMEOUT" \
      --max-time "$HTTP_TIMEOUT" \
      --retry 0 \
      --fail \
      --user-agent "NetworkMonitor/1.0" \
      "$TEST_URL" >/dev/null 2>&1; then
      return 0
    fi
  elif command -v wget >/dev/null 2>&1; then
    # Fallback to wget
    if wget \
      --timeout="$HTTP_TIMEOUT" \
      --connect-timeout="$HTTP_TIMEOUT" \
      --read-timeout="$HTTP_TIMEOUT" \
      --tries=1 \
      --spider \
      --quiet \
      --user-agent="NetworkMonitor/1.0" \
      "$TEST_URL" >/dev/null 2>&1; then
      return 0
    fi
  fi
  return 1
}

CONNECTION_STATE=""
while true; do
  if check_http_connection; then
    NEW_STATE="up"
  else
    NEW_STATE="down"
  fi

  if [ "$NEW_STATE" != "$CONNECTION_STATE" ]; then
    CONNECTION_STATE=$NEW_STATE
    if [ "$CONNECTION_STATE" = "down" ]; then
      notify-send -u critical --icon="/usr/share/icons/breeze-dark/status/24/network-wireless-off.svg" -e "Network Down" "HTTP connection lost"
      echo "$(date): Network connection LOST"
    else
      notify-send -u normal "Network Up" "HTTP connection restored" -t 2000
      echo "$(date): Network connection RESTORED"
    fi
  fi

  sleep $CHECK_INTERVAL
done
