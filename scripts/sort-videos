#!/bin/bash

SOURCE_DIR="${1:-.}"
MOVE_FILES="${2:-false}"

cd "$SOURCE_DIR" || exit 1

for video in *.{mp4,mkv,avi,mov,flv,wmv,webm,m4v}; do
  # Skip if no matches
  [ -e "$video" ] || continue

  # Get resolution using ffprobe
  resolution=$(ffprobe -v error -select_streams v:0 \
    -show_entries stream=width,height \
    -of csv=s=x:p=0 "$video" 2>/dev/null)

  if [ -n "$resolution" ]; then
    # Create resolution folder
    mkdir -p "$resolution"

    # Move or copy
    if [ "$MOVE_FILES" = "true" ]; then
      echo "Moving $video -> $resolution/"
      mv "$video" "$resolution/"
    else
      echo "Copying $video -> $resolution/"
      cp "$video" "$resolution/"
    fi
  else
    echo "Skipped: $video (couldn't detect resolution)"
  fi
done
