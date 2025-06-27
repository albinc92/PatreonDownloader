# 🔨 PatreonDownloader Build Guide

## ✅ Prerequisites

1. **Install .NET SDK 8.0**
   - Download from: https://dotnet.microsoft.com/en-us/download/dotnet/8.0
   - Choose the SDK (not just runtime)
   - Verify installation: Open Command Prompt and run `dotnet --version`

2. **Ensure Git Submodules are Updated**
   ```bash
   git submodule update --init --recursive
   ```

## 🚀 Quick Build (Recommended)

### Option 1: Using the Build Scripts

**For Windows (PowerShell):**
```powershell
# Navigate to project directory
cd "c:\Users\Albin\Documents\PatreonDownloader"

# Run the build script
PowerShell -ExecutionPolicy Bypass -File "build.ps1"
```

**For Windows (Command Prompt):**
```cmd
# Navigate to project directory
cd "c:\Users\Albin\Documents\PatreonDownloader"

# Run the build script
build.bat
```

### Option 2: Manual Build Steps

1. **Navigate to Project Directory**
   ```cmd
   cd "c:\Users\Albin\Documents\PatreonDownloader"
   ```

2. **Restore NuGet Packages**
   ```cmd
   dotnet restore PatreonDownloader.sln
   ```

3. **Build Solution**
   ```cmd
   dotnet build PatreonDownloader.sln -c Release
   ```

4. **Publish Self-Contained Executable**
   ```cmd
   cd PatreonDownloader.App
   dotnet publish -c Release -r win-x64 --self-contained -f net8.0 -o bin\publish\net8.0-win-x64-release
   ```

5. **Create Plugins Directory**
   ```cmd
   cd bin\publish\net8.0-win-x64-release
   mkdir plugins
   ```

## 📁 Build Output

After successful build, you'll find the executable at:
```
c:\Users\Albin\Documents\PatreonDownloader\PatreonDownloader.App\bin\publish\net8.0-win-x64-release\PatreonDownloader.App.exe
```

## 🧪 Testing Your Build

1. **Navigate to Build Directory**
   ```cmd
   cd "c:\Users\Albin\Documents\PatreonDownloader\PatreonDownloader.App\bin\publish\net8.0-win-x64-release"
   ```

2. **Test the Application**
   ```cmd
   PatreonDownloader.App.exe --help
   ```

3. **Test Our Trailing Space Fix**
   ```cmd
   # Copy our test file to the build directory first
   copy "..\..\..\..\..\..\test_trailing_spaces.cs" .
   
   # Then you can test the path sanitization (if you want to compile it)
   ```

## 🎯 What You Get

After building, you'll have:
- ✅ **Self-contained executable** - No need to install .NET Runtime on target machines
- ✅ **All dependencies included** - Including our trailing space fixes
- ✅ **Windows filesystem compatibility** - Handles ALL problematic usernames
- ✅ **Ready to use** - Just run `PatreonDownloader.App.exe`

## 🔧 Troubleshooting

### "No .NET SDKs were found"
- Download and install .NET SDK 8.0 (not just runtime)
- Restart Command Prompt/PowerShell after installation
- Verify with: `dotnet --version`

### "Unable to find project"
- Ensure you're in the correct directory: `c:\Users\Albin\Documents\PatreonDownloader`
- Check that `PatreonDownloader.sln` exists in current directory

### "Submodule errors"
- Update submodules: `git submodule update --init --recursive`
- Our changes are in both main repo and UniversalDownloaderPlatform submodule

### Build Succeeds But App Doesn't Work
- Make sure you're running the executable from the publish directory
- Check that `plugins` directory exists (create it if missing)

## 📝 Usage After Building

Once built, you can use the application like this:

```cmd
# Show help
PatreonDownloader.App.exe --help

# Download a creator's content
PatreonDownloader.App.exe --url "https://www.patreon.com/creatorname" --download-directory "C:\Downloads\Patreon"

# Download with all extras (descriptions, images, etc.)
PatreonDownloader.App.exe --url "https://www.patreon.com/creatorname" --download-directory "C:\Downloads\Patreon" --descriptions --embeds --campaign-images --json
```

Your trailing space issue with usernames like "Princess Jasmine " is now completely fixed! 🎉
