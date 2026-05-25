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

PASS=$(grep -c "TEST PASS" "$LOGFILE" || true)
FAIL=$(grep -c "TEST FAIL" "$LOGFILE" || true)
SKIP=$(grep -c "TEST SKIP" "$LOGFILE" || true)

TOTAL=$((PASS + FAIL + SKIP))

if [[ "$TOTAL" -eq 0 ]]; then
PASS_RATE="0.00"
else
PASS_RATE=$(awk "BEGIN { printf \"%.2f\", ($PASS/$TOTAL)*100 }")
fi

OUTPUT_FILE="output/report.html"

cat > "$OUTPUT_FILE" <<EOF
<html>

<head>
<title>RISC-V Simulation Report</title>

<style>

body {
font-family: Arial;
margin: 40px;
}

table {
border-collapse: collapse;
width: 60%;
}

th, td {
border: 1px solid black;
padding: 10px;
text-align: left;
}

th {
background-color: #f2f2f2;
}

.pass {
color: green;
font-weight: bold;
}

.fail {
color: red;
font-weight: bold;
}

</style>
</head>

<body>

<h1>RISC-V Simulation Report</h1>

<table>

<tr>
<th>Metric</th>
<th>Value</th>
</tr>

<tr>
<td>Total Tests</td>
<td>$TOTAL</td>
</tr>

<tr>
<td>Passed</td>
<td class="pass">$PASS</td>
</tr>

<tr>
<td>Failed</td>
<td class="fail">$FAIL</td>
</tr>

<tr>
<td>Skipped</td>
<td>$SKIP</td>
</tr>

<tr>
<td>Pass Rate</td>
<td>$PASS_RATE%</td>
</tr>

</table>

</body>
</html>
EOF

echo "HTML report generated:"
echo "$OUTPUT_FILE"