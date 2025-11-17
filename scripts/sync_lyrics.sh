#!/bin/bash

# Initialize counters
total_scanned=0
already_has_lyrics=0
instrumental_count=0
no_lrc_found=0
embedded_count=0
failed_count=0

while IFS= read -r flac_file; do
  ((total_scanned++))

  # Extract existing lyrics using metaflac
  lyrics=$(metaflac --show-tag=LYRICS "$flac_file" | sed 's/^LYRICS=//')

  # Check if already has lyrics
  if [ -n "$lyrics" ]; then
    # Check if instrumental
    if echo "$lyrics" | grep -qiE '\[(ar|au):\s*instrumental\]|^instrumental$|\[instrumental\]'; then
      echo "♪ SKIP: $flac_file - Instrumental"
      ((instrumental_count++))
    else
      echo "✓ SKIP: $flac_file - Already has lyrics"
      ((already_has_lyrics++))
    fi
    continue
  fi

  # Look for matching .lrc file
  base_name="${flac_file%.flac}"
  lrc_file="${base_name}.lrc"

  if [ ! -f "$lrc_file" ]; then
    echo "✗ SKIP: $flac_file - No matching .lrc file"
    ((no_lrc_found++))
    continue
  fi

  # Embed the .lrc file content into FLAC using metaflac
  if metaflac --preserve-modtime --remove-tag=LYRICS --set-tag-from-file="LYRICS=$lrc_file" "$flac_file" 2>/dev/null; then
    echo "✓ EMBEDDED: $flac_file <- $lrc_file"
    ((embedded_count++))
  else
    echo "✗ FAILED: $flac_file - Could not embed lyrics"
    ((failed_count++))
  fi

done < <(find . -type f -iname "*.flac")

# Print summary
echo ""
echo "========================================"
echo "            SUMMARY"
echo "========================================"
echo "Total FLAC files scanned:    $total_scanned"
echo "Successfully embedded:       $embedded_count"
echo "Already had lyrics:          $already_has_lyrics"
echo "Instrumental tracks:         $instrumental_count"
echo "No matching .lrc found:      $no_lrc_found"
echo "Failed to embed:             $failed_count"
echo "========================================"
