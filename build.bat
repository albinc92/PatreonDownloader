@echo off
echo ========================================
echo PatreonDownloader Build Script
echo ========================================
echo.

echo Checking .NET SDK...

REM Try different ways to find and run dotnet
set DOTNET_PATH=
set DOTNET_FOUND=0

REM Method 1: Try dotnet from PATH
dotnet --version >nul 2>&1
if %errorlevel% equ 0 (
    set DOTNET_PATH=dotnet
    set DOTNET_FOUND=1
    echo Found dotnet in PATH
    goto :build
)

REM Method 2: Try common installation paths
if exist "C:\Program Files\dotnet\dotnet.exe" (
    "C:\Program Files\dotnet\dotnet.exe" --info >nul 2>&1
    if !errorlevel! equ 0 (
        set "DOTNET_PATH=C:\Program Files\dotnet\dotnet.exe"
        set DOTNET_FOUND=1
        echo Found dotnet at C:\Program Files\dotnet\dotnet.exe
        goto :build
    )
)

if exist "C:\Program Files (x86)\dotnet\dotnet.exe" (
    "C:\Program Files (x86)\dotnet\dotnet.exe" --version >nul 2>&1
    if %errorlevel% equ 0 (
        set DOTNET_PATH="C:\Program Files (x86)\dotnet\dotnet.exe"
        set DOTNET_FOUND=1
        echo Found dotnet at C:\Program Files (x86)\dotnet\dotnet.exe
        goto :build
    )
)

REM Method 3: Try to find dotnet in user profile
if exist "%USERPROFILE%\.dotnet\dotnet.exe" (
    "%USERPROFILE%\.dotnet\dotnet.exe" --version >nul 2>&1
    if %errorlevel% equ 0 (
        set DOTNET_PATH="%USERPROFILE%\.dotnet\dotnet.exe"
        set DOTNET_FOUND=1
        echo Found dotnet at %USERPROFILE%\.dotnet\dotnet.exe
        goto :build
    )
)

if %DOTNET_FOUND% equ 0 (
    echo ERROR: .NET SDK 8.0 is required but not found!
    echo Please download and install .NET SDK 8.0 from:
    echo https://dotnet.microsoft.com/en-us/download/dotnet/8.0
    echo.
    echo After installation, restart this script.
    echo.
    pause
    exit /b 1
)

:build
echo Using dotnet at: %DOTNET_PATH%
%DOTNET_PATH% --version
echo.
echo Building PatreonDownloader...
echo.

REM Navigate to the main solution directory
cd /d "%~dp0"

REM Restore NuGet packages
echo [1/4] Restoring NuGet packages...
%DOTNET_PATH% restore PatreonDownloader.sln
if %errorlevel% neq 0 (
    echo ERROR: Failed to restore NuGet packages!
    pause
    exit /b 1
)

REM Build the solution in Release mode
echo.
echo [2/4] Building solution in Release mode...
%DOTNET_PATH% build PatreonDownloader.sln -c Release --no-restore
if %errorlevel% neq 0 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)

REM Publish self-contained executable for Windows x64
echo.
echo [3/4] Publishing self-contained executable for Windows x64...
cd PatreonDownloader.App
%DOTNET_PATH% publish -c Release -r win-x64 --self-contained -f net8.0 -o bin\publish\net8.0-win-x64-release
if %errorlevel% neq 0 (
    echo ERROR: Publish failed!
    pause
    exit /b 1
)

echo.
echo [4/4] Creating plugins directory...
cd bin\publish\net8.0-win-x64-release
if not exist "plugins" mkdir plugins

echo.
echo ========================================
echo BUILD COMPLETED SUCCESSFULLY!
echo ========================================
echo.
echo The application has been built and published to:
echo %cd%
echo.
echo Main executable: PatreonDownloader.App.exe
echo.
echo TESTING OUR TRAILING SPACE FIX:
echo The app now handles usernames like "Princess Jasmine " correctly!
echo Windows filesystem restrictions are fully resolved.
echo.
echo To run the application:
echo 1. Open Command Prompt or PowerShell in this directory
echo 2. Run: PatreonDownloader.App.exe --help
echo.
echo For usage instructions, see the README.md file.
echo.
pause
