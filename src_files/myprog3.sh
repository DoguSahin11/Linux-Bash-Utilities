#!/bin-bash

# 150122043 - 150122004

# 1. Argument Check (Must be exactly 3 arguments)
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <filename> <target_word> <replacement_word>"
    exit 1 # 'exit': Stop the script with an error status.
fi

FILENAME=$1
TARGET_WORD=$2
REPLACEMENT_WORD=$3

# 2. File Check
if [ ! -f "$FILENAME" ]; then
    echo "Error: File '$FILENAME' not found."
    exit 1
fi

# 3. Count Replacements
# 'grep': Find only (o) the target word.
# 'wc': Count (-l) the number of lines (matches).
REPLACEMENT_COUNT=$(grep -o "$TARGET_WORD" "$FILENAME" | wc -l)

# 4. Replace and Write to New File
MODIFIED_FILENAME="modified_$FILENAME"
# 'sed': Stream editor.
# 's/.../.../g': Substitute (s) all (g) occurrences.
# [cite_start]'>': Redirect output to a new file (overwrites). [cite: 17]
sed "s/$TARGET_WORD/$REPLACEMENT_WORD/g" "$FILENAME" > "$MODIFIED_FILENAME"

# 5. Log to changes.log
# [cite_start]'>>': Append output to the log file. [cite: 18]
echo "$(date): $REPLACEMENT_COUNT replacements made in $FILENAME." >> changes.log

# [cite_start]6. Report to User [cite: 20]
echo "All $REPLACEMENT_COUNT occurrences of '$TARGET_WORD' replaced with '$REPLACEMENT_WORD'"
echo "Modified file: $MODIFIED_FILENAME"
echo "Logged to: changes.log"
