@echo off
REM Update script for Every Code DH-fork (Windows)
REM Pulls latest changes, rebuilds, and reinstalls

echo ========================================
echo Updating Every Code DH-fork
echo ========================================
echo.

REM Pull latest changes
echo [1/4] Pulling latest changes...
git pull
if errorlevel 1 (
    echo WARNING: git pull failed, continuing anyway...
)

REM Build the Rust binary
echo [2/4] Building Rust binary...
cd /d "%~dp0code-rs"
cargo build --package code-tui --profile dev-fast
if errorlevel 1 (
    echo ERROR: Rust build failed
    exit /b 1
)

cd /d "%~dp0"

REM Uninstall existing version
echo [3/4] Uninstalling existing version...
cd codex-cli
npm uninstall -g @just-every/code

REM Install the npm package globally
echo [4/4] Installing npm package globally...
set CODE_LOCAL_BUILD=..\code-rs\target\dev-fast\code-tui.exe
npm install -g --force .
if errorlevel 1 (
    echo ERROR: npm install failed
    exit /b 1
)

echo.
echo ========================================
echo Update complete!
echo Run 'coder' to start Every Code DH-fork
echo ========================================
