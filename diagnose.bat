@echo off
echo ========================================
echo PatreonDownloader Build Diagnostics
echo ========================================
echo.

echo [1] Checking current directory...
echo Current directory: %CD%
echo.

echo [2] Checking for solution file...
if exist "PatreonDownloader.sln" (
    echo ✅ PatreonDownloader.sln found
) else (
    echo ❌ PatreonDownloader.sln NOT found
    echo Make sure you're in the correct directory!
)
echo.

echo [3] Checking for project files...
if exist "PatreonDownloader.App\PatreonDownloader.App.csproj" (
    echo ✅ PatreonDownloader.App project found
) else (
    echo ❌ PatreonDownloader.App project NOT found
)

if exist "PatreonDownloader.Implementation\PatreonDownloader.Implementation.csproj" (
    echo ✅ PatreonDownloader.Implementation project found
) else (
    echo ❌ PatreonDownloader.Implementation project NOT found
)
echo.

echo [4] Checking submodules...
if exist "submodules\UniversalDownloaderPlatform\UniversalDownloaderPlatform.sln" (
    echo ✅ UniversalDownloaderPlatform submodule found
) else (
    echo ❌ UniversalDownloaderPlatform submodule NOT found
    echo Run: git submodule update --init --recursive
)
echo.

echo [5] Checking .NET SDK...
where dotnet >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ dotnet command found in PATH
    echo Trying to get version...
    dotnet --version 2>nul
    if %errorlevel% equ 0 (
        echo ✅ .NET SDK is working
    ) else (
        echo ❌ .NET SDK found but not working properly
        echo Please reinstall .NET SDK 8.0
    )
) else (
    echo ❌ dotnet command NOT found in PATH
    echo Please install .NET SDK 8.0 from:
    echo https://dotnet.microsoft.com/en-us/download/dotnet/8.0
)
echo.

echo [6] Checking our trailing space fix files...
if exist "PatreonDownloader.Implementation\PatreonCrawlTargetInfo.cs" (
    findstr /C:"PathSanitizer.SanitizePath" "PatreonDownloader.Implementation\PatreonCrawlTargetInfo.cs" >nul
    if %errorlevel% equ 0 (
        echo ✅ Trailing space fix applied to PatreonCrawlTargetInfo
    ) else (
        echo ❌ Trailing space fix NOT found in PatreonCrawlTargetInfo
    )
) else (
    echo ❌ PatreonCrawlTargetInfo.cs not found
)

if exist "submodules\UniversalDownloaderPlatform\UniversalDownloaderPlatform.Common\Helpers\PathSanitizer.cs" (
    findstr /C:"TrimEnd" "submodules\UniversalDownloaderPlatform\UniversalDownloaderPlatform.Common\Helpers\PathSanitizer.cs" >nul
    if %errorlevel% equ 0 (
        echo ✅ Enhanced PathSanitizer with trailing space fix found
    ) else (
        echo ❌ Enhanced PathSanitizer NOT found
    )
) else (
    echo ❌ PathSanitizer.cs not found
)

if exist "test_trailing_spaces.cs" (
    echo ✅ Test file found: test_trailing_spaces.cs
) else (
    echo ❌ Test file not found: test_trailing_spaces.cs
)
echo.

echo ========================================
echo Diagnostics Complete
echo ========================================
echo.
echo If all checks pass with ✅, you can build with:
echo    build.bat
echo.
echo If there are ❌ errors, please fix them first.
echo See BUILD_INSTRUCTIONS.md for detailed help.
echo.
pause
