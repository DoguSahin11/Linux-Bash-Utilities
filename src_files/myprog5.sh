#!/bin/bash

# 150122043 - 150122004

# 1. Argument Check (Must be exactly 2 arguments)
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory> <prefix>"
    exit 1
fi

TARGET_DIR=$1
PREFIX=$2

# 2. Directory Check
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
fi

# [cite_start]3. Recursion Check [cite: 30]
FIND_DEPTH="-maxdepth 1" # Default: do not search subdirs.
# 'find': Check if any subdirectories (-type d) exist.
if [ -n "$(find "$TARGET_DIR" -mindepth 1 -type d)" ]; then
    # 'read': Get user input. -p shows a prompt.
    read -p "Subdirectories found. Rename recursively? (y/n) " RECURSIVE_CHOICE
    if [[ "$RECURSIVE_CHOICE" == "y" || "$RECURSIVE_CHOICE" == "Y" ]]; then
        FIND_DEPTH="" # User said yes, so remove depth limit.
    fi
fi

# 4. Renaming Process
RENAMED_COUNT=0
RENAMED_FILES_LIST=() # Array to store new filenames for report.

# 'find': Find files. $FIND_DEPTH is either "" or "-maxdepth 1".
# [cite_start]-name "*.txt": Find only .txt files. [cite: 29]
# 'while read': Read each line (file path) from find's output safely.
while IFS= read -r FILE; do
    DIRNAME=$(dirname "$FILE")   # 'dirname': Get the directory part of the path.
    BASENAME=$(basename "$FILE") # 'basename': Get the filename part of the path.
    
    NEW_FILE_PATH="$DIRNAME/$PREFIX$BASENAME"
    
    # 'mv': Move (rename) the old file to the new path.
    mv "$FILE" "$NEW_FILE_PATH"
    
    RENAMED_COUNT=$((RENAMED_COUNT + 1))
    RENAMED_FILES_LIST+=("$PREFIX$BASENAME") # Add to report list.

done < <(eval find "$TARGET_DIR" $FIND_DEPTH -type f -name "*.txt")

# [cite_start]5. Report to User [cite: 35]
RENAMED_FILES_STRING=$(printf ", %s" "${RENAMED_FILES_LIST[@]}")
RENAMED_FILES_STRING=${RENAMED_FILES_STRING:2} # Remove leading ", "

echo "$RENAMED_COUNT files renamed: $RENAMED_FILES_STRING"
