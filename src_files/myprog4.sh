#!/bin/bash

# 150122043 - 150122004

# 1. Argument Check
if [ -z "$1" ]; then
    echo "Error: Please specify a directory."
    echo "Usage: $0 <directory>"
    exit 1
fi

TARGET_DIR=$1

# 2. Directory Check
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
fi

# 3. Create Target Directories
LARGE_FILES_DIR="$TARGET_DIR/large_files"
SMALL_FILES_DIR="$TARGET_DIR/small_files"
# 'mkdir': Create directories. -p avoids errors if they exist.
mkdir -p "$LARGE_FILES_DIR" "$SMALL_FILES_DIR"

# [cite_start]4. Count and Move Large Files (> 1MB) [cite: 22]
# 'find': Search for files. -maxdepth 1 avoids subdirs.
# -size +1M: Finds files larger than 1MB.
# 'wc -l': Count the number of files found.
LARGE_COUNT=$(find "$TARGET_DIR" -maxdepth 1 -type f -size +1M | wc -l)
if [ $LARGE_COUNT -gt 0 ]; then
    # 'exec': Execute 'mv' (move) for files found.
    find "$TARGET_DIR" -maxdepth 1 -type f -size +1M -exec mv -t "$LARGE_FILES_DIR" {} +
fi

# [cite_start]5. Count and Move Small/Equal Files (<= 1MB) [cite: 22]
# '! -size +1M': Finds files NOT larger than 1MB.
SMALL_COUNT=$(find "$TARGET_DIR" -maxdepth 1 -type f \! -size +1M -not -path "$SMALL_FILES_DIR/*" -not -path "$LARGE_FILES_DIR/*" | wc -l)
if [ $SMALL_COUNT -gt 0 ]; then
    find "$TARGET_DIR" -maxdepth 1 -type f \! -size +1M -not -path "$SMALL_FILES_DIR/*" -not -path "$LARGE_FILES_DIR/*" -exec mv -t "$SMALL_FILES_DIR" {} +
fi

# [cite_start]6. Report to User [cite: 23]
echo "$LARGE_COUNT files moved to large_files"
echo "$SMALL_COUNT files moved to small_files"

