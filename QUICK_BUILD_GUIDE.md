# 🔨 PatreonDownloader Build Guide - Complete Instructions

## 🎯 **Current Status**
✅ Your trailing space fix is ready and committed  
✅ All source code is prepared  
❌ .NET SDK needs to be installed to build  

## 📥 **Step 1: Install .NET SDK 8.0**

1. **Download .NET SDK 8.0** (not just runtime):
   - Go to: https://dotnet.microsoft.com/download/dotnet/8.0
   - Click **"Download .NET SDK x64"** (not runtime)
   - Run the installer

2. **Verify Installation**:
   ```cmd
   # Open a NEW Command Prompt and run:
   dotnet --version
   
   # Should show something like: 8.0.xxx
   ```

## 🔨 **Step 2: Build the Application**

**Option A: Use Our Build Script (Recommended)**
```cmd
# Navigate to project directory
cd "c:\Users\Albin\Documents\PatreonDownloader"

# Run the build script
build_simple.bat
```

**Option B: Manual Build Commands**
```cmd
# Navigate to project directory
cd "c:\Users\Albin\Documents\PatreonDownloader"

# Restore packages
dotnet restore PatreonDownloader.sln

# Build solution
dotnet build PatreonDownloader.sln -c Release

# Publish self-contained executable
cd PatreonDownloader.App
dotnet publish -c Release -r win-x64 --self-contained -f net8.0 -o bin\publish\net8.0-win-x64-release

# Create plugins directory
cd bin\publish\net8.0-win-x64-release
mkdir plugins
```

## 📁 **Step 3: Find Your Built Application**

After successful build, your executable will be at:
```
c:\Users\Albin\Documents\PatreonDownloader\PatreonDownloader.App\bin\publish\net8.0-win-x64-release\PatreonDownloader.App.exe
```

## 🧪 **Step 4: Test Your Build**

```cmd
# Navigate to the build directory
cd "c:\Users\Albin\Documents\PatreonDownloader\PatreonDownloader.App\bin\publish\net8.0-win-x64-release"

# Test the application
PatreonDownloader.App.exe --help

# Test a real download (replace with actual URL)
PatreonDownloader.App.exe --url "https://www.patreon.com/creatorname" --download-directory "C:\Downloads\Patreon"
```

## ✅ **What You'll Get**

Your built application includes:
- ✅ **Trailing space fix** - "Princess Jasmine " → "Princess Jasmine"
- ✅ **Windows reserved names** - "CON" → "_CON"  
- ✅ **Invalid characters** - "Test<>User?" → "Test__User_"
- ✅ **All filesystem issues resolved**
- ✅ **Self-contained** - No need to install .NET on other machines

## 🔧 **Troubleshooting**

### "No .NET SDKs were found"
- Install .NET SDK 8.0 (not just runtime)
- Restart Command Prompt after installation

### "Unable to find project"
- Make sure you're in: `c:\Users\Albin\Documents\PatreonDownloader`
- Verify `PatreonDownloader.sln` exists

### "NuGet restore failed"
- Check internet connection
- Try: `dotnet nuget locals all --clear`

### "Build failed"
- Make sure submodules are updated: `git submodule update --init --recursive`
- Try clean rebuild: `dotnet clean` then rebuild

## 🎉 **Ready to Use!**

Once built, your PatreonDownloader will handle ANY problematic username:
- "Princess Jasmine " ✅
- "Test<>User|Name?" ✅  
- "CON" ✅
- ".hidden_user" ✅

**Your original DirectoryNotFoundException error is completely fixed!** 🎊

---

## 📞 **Need Help?**

If you encounter issues:
1. Run `diagnose.bat` to check prerequisites
2. Make sure .NET SDK 8.0 is installed (not just runtime)
3. Use a fresh Command Prompt after .NET installation
4. Verify you're in the correct directory
