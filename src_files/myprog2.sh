#!/bin/bash

# 150122043 - 150122004
# Necessary error checking is included.

# 1. Argument Check
if [ -z "$1" ]; then
    echo "Error: Please specify a directory name."
    echo "Usage: $0 <directory_name>"
    exit 1 # 'exit': Stop the script with an error status.
fi

TARGET_DIR=$1

# 2. Directory Check
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1 # 'exit': Stop the script with an error status.
fi

# 3. Backup Directory Creation
# 'date': Get current date in YYYY-MM-DD format.
CURRENT_DATE=$(date +%Y-%m-%d)
BACKUP_DIR_NAME="backup_$CURRENT_DATE"
FULL_BACKUP_PATH="$TARGET_DIR/$BACKUP_DIR_NAME"

# 'mkdir': Create the backup directory. -p avoids errors if it exists.
mkdir -p "$FULL_BACKUP_PATH"

# 4. Finding and Copying Files
# 'find': Search for files in $TARGET_DIR.
# -maxdepth 1: Don't search subdirectories.
# -type f: Find only files.
# \( ... \): Group conditions.
# -o: OR operator.
# -exec: Execute a command.
# 'cp': Copy files. -t specifies the target directory.
# {} +: A placeholder for the found files, passed efficiently to cp.
find "$TARGET_DIR" -maxdepth 1 -type f \( -name "*.txt" -o -name "*.sh" \) -exec cp -t "$FULL_BACKUP_PATH" {} +

# 5. Reporting
# 'find': Run the same search again to count.
# 'wc': Word Count. -l counts the number of lines (files) found.
COPIED_FILES_COUNT=$(find "$TARGET_DIR" -maxdepth 1 -type f \( -name "*.txt" -o -name "*.sh" \) | wc -l)

echo "$COPIED_FILES_COUNT files copied into $BACKUP_DIR_NAME"
