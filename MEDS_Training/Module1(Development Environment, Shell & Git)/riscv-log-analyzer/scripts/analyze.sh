#!/usr/bin/env bash

set -euo pipefail

FORMAT="text"
OUTPUT=""
VERBOSE=false
LOGFILE=""

usage() {
    cat <<EOF
Usage: $0 <logfile> [OPTIONS]

OPTIONS:
  --format [text|csv]
  --output <file>
  --verbose
  --help
EOF
}

log_verbose() {
    if [[ "$VERBOSE" == true ]]; then
        echo "[DEBUG] $1"
    fi
}

parse_arguments() {

    if [[ $# -lt 1 ]]; then
        echo "Error: Missing logfile"
        usage
        exit 1
    fi

    LOGFILE="$1"
    shift

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --format)
                FORMAT="$2"
                shift 2
                ;;
            --output)
                OUTPUT="$2"
                shift 2
                ;;
            --verbose)
                VERBOSE=true
                shift
                ;;
            --help)
                usage
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                exit 1
                ;;
        esac
    done
}

validate_input() {

    if [[ ! -f "$LOGFILE" ]]; then
        echo "Error: File not found: $LOGFILE"
        exit 1
    fi
}

analyze_log() {

    PASS=$(grep -c "TEST PASS" "$LOGFILE" || true)
    FAIL=$(grep -c "TEST FAIL" "$LOGFILE" || true)
    SKIP=$(grep -c "TEST SKIP" "$LOGFILE" || true)

    TOTAL=$((PASS + FAIL + SKIP))

    if [[ "$TOTAL" -eq 0 ]]; then
        PASS_RATE="0.00"
    else
        PASS_RATE=$(awk "BEGIN { printf \"%.2f\", ($PASS/$TOTAL)*100 }")
    fi

    FAILED_TESTS=$(grep "TEST FAIL" "$LOGFILE" | awk -F': ' '{print $2}' | awk '{print $1}' || true)

    TIMES=$(grep -E "TEST PASS|TEST FAIL" "$LOGFILE" | grep -oE '[0-9]+\.[0-9]+s' | tr -d 's' || true)

    if [[ -n "$TIMES" ]]; then
        MIN=$(echo "$TIMES" | sort -n | head -1)
        MAX=$(echo "$TIMES" | sort -n | tail -1)
        AVG=$(echo "$TIMES" | awk '{sum+=$1} END {printf "%.2f", sum/NR}')
    else
        MIN="0.00"
        MAX="0.00"
        AVG="0.00"
    fi
}

generate_text_report() {

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

--- Verdict: $( [[ "$FAIL" -gt 0 ]] && echo "FAIL" || echo "PASS" ) ---
EOF
}

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

output_report() {

    if [[ "$FORMAT" == "csv" ]]; then
        REPORT=$(generate_csv_report)
    else
        REPORT=$(generate_text_report)
    fi

    if [[ -n "$OUTPUT" ]]; then
        echo "$REPORT" > "$OUTPUT"
    else
        echo "$REPORT"
    fi
}

main() {

    parse_arguments "$@"
    validate_input
    analyze_log
    output_report

    if [[ "$FAIL" -gt 0 ]]; then
        exit 1
    else
        exit 0
    fi
}

main "$@"