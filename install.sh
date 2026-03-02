#!/bin/bash
# Install script for Every Code DH-fork (macOS/Linux)
# Builds the Rust binary and installs the npm package globally

set -e

echo "========================================"
echo "Installing Every Code DH-fork"
echo "========================================"
echo

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Build the Rust binary
echo "[1/2] Building Rust binary..."
cd code-rs
cargo build --package code-tui --profile dev-fast

cd "$SCRIPT_DIR"

# Install the npm package globally
echo "[2/2] Installing npm package globally..."
cd codex-cli
export CODE_LOCAL_BUILD="../code-rs/target/dev-fast/code-tui"
npm install -g --force .

echo
echo "========================================"
echo "Installation complete!"
echo "Run 'coder' to start Every Code DH-fork"
echo "========================================"
