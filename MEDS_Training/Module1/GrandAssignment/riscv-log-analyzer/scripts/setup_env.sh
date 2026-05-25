#!/bin/bash

set -euo pipefail

TOOLS=(bash grep awk sed sort)

for tool in "${TOOLS[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "[OK] $tool installed"
    else
        echo "[ERROR] $tool missing"
    fi
done

mkdir -p output

echo "Environment setup complete"