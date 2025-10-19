@echo off
REM Batch file to run VideoSmaller tools easily on Windows

if "%1"=="" (
    echo Usage: %0 ^<tool^> [args]
    echo Available tools: vincon, moxy, shorty
    exit /b 1
)

set tool=%1
shift

REM Run the appropriate Python script with all remaining arguments
if "%tool%"=="vincon" (
    python "%LOCALAPPDATA%\VideoSmaller\vincon.py" %*
) else if "%tool%"=="moxy" (
    python "%LOCALAPPDATA%\VideoSmaller\moxy.py" %*
) else if "%tool%"=="shorty" (
    python "%LOCALAPPDATA%\VideoSmaller\shorty.py" %*
) else (
    echo Unknown tool: %tool%
    echo Available tools: vincon, moxy, shorty
    exit /b 1
)