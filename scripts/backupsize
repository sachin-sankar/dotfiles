#!/bin/bash

LIST_FILE="$HOME/.backuplist"

if [[ ! -f "$LIST_FILE" ]]; then
  echo "Error: Configuration file '$LIST_FILE' not found."
  exit 1
fi

echo -e "Size\t\tPath"
echo -e "------------------------------------------"

total_bytes=0

while IFS= read -r item || [[ -n "$item" ]]; do
  # Skip empty lines or comments
  [[ -z "$item" || "$item" =~ ^# ]] && continue

  if [[ -e "$item" ]]; then
    # Get bytes - using 'stat' for files and 'du' for dirs is more reliable
    if [[ -d "$item" ]]; then
      # -s: summary only, -b: bytes
      bytes=$(du -sb "$item" 2>/dev/null | cut -f1)
    else
      # -c %s: just the size in bytes
      bytes=$(stat -c %s "$item" 2>/dev/null)
    fi

    # Skip if we couldn't read the size
    [[ -z "$bytes" ]] && bytes=0

    # Convert the individual item to human-readable (Decimal)
    human_size=$(numfmt --to=si --suffix=B "$bytes")

    echo -e "$human_size\t\t$item"

    # Add to total
    total_bytes=$((total_bytes + bytes))
  else
    echo -e "N/A\t\t$item (Not Found)"
  fi
done <"$LIST_FILE"

# Convert total to Decimal (MB/GB)
total_human=$(numfmt --to=si --suffix=B "$total_bytes")

echo -e "------------------------------------------"
echo -e "$total_human\t\tTOTAL COMBINED"
