#!/bin/bash

PROJECTS_DIR="$HOME/Projects"

# Check if the directory exists
if [[ ! -d "$PROJECTS_DIR" ]]; then
  echo "Error: $PROJECTS_DIR does not exist."
  exit 1
fi

# Loop through every item in the Projects folder
for dir in "$PROJECTS_DIR"/*/; do
  # Remove trailing slash for cleaner printing
  dir=${dir%*/}
  project_name=$(basename "$dir")

  echo -e "\n\033[1;34m--- Checking: $project_name ---\033[0m"

  if [ -d "$dir/.git" ]; then
    # It is a git repo
    cd "$dir" || continue

    # 1. Run git status (short version for readability)
    echo "[Status]:"
    git status -s

    # Check if status was empty (meaning it's clean)
    if [ $? -eq 0 ] && [ -z "$(git status --porcelain)" ]; then
      echo "Working directory clean."
    fi

    # 2. Check for remote origin
    remote=$(git remote get-url origin 2>/dev/null)
    if [ -n "$remote" ]; then
      echo -e "[Remote]: $remote"
    else
      echo -e "[Remote]: \033[0;33mNo remote origin found.\033[0m"
    fi
  else
    # Not a git repo
    echo -e "\033[0;31mNo git repo initialized.\033[0m"
  fi
done

echo -e "\n\033[1;32mDone.\033[0m"
