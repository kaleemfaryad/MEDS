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
	@echo "Running validation tests..."
	@bash scripts/analyze.sh test_data/sample_pass.log | grep -q "Verdict: PASS"
	@bash scripts/analyze.sh test_data/sample_fail.log | grep -q "Verdict: FAIL"
	@echo "All tests validated successfully"

report:
	@mkdir -p output
	@bash scripts/generate_report.sh test_data/sample_fail.log
	@echo "Report saved in output/"

clean:
	@rm -rf output/*
	@echo "Cleaned output directory"

setup:
	@bash scripts/setup_env.sh

help:
	@echo "Available targets:"
	@echo "  make all      - Analyze all log files"
	@echo "  make test     - Validate analyzer correctness"
	@echo "  make report   - Generate report"
	@echo "  make clean    - Clean output files"
	@echo "  make setup    - Check dependencies"
	@echo "  make help     - Show help"