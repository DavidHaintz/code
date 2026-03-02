#!/bin/bash
# Update script for Every Code DH-fork (macOS/Linux)
# Pulls latest changes, rebuilds, and reinstalls

set -e

echo "========================================"
echo "Updating Every Code DH-fork"
echo "========================================"
echo

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Pull latest changes
echo "[1/4] Pulling latest changes..."
git pull || echo "WARNING: git pull failed, continuing anyway..."

# Build the Rust binary
echo "[2/4] Building Rust binary..."
cd code-rs
cargo build --package code-tui --profile dev-fast

cd "$SCRIPT_DIR"

# Uninstall existing version
echo "[3/4] Uninstalling existing version..."
cd codex-cli
npm uninstall -g @just-every/code || true

# Install the npm package globally
echo "[4/4] Installing npm package globally..."
export CODE_LOCAL_BUILD="../code-rs/target/dev-fast/code-tui"
npm install -g --force .

echo
echo "========================================"
echo "Update complete!"
echo "Run 'coder' to start Every Code DH-fork"
echo "========================================"
