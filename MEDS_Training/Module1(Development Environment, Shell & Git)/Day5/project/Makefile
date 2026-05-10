# Print any variable (usage: make print-VARNAME)
print-%:
	@echo '$* = $($*)'
	@echo 'Expanded: $($*)'

# Enhanced config with more details
config:
	@echo "=== Current Configuration ==="
	@echo "  CC         = $(CC)"
	@echo "  CFLAGS     = $(CFLAGS)"
	@echo "  LDFLAGS    = $(LDFLAGS)"
	@echo "  OPTIMIZE   = $(OPTIMIZE)"
	@echo "  DEBUG      = $(DEBUG)"
	@echo "  SRC        = $(SRC)"
	@echo "  OBJ        = $(OBJ)"
	@echo "  TARGET     = $(TARGET)"
	@echo "  BUILD_DIR  = $(BUILD_DIR)"
	@echo "  OBJ_WITH_DIR = $(OBJ_WITH_DIR)"
	@echo ""
	@echo "=== Build Commands ==="
	@echo "  Compile:    $(CC) $(CFLAGS) -c [file].c -o [file].o"
	@echo "  Link:       $(CC) $(LDFLAGS) -o $(TARGET) $(OBJ_WITH_DIR)"
	@echo ""
	@echo "=== Compiler Info ==="
	@$(CC) --version | head -1
	@echo ""
	@echo "=== Quick Commands ==="
	@echo "  make                - Build with defaults"
	@echo "  make release        - Build with -O2"
	@echo "  make debug          - Build with debug symbols"
	@echo "  make clean          - Remove build files"
	@echo "  make test           - Run tests"
	@echo "  make config         - Show this config"
	@echo "  make print-VAR      - Print any variable"

# Additional utility targets
info:
	@echo "Makefile Information:"
	@echo "======================"
	@echo "Number of source files: $(words $(SRC))"
	@echo "Source files: $(SRC)"
	@echo "Object files: $(OBJ_WITH_DIR)"
	@echo ""
	@echo "Built-in variables:"
	@echo "  MAKE_VERSION = $(MAKE_VERSION)"
	@echo "  SHELL = $(SHELL)"
	@echo "  .CURDIR = $(CURDIR)"

# Check if compiler is available
check:
	@command -v $(CC) >/dev/null 2>&1 && echo "✅ $(CC) found" || echo "❌ $(CC) not found"
	@echo "Compiler version:"
	@$(CC) --version 2>/dev/null | head -1 || echo "Compiler not available"

# Create directory structure (useful for new projects)
setup:
	@mkdir -p $(BUILD_DIR)
	@echo "Created $(BUILD_DIR)/ directory"
	@echo "Project structure ready"

# Show help for variables
help-vars:
	@echo "=== Makefile Variables ==="
	@echo "  CC          - C compiler (default: gcc)"
	@echo "  CFLAGS      - Compiler flags (default: -Wall -Wextra -std=c11 -g)"
	@echo "  LDFLAGS     - Linker flags (default: -lm)"
	@echo "  OPTIMIZE    - Optimization level (default: -O0)"
	@echo "  DEBUG       - Enable debug mode (default: 0, set to 1 to enable)"
	@echo "  BUILD_DIR   - Build directory (default: build)"
	@echo ""
	@echo "Examples:"
	@echo "  make CC=clang CFLAGS='-O2' all"
	@echo "  make DEBUG=1 clean all"
	@echo "  make OPTIMIZE=-O3 release"