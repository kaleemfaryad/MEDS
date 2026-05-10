#!/bin/bash
set -euo pipefail

if [ $# -lt 3 ]; then
  echo "Usage: $0 <prefix> <suffix> <directory>"
  exit 1
fi

PREFIX="$1"
SUFFIX="$2"
DIR="$3"

if [ ! -d "$DIR" ]; then
  echo "Error: Directory not found"
  exit 1
fi

cd "$DIR"

for file in ${PREFIX}_old_*.sv; do
  [ -f "$file" ] || continue

  num=$(echo "$file" | sed -E 's/.*_old_([0-9]+)\.sv/\1/')
  new_name="${SUFFIX}_new_${num}.sv"

  mv "$file" "$new_name"
  echo "Renamed: $file -> $new_name"
done

echo "Batch rename completed."