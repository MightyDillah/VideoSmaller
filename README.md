# VideoSmaller

Just a collection of ultra niche video tools to make videos smaller. but I use them regularly so maybe there are other weirdos out there that might find them useful.

## Moxy
Batch remove unneeded tracks in MKV files it detects files that have similar tracks so it only asks you once.

Usage examples:
  Unix: moxy /path/to/mkv/files
  Windows: moxy .  (for current directory)
           moxy C:\path\to\mkv\files

## Vincon
Batch convert videos to HEVC using the best available hardware encoder (Apple VideoToolbox, AMD AMF, NVIDIA NVENC, or Intel QSV), it detects old format videos like avi or mpeg and matches their bitrate then converts them to mp4

Usage examples:
  Unix: vincon /path/to/videos
  Windows: vincon .  (for current directory)
           vincon C:\path\to\videos
vincon /path/to/videos

## Shorty
Trim MP4/MKV without re-encoding using specific scenarios, very useful if you just want to remove x seconds or minutes from a video without the drama

Usage examples:
  Unix: shorty '3:10' video.mp4
  Windows: shorty '3:10' video.mp4
           shorty 'h1:30:00' video.mp4
           shorty '3:10-3:15' video.mp4
           shorty 'h1:20:00-h1:25:00' video.mp4
           shorty '-90' video.mp4



## Install
note: you also need python3, but i wont get into that here you should already have it anyway.

### Pre-install
  Linux (apt):

   sudo apt update
   sudo apt install ffmpeg mkvtoolnix

  macOS (brew):

   brew install ffmpeg mkvtoolnix

  Windows:
   - Install Python 3 from https://python.org
   - Install required tools manually:
     - FFmpeg: https://www.gyan.dev/ffmpeg/builds/
     - MKVToolNix: https://www.fosshub.com/MKVToolNix.html
     - MediaInfo: https://mediaarea.net/en/MediaInfo

### Installation Scripts

This project includes platform-specific installation scripts:

- **update_vincon.sh**: For Unix-like systems (Linux/macOS)
- **install.ps1**: For Windows systems (PowerShell)
- **run_tool.bat**: Windows batch file for running tools

These scripts handle the different installation approaches needed for each platform, as system architectures and path management differ across operating systems.

### Installation Methods:

#### Unix-like systems (Linux/macOS) - Automated:
chmod +x update_vincon.sh && ./update_vincon.sh

#### Unix-like systems (Linux/macOS) - Manual:
chmod +x vincon && sudo cp vincon /usr/local/bin/vincon
chmod +x moxy && sudo cp moxy /usr/local/bin/moxy
chmod +x shorty && sudo cp shorty /usr/local/bin/shorty

#### Windows - Automated:
1. Install Python 3 from https://python.org
2. Run PowerShell as Administrator
3. Navigate to the VideoSmaller directory
4. Execute: .\install.ps1

This will:
- Check for Python and required tools
- Copy the scripts to a local directory
- Create batch files for easy access from Command Prompt
- Add the directory to your PATH environment variable
- Add PowerShell functions to your profile for easy access

#### Windows - Manual:
Run PowerShell as Administrator and execute: .\install.ps1

This will:
- Check for and install required dependencies using winget (if missing)
- Copy the scripts to a local directory
- Add the directory to your PATH environment variable
- Add aliases to your PowerShell profile for easy access
