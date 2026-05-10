#!/bin/bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

DIR="$1"

TOTAL_FILES=$(find "$DIR" -type f | wc -l)
TOTAL_DIRS=$(find "$DIR" -type d | wc -l)

LARGEST_FILE=$(find "$DIR" -type f -exec ls -lh {} + | sort -k5 -hr | head -1)
LATEST_FILE=$(find "$DIR" -type f -printf "%T@ %p\n" | sort -nr | head -1 | cut -d' ' -f2-)

echo "Total files: $TOTAL_FILES"
echo "Total directories: $TOTAL_DIRS"
echo "Largest file:"
echo "$LARGEST_FILE"
echo "Most recently modified file:"
echo "$LATEST_FILE"