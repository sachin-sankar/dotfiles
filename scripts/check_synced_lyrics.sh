#!/bin/bash

synced_count=0
unsynced_count=0
no_lyrics_count=0
instrumental_count=0
total_count=0

while IFS= read -r file; do
  ((total_count++))

  lyrics=$(exiftool -s3 -Lyrics "$file" 2>/dev/null)

  if [ -n "$lyrics" ]; then
    if echo "$lyrics" | grep -qiE '\[(ar|au):\s*instrumental\]|^instrumental$|\[instrumental\]'; then
      echo "♪ $file - Instrumental"
      ((instrumental_count++))
    elif echo "$lyrics" | grep -qE '\[[0-9]{2,}:[0-9]{2}\.[0-9]{2,}\]'; then
      echo "✓ $file - HAS synced lyrics"
      ((synced_count++))
    else
      echo "✗ $file - Has lyrics but NOT synced"
      ((unsynced_count++))
    fi
  else
    echo "  $file - No lyrics found"
    ((no_lyrics_count++))
  fi
done < <(find . -type f -iname "*.flac")

echo ""
echo "================================"
echo "         SUMMARY"
echo "================================"
echo "Total files scanned:     $total_count"
echo "Synced lyrics:           $synced_count"
echo "Unsynced lyrics:         $unsynced_count"
echo "Instrumental:            $instrumental_count"
echo "No lyrics:               $no_lyrics_count"
echo "================================"
