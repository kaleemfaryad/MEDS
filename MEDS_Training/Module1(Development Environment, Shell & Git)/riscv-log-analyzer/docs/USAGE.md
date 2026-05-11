# Usage Guide

## analyze.sh

### Syntax

```bash
bash scripts/analyze.sh <logfile> [options]
```

Options
| Option | Description | |
| --------------- | ----------- | ------------- |
| --format text | csv | Output format |
| --output <file> | Save output | |
| --verbose | Debug mode | |
| --help | Show help | |

Examples
Basic run:
bash scripts/analyze.sh test_data/sample_fail.log
Save Output:
bash scripts/analyze.sh test_data/sample_fail.log --output output.txt

Makefile Commands:
make all
make test
make report
make clean
make setup
