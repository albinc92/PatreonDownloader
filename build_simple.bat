@echo off
setlocal enabledelayedexpansion

echo ========================================
echo PatreonDownloader Build Script v3
echo ========================================

echo [INFO] Current directory: %CD%
echo [INFO] Checking for .NET SDK...

REM Check if we need to install .NET SDK first
if not exist "C:\Program Files\dotnet\sdk" (
    echo [WARNING] .NET SDK not found at standard location
    echo [INFO] You may need to install .NET SDK 8.0
    echo.
    echo MANUAL BUILD INSTRUCTIONS:
    echo 1. Install .NET SDK 8.0 from: https://dotnet.microsoft.com/download/dotnet/8.0
    echo 2. Open a new Command Prompt after installation
    echo 3. Navigate to: %CD%
    echo 4. Run these commands:
    echo    dotnet restore PatreonDownloader.sln
    echo    dotnet build PatreonDownloader.sln -c Release
    echo    cd PatreonDownloader.App
    echo    dotnet publish -c Release -r win-x64 --self-contained -f net8.0 -o bin\publish\net8.0-win-x64-release
    echo.
    pause
    exit /b 1
)

echo [SUCCESS] .NET SDK installation detected
echo [INFO] Attempting build...

dotnet restore PatreonDownloader.sln
if !errorlevel! neq 0 (
    echo [ERROR] NuGet restore failed
    pause
    exit /b 1
)

dotnet build PatreonDownloader.sln -c Release --no-restore  
if !errorlevel! neq 0 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)

cd PatreonDownloader.App
dotnet publish -c Release -r win-x64 --self-contained -f net8.0 -o bin\publish\net8.0-win-x64-release
if !errorlevel! neq 0 (
    echo [ERROR] Publish failed
    pause
    exit /b 1
)

cd bin\publish\net8.0-win-x64-release
if not exist "plugins" mkdir plugins

echo.
echo ========================================
echo BUILD SUCCESS! 🎉
echo ========================================
echo.
echo 📁 Location: %CD%
echo 🚀 Executable: PatreonDownloader.App.exe
echo ✅ Trailing space fix included!
echo.
echo TEST: PatreonDownloader.App.exe --help
echo.
pause
