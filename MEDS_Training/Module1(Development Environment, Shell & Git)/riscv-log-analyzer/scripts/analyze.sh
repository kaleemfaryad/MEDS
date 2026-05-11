#!/usr/bin/env bash

set -euo pipefail

# =========================
# ANSI Color Codes
# =========================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# =========================
# Default Variables
# =========================
FORMAT="text"
OUTPUT=""
VERBOSE=false
COMPARE_MODE=false
COMPARE_FILE=""
LOGFILE=""

# =========================
# Usage Function
# =========================
usage() {
cat <<EOF
Usage:
bash scripts/analyze.sh <logfile> [options]

Options:
  -f <text|csv>     Output format
  -o <file>         Save output to file
  -v                Enable verbose mode
  -h                Show help
  -c <compare_log>  Compare two logs for regressions

Examples:
bash scripts/analyze.sh test_data/sample_fail.log
bash scripts/analyze.sh test_data/sample_fail.log -f csv
bash scripts/analyze.sh test_data/sample_fail.log -o output/report.txt
bash scripts/analyze.sh test_data/sample_pass.log -c test_data/sample_fail.log
EOF
}

# =========================
# Verbose Logger
# =========================
log_verbose() {
if [[ "$VERBOSE" == true ]]; then
echo "[DEBUG] $1"
fi
}

# =========================
# Validate Input
# =========================
validate_input() {

if [[ ! -f "$LOGFILE" ]]; then
echo "Error: File not found: $LOGFILE"
exit 1
fi

if [[ "$COMPARE_MODE" == true && ! -f "$COMPARE_FILE" ]]; then
echo "Error: Compare file not found: $COMPARE_FILE"
exit 1
fi
}

# =========================
# Analyze Log File
# =========================
analyze_log() {

log_verbose "Analyzing log file"

PASS=$(grep -c "TEST PASS" "$LOGFILE" || true)
FAIL=$(grep -c "TEST FAIL" "$LOGFILE" || true)
SKIP=$(grep -c "TEST SKIP" "$LOGFILE" || true)

TOTAL=$((PASS + FAIL + SKIP))

if [[ "$TOTAL" -eq 0 ]]; then
PASS_RATE="0.00"
else
PASS_RATE=$(awk "BEGIN { printf \"%.2f\", ($PASS/$TOTAL)*100 }")
fi

# Extract failed test names
FAILED_TESTS=$(grep "TEST FAIL" "$LOGFILE" \
| awk -F': ' '{print $2}' \
| awk '{print $1}' || true)

# Extract execution times
TIMES=$(grep -E "TEST PASS|TEST FAIL" "$LOGFILE" \
| grep -oE '[0-9]+\.[0-9]+s' \
| tr -d 's' || true)

if [[ -n "$TIMES" ]]; then

MIN=$(echo "$TIMES" | sort -n | head -1)
MAX=$(echo "$TIMES" | sort -n | tail -1)

AVG=$(echo "$TIMES" \
| awk '{sum+=$1} END {printf "%.2f", sum/NR}')

else

MIN="0.00"
MAX="0.00"
AVG="0.00"

fi
}

# =========================
# Compare Logs
# =========================
compare_logs() {

echo
echo "=== Regression Analysis ==="

OLD_PASS=$(grep "TEST PASS" "$LOGFILE" \
| awk -F': ' '{print $2}' \
| awk '{print $1}' \
| sort)

NEW_FAIL=$(grep "TEST FAIL" "$COMPARE_FILE" \
| awk -F': ' '{print $2}' \
| awk '{print $1}' \
| sort)

REGRESSIONS=$(comm -12 <(echo "$OLD_PASS") <(echo "$NEW_FAIL") || true)

if [[ -z "$REGRESSIONS" ]]; then
echo "No regressions found"
else
echo "Tests that passed before but now fail:"
echo "$REGRESSIONS"
fi
}

# =========================
# Generate Text Report
# =========================
generate_text_report() {

if [[ "$FAIL" -gt 0 ]]; then
VERDICT="${RED}FAIL${NC}"
else
VERDICT="${GREEN}PASS${NC}"
fi

cat <<EOF
=== RISC-V Simulation Log Analysis ===

Log file: $LOGFILE
Analysis date: $(date)

--- Results Summary ---

Total tests: $TOTAL
Passed: $PASS
Failed: $FAIL
Skipped: $SKIP
Pass rate: $PASS_RATE%

--- Failed Tests ---

${FAILED_TESTS:-None}

--- Timing Statistics ---

Min time: ${MIN}s
Max time: ${MAX}s
Avg time: ${AVG}s

--- Verdict: $VERDICT ---

EOF
}

# =========================
# Generate CSV Report
# =========================
generate_csv_report() {

cat <<EOF
metric,value
total,$TOTAL
pass,$PASS
fail,$FAIL
skip,$SKIP
pass_rate,$PASS_RATE
min_time,$MIN
max_time,$MAX
avg_time,$AVG
EOF
}

# =========================
# Output Report
# =========================
output_report() {

if [[ "$FORMAT" == "csv" ]]; then
REPORT=$(generate_csv_report)
else
REPORT=$(generate_text_report)
fi

if [[ -n "$OUTPUT" ]]; then
echo "$REPORT" > "$OUTPUT"
echo "Saved output to: $OUTPUT"
else
echo "$REPORT"
fi
}

# =========================
# Main Function
# =========================
main() {

if [[ $# -lt 1 ]]; then
usage
exit 1
fi

LOGFILE="$1"
shift

while getopts ":f:o:vhc:" opt; do

case ${opt} in

f )
FORMAT=$OPTARG
;;

o )
OUTPUT=$OPTARG
;;

v )
VERBOSE=true
;;

h )
usage
exit 0
;;

c )
COMPARE_MODE=true
COMPARE_FILE=$OPTARG
;;

\? )
echo "Invalid option"
usage
exit 1
;;

esac

done

validate_input

analyze_log

output_report

if [[ "$COMPARE_MODE" == true ]]; then
compare_logs
fi

# Exit code based on failures
if [[ "$FAIL" -gt 0 ]]; then
exit 1
else
exit 0
fi
}

main "$@"