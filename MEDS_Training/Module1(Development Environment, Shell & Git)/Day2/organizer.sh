#!/bin/bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
  echo "Error: Directory does not exist"
  exit 1
fi

cd "$DIR"

mkdir -p verilog c_code docs others

for file in *; do
  [ -f "$file" ] || continue

  case "$file" in
    *.sv) mv "$file" verilog/ ;;
    *.c) mv "$file" c_code/ ;;
    *.txt) mv "$file" docs/ ;;
    *) mv "$file" others/ ;;
  esac
done

echo "Files organized successfully."