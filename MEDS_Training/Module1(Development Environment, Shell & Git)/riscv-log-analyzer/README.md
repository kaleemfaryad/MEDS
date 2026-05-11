# RISC-V Log Analyzer

A shell-based tool for analyzing RISC-V simulation logs.

## Features

- Parse simulation logs
- Count PASS/FAIL/SKIP tests
- Generate statistics
- Display failed tests
- Generate HTML reports
- Support CSV output

## Installation

```bash
make setup
Usage
bash scripts/analyze.sh test_data/sample_fail.log
Example
bash scripts/analyze.sh test_data/sample_fail.log --format csv
Generate Report
make report
```
