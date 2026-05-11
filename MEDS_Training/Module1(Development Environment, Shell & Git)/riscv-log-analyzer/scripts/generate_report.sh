#!/usr/bin/env bash

set -euo pipefail

LOGFILE="${1:-}"

if [[ -z "$LOGFILE" ]]; then
echo "Usage: $0 <logfile>"
exit 1
fi

if [[ ! -f "$LOGFILE" ]]; then
echo "Error: File not found: $LOGFILE"
exit 1
fi

mkdir -p output

OUTPUT_FILE="output/report.txt"

bash scripts/analyze.sh "$LOGFILE" --output "$OUTPUT_FILE" || true

echo "Report generated:"
echo "$OUTPUT_FILE"
