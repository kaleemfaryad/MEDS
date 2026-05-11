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
├── test_data/
├── output/
├── docs/

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

Manual execution:
bash scripts/analyze.sh test_data/sample_pass.log

Output Example
Total tests: 25
Passed: 22
Failed: 2
Skipped: 1
Pass rate: 88%

```
