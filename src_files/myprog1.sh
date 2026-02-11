#!/bin/bash

# 150122043 - 150122004
# Necessary error checking is included.

# 1. Argument Check: Did the user provide a filename?
if [ -z "$1" ]; then
    echo "Error: Please specify a filename."
    echo "Usage: $0 <filename>"
    exit 1 # 'exit': Stop the script with an error status.
fi

FILENAME=$1

# 2. File Check: Does the given file exist and is it readable?
if [ ! -f "$FILENAME" ]; then
    echo "Error: File '$FILENAME' not found."
    exit 1 # 'exit': Stop the script with an error status.
fi

# 3. Word Counting Process
cat "$FILENAME" | \
    tr '[:upper:]' '[:lower:]' | \ # 'tr': Translate uppercase to lowercase.
    tr -d '[:punct:]' | \          # 'tr': Delete (-d) punctuation marks.
    grep -oE '\w+' | \             # 'grep': Find and print only (o) matching words (E).
    sort | \                       # 'sort': Sort words alphabetically (for uniq).
    uniq -c | \                    # 'uniq': Count (-c) adjacent duplicate lines.
    sort -nr | \                   # 'sort': Sort numerically (-n) and in reverse (-r).
    head -n 3 | \                  # 'head': Get the first (-n) 3 lines (the top 3).
    awk '{print NR ". " $2 " - " $1}' # 'awk': Format output (NR=line num, $2=word, $1=count).
