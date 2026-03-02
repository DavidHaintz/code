@echo off
REM Install script for Every Code DH-fork (Windows)
REM Builds the Rust binary and installs the npm package globally

echo ========================================
echo Installing Every Code DH-fork
echo ========================================
echo.

REM Build the Rust binary
echo [1/2] Building Rust binary...
cd /d "%~dp0code-rs"
cargo build --package code-tui --profile dev-fast
if errorlevel 1 (
    echo ERROR: Rust build failed
    exit /b 1
)

cd /d "%~dp0"

REM Install the npm package globally
echo [2/2] Installing npm package globally...
cd codex-cli
set CODE_LOCAL_BUILD=..\code-rs\target\dev-fast\code-tui.exe
npm install -g --force .
if errorlevel 1 (
    echo ERROR: npm install failed
    exit /b 1
)

echo.
echo ========================================
echo Installation complete!
echo Run 'coder' to start Every Code DH-fork
echo ========================================
