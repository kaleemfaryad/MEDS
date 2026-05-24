# RISC-V Log Analyzer

## Project Overview

A shell-based log analysis tool that processes RISC-V simulation logs and generates structured reports.

It extracts:

- Total tests
- Pass / Fail / Skip counts
- Pass rate
- Execution time statistics
- Failed test names

## Project Structure

riscv-log-analyzer/
├── README.md
├── Makefile
├── scripts/
│ ├── analyze.sh
│ ├── setup_env.sh
│ └── generate_report.sh
├── test_data/
│ ├── sample_sim.log
│ ├── sample_pass.log
│ └── sample_fail.log
├── output/
└── docs/

## Setup

```bash
make setup

Usage
Run all logs:
make all
Run tests:
make test
Generate report:
make report
```

Manual execution:
bash scripts/analyze.sh test_data/sample_pass.log

sample Output:
=== RISC-V Simulation Log Analysis ===
Log file: test_data/sample_fail.log
Analysis date: Mon May 11 23:37:22 PKT 2026

--- Results Summary ---
Total tests: 3
Passed: 1
Failed: 1
Skipped: 1
Pass rate: 33.33%

--- Failed Tests ---
rv32i-sll

--- Timing Statistics ---
Min time: 0.82s
Max time: 1.02s
Avg time: 0.92s

--- Verdict: FAIL ---

Author

MEDS Module 1 Project
Student: MUHAMMAD KALEEM
result = a + b +c
