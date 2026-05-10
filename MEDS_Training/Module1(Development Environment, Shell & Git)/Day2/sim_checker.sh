#!/bin/bash
set -euo pipefail

# Check arguments
if [ $# -lt 1 ]; then
  echo "Usage: $0 <logfile>"
  exit 1
fi

LOG="$1"

# Check if file exists
if [ ! -f "$LOG" ]; then
  echo "Error: Log file '$LOG' not found"
  exit 1
fi

# Count occurrences safely
ERRORS=$(grep -c "ERROR" "$LOG" 2>/dev/null || echo 0)
WARNINGS=$(grep -c "WARNING" "$LOG" 2>/dev/null || echo 0)
PASSES=$(grep -c "PASS" "$LOG" 2>/dev/null || echo 0)

# Print summary
echo "=============================="
echo "   Simulation Summary"
echo "=============================="
echo "ERRORS   : $ERRORS"
echo "WARNINGS : $WARNINGS"
echo "PASSED   : $PASSES"
echo "=============================="

# Exit status
if [ "$ERRORS" -gt 0 ]; then
  echo "Simulation FAILED"
  exit 1
else
  echo "Simulation SUCCESS"
  exit 0
fi