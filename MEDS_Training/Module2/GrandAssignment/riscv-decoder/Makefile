# ==========================================================
# RISC-V RV32I Instruction Decoder
# Makefile
# ==========================================================

CC = gcc

CFLAGS = -Wall -Wextra -std=c11 -Iinclude -g

LDFLAGS =

SRC_DIR = src
OBJ_DIR = build
BIN_DIR = bin
TEST_DIR = test

TARGET = $(BIN_DIR)/riscv-decoder

SRC = $(SRC_DIR)/main.c \
      $(SRC_DIR)/decoder.c \
      $(SRC_DIR)/memory.c

OBJ = $(OBJ_DIR)/main.o \
      $(OBJ_DIR)/decoder.o \
      $(OBJ_DIR)/memory.o

.PHONY: all clean debug release test valgrind help dirs

# ----------------------------------------------------------
# Default target
# ----------------------------------------------------------

all: dirs $(TARGET)

# ----------------------------------------------------------
# Create directories
# ----------------------------------------------------------

dirs:
	mkdir -p $(OBJ_DIR)
	mkdir -p $(BIN_DIR)

# ----------------------------------------------------------
# Link executable
# ----------------------------------------------------------

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET)

# ----------------------------------------------------------
# Compile source files
# ----------------------------------------------------------

$(OBJ_DIR)/main.o: $(SRC_DIR)/main.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/decoder.o: $(SRC_DIR)/decoder.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/memory.o: $(SRC_DIR)/memory.c
	$(CC) $(CFLAGS) -c $< -o $@

# ----------------------------------------------------------
# Debug build
# ----------------------------------------------------------

debug: CFLAGS += -DDEBUG -O0
debug: clean all

# ----------------------------------------------------------
# Release build
# ----------------------------------------------------------

release: CFLAGS += -O2 -DNDEBUG
release: clean all

# ----------------------------------------------------------
# Run sample test
# ----------------------------------------------------------

test: all
	./$(TARGET) test/programs/mixed.hex

# ----------------------------------------------------------
# Check memory leaks
# ----------------------------------------------------------

valgrind: all
	valgrind --leak-check=full \
	--show-leak-kinds=all \
	./$(TARGET) test/programs/mixed.hex

# ----------------------------------------------------------
# Clean project
# ----------------------------------------------------------

clean:
	rm -rf $(OBJ_DIR)
	rm -rf $(BIN_DIR)

# ----------------------------------------------------------
# Help
# ----------------------------------------------------------

help:
	@echo "Available Targets:"
	@echo ""
	@echo "make           -> Build project"
	@echo "make debug     -> Debug build"
	@echo "make release   -> Optimized build"
	@echo "make test      -> Run sample decoder"
	@echo "make valgrind  -> Check memory leaks"
	@echo "make clean     -> Remove build files"