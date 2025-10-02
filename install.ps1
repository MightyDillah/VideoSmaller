# PowerShell installation script for VideoSmaller tools
# This script installs the VideoSmaller tools and their dependencies on Windows

Write-Host "VideoSmaller Installation Script for Windows" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Check if running as administrator (required for PATH modification)
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "This script requires administrator privileges to modify system PATH." -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator." -ForegroundColor Red
    Read-Host "Press any key to exit"
    exit 1
}

# Function to check if a command exists
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

# Check for Python
Write-Host "`nChecking for Python..." -ForegroundColor Yellow
if (Test-CommandExists "python3") {
    Write-Host "Python3 found: $(python3 --version)" -ForegroundColor Green
    # Create an alias for python to python3 for compatibility
    if (-not (Test-CommandExists "python")) {
        Set-Alias python python3
    }
} elseif (Test-CommandExists "python") {
    Write-Host "Python found: $(python --version)" -ForegroundColor Green
} else {
    Write-Host "Python not found. Please install Python before continuing." -ForegroundColor Red
    Read-Host "Press any key to exit"
    exit 1
}

# Check for required tools
$requiredTools = @("ffmpeg", "mkvmerge", "mediainfo")
$missingTools = @()

foreach ($tool in $requiredTools) {
    if (-not (Test-CommandExists $tool)) {
        $missingTools += $tool
    } else {
        Write-Host "$tool found" -ForegroundColor Green
    }
}

# Check for missing tools and warn user
if ($missingTools.Count -gt 0) {
    Write-Host "`nThe following required tools are missing:" -ForegroundColor Yellow
    foreach ($tool in $missingTools) {
        Write-Host "  - $tool" -ForegroundColor Red
    }

    Write-Host "`nPlease install the missing tools manually:" -ForegroundColor Yellow
    Write-Host "  - FFmpeg: https://www.gyan.dev/ffmpeg/builds/" -ForegroundColor White
    Write-Host "  - MKVToolNix: https://www.fosshub.com/MKVToolNix.html" -ForegroundColor White  
    Write-Host "  - MediaInfo: https://mediaarea.net/en/MediaInfo" -ForegroundColor White
    Write-Host "`nAfter installing, please restart this script." -ForegroundColor Yellow
    
    Read-Host "Press any key to exit"
    exit 1
} else {
    Write-Host "`nAll required tools are installed." -ForegroundColor Green
}

# Define source and destination directories
$sourceDir = Get-Location
$installDir = "$env:LOCALAPPDATA\VideoSmaller"

# Check if this script is run from the correct directory
$scriptFiles = @("vincon", "moxy", "shorty")
$missingFiles = @()

foreach ($file in $scriptFiles) {
    if (-not (Test-Path "$sourceDir\$file")) {
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host "Error: This script must be run from the VideoSmaller directory containing the script files." -ForegroundColor Red
    Write-Host "Missing files: $($missingFiles -join ', ')" -ForegroundColor Red
    Read-Host "Press any key to exit"
    exit 1
}

# Create installation directory
Write-Host "`nCreating installation directory: $installDir" -ForegroundColor Yellow
if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force
}

# Copy scripts with .py extension to make them executable on Windows
Write-Host "`nCopying VideoSmaller scripts..." -ForegroundColor Yellow

foreach ($script in $scriptFiles) {
    $sourcePath = "$sourceDir\$script"
    $destPath = "$installDir\$script.py"
    
    Copy-Item -Path $sourcePath -Destination $destPath -Force
    Write-Host "  Copied $script -> $destPath" -ForegroundColor Green
}

# Create batch files for easy execution
Write-Host "`nCreating batch files for easy access..." -ForegroundColor Yellow

$batchScripts = @{
    "vincon.bat" = "@echo off`npushd `"%~dp0`"&`npython3 `"$installDir\vincon.py`" %*`npopd"
    "moxy.bat" = "@echo off`npushd `"%~dp0`"&`npython3 `"$installDir\moxy.py`" %*`npopd"
    "shorty.bat" = "@echo off`npushd `"%~dp0`"&`npython3 `"$installDir\shorty.py`" %*`npopd"
}

foreach ($batchFile in $batchScripts.GetEnumerator()) {
    $batchPath = "$installDir\$($batchFile.Key)"
    $batchScripts[$batchFile.Key] | Out-File -FilePath $batchPath -Encoding ASCII
    Write-Host "  Created $($batchFile.Key)" -ForegroundColor Green
}

# Add to PATH if not already there
$userPath = [System.Environment]::GetEnvironmentVariable('Path', 'User')
if ($userPath -split ';' -notcontains $installDir) {
    Write-Host "`nAdding installation directory to PATH..." -ForegroundColor Yellow
    
    try {
        [System.Environment]::SetEnvironmentVariable('Path', ($userPath + ';' + $installDir), 'User')
        Write-Host "Successfully added $installDir to PATH" -ForegroundColor Green
        Write-Host "New PATH includes: $installDir" -ForegroundColor Green
        
        # Update current session PATH as well
        $env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
    } catch {
        Write-Host "Failed to add to PATH`: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "`n$installDir is already in PATH" -ForegroundColor Green
}

# Add aliases to PowerShell profile
Write-Host "`nAdding aliases to PowerShell profile..." -ForegroundColor Yellow

# Create PowerShell profile directory if it doesn't exist
$profileDir = Split-Path $PROFILE -Parent
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force
    Write-Host "Created PowerShell profile directory: $profileDir" -ForegroundColor Green
}

$newAliases = @"
# VideoSmaller tools aliases
function vincon { python3 "$installDir\vincon.py" @args }
function moxy { python3 "$installDir\moxy.py" @args }
function shorty { python3 "$installDir\shorty.py" @args }
"@

# Read current profile content
$profileExists = Test-Path $PROFILE
$currentProfile = if ($profileExists) { Get-Content $PROFILE -Raw } else { "" }

# Check if profile already contains VideoSmaller aliases
if ($currentProfile -match "# VideoSmaller tools aliases") {
    Write-Host "VideoSmaller aliases already exist in profile, skipping..." -ForegroundColor Yellow
} else {
    # Append aliases to profile
    if ($currentProfile) {
        $newProfileContent = $currentProfile + "`n`n" + $newAliases
    } else {
        $newProfileContent = $newAliases
    }
    
    try {
        $newProfileContent | Out-File -FilePath $PROFILE -Encoding UTF8
        Write-Host "Successfully added aliases to PowerShell profile: $PROFILE" -ForegroundColor Green
    } catch {
        Write-Host "Failed to update PowerShell profile`: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "You can manually add these aliases to your profile:" -ForegroundColor Yellow
        Write-Host $newAliases -ForegroundColor White
    }
}

Write-Host "`n`nInstallation completed!" -ForegroundColor Green
Write-Host "You can now use the tools from anywhere in your system:" -ForegroundColor Green
Write-Host "  vincon C:\path\to\videos" -ForegroundColor Cyan
Write-Host "  moxy C:\path\to\mkv\files" -ForegroundColor Cyan
Write-Host "  shorty '3:10' video.mp4" -ForegroundColor Cyan


Write-Host "`nNote: You may need to restart your command prompt or PowerShell for PATH changes to take effect." -ForegroundColor Yellow
Write-Host "The PowerShell aliases will be available in new PowerShell sessions." -ForegroundColor Yellow

Read-Host "`nPress any key to exit"