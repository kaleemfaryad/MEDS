.PHONY: all clean test report help setup

LOGS = test_data/sample_sim.log \
       test_data/sample_pass.log \
       test_data/sample_fail.log

all:
	@echo "Running analyzer on all logs"
	@for log in $(LOGS); do \
		bash scripts/analyze.sh $$log || true; \
	done

test:
	@echo "Running tests"
	@bash scripts/analyze.sh test_data/sample_pass.log
	@bash scripts/analyze.sh test_data/sample_fail.log || true
	@echo "Tests completed"

report:
	@mkdir -p output
	@bash scripts/generate_report.sh test_data/sample_fail.log

clean:
	@rm -rf output/*
	@echo "Cleaned output directory"

setup:
	@bash scripts/setup_env.sh

help:
	@echo "Available targets:"
	@echo "  make all      - Analyze all log files"
	@echo "  make test     - Run analyzer tests"
	@echo "  make report   - Generate HTML report"
	@echo "  make clean    - Remove generated files"
	@echo "  make setup    - Check required tools"
	@echo "  make help     - Show this help message"