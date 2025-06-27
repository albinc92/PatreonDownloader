# PatreonDownloader Build Script for PowerShell
# =============================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PatreonDownloader Build Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check .NET SDK
Write-Host "Checking .NET SDK..." -ForegroundColor Yellow
try {
    $dotnetVersion = dotnet --version
    Write-Host "Found .NET SDK version: $dotnetVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: .NET SDK 8.0 is required but not found!" -ForegroundColor Red
    Write-Host "Please download and install .NET SDK 8.0 from:" -ForegroundColor Red
    Write-Host "https://dotnet.microsoft.com/en-us/download/dotnet/8.0" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Building PatreonDownloader..." -ForegroundColor Yellow
Write-Host ""

# Navigate to script directory
Set-Location $PSScriptRoot

try {
    # Restore NuGet packages
    Write-Host "[1/4] Restoring NuGet packages..." -ForegroundColor Blue
    dotnet restore PatreonDownloader.sln
    if ($LASTEXITCODE -ne 0) { throw "Failed to restore NuGet packages" }

    # Build the solution
    Write-Host ""
    Write-Host "[2/4] Building solution in Release mode..." -ForegroundColor Blue
    dotnet build PatreonDownloader.sln -c Release --no-restore
    if ($LASTEXITCODE -ne 0) { throw "Build failed" }

    # Publish self-contained executable
    Write-Host ""
    Write-Host "[3/4] Publishing self-contained executable for Windows x64..." -ForegroundColor Blue
    Set-Location "PatreonDownloader.App"
    dotnet publish -c Release -r win-x64 --self-contained -f net8.0 -o "bin\publish\net8.0-win-x64-release"
    if ($LASTEXITCODE -ne 0) { throw "Publish failed" }

    # Create plugins directory
    Write-Host ""
    Write-Host "[4/4] Creating plugins directory..." -ForegroundColor Blue
    Set-Location "bin\publish\net8.0-win-x64-release"
    if (!(Test-Path "plugins")) {
        New-Item -ItemType Directory -Name "plugins" | Out-Null
    }

    # Success message
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "BUILD COMPLETED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "The application has been built and published to:" -ForegroundColor Green
    Write-Host (Get-Location).Path -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Main executable: PatreonDownloader.App.exe" -ForegroundColor Green
    Write-Host ""
    Write-Host "To run the application:" -ForegroundColor Yellow
    Write-Host "1. Open Command Prompt or PowerShell" -ForegroundColor White
    Write-Host "2. Navigate to: $(Get-Location)" -ForegroundColor White
    Write-Host "3. Run: .\PatreonDownloader.App.exe --help" -ForegroundColor White
    Write-Host ""
    Write-Host "For usage instructions, see the README.md file." -ForegroundColor Yellow

} catch {
    Write-Host ""
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Build failed!" -ForegroundColor Red
} finally {
    Write-Host ""
    Read-Host "Press Enter to exit"
}
