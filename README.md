# VideoSmaller

Just a collection of ultra niche video tools to make videos smaller. but I use them regularly so maybe there are other weirdos out there that might find them useful.

## Moxy
Batch remove unneeded tracks in MKV files it detects files that have similar tracks so it only asks you once.
moxy /path/to/mkv/files

## Vincon
Batch convert videos to HEVC using Apple VideoToolbox, it detects old format videos like avi or mpeg and matches their bitrate then converts them to mp4
vincon /path/to/videos

## Shorty
Trim MP4/MKV without re-encoding using specific scenarios, very useful if you just want to remove x seconds or minutes from a video without the drama
shorty '3:10' video.mp4
shorty 'h1:30:00' video.mp4
shorty '3:10-3:15' video.mp4
shorty 'h1:20:00-h1:25:00' video.mp4
shorty '-90' video.mp4

## Tracksize
Shows a list of all tracks in an MKV file sorted by size, with human-readable formatting (KB, MB, GB)
tracksize video.mkv

## Install
note: you also need python3, but i wont get into that here you should already have it anyway.

### Pre-install
  Linux (apt):

   sudo apt update
   sudo apt install ffmpeg mkvtoolnix

  macOS (brew):

   brew install ffmpeg mkvtoolnix

### Installation Methods:

#### Unix-like systems (Linux/macOS) - Automated:
chmod +x update_vincon.sh && ./update_vincon.sh

#### Unix-like systems (Linux/macOS) - Manual:
chmod +x vincon && sudo cp vincon /usr/local/bin/vincon
chmod +x moxy && sudo cp moxy /usr/local/bin/moxy
chmod +x shorty && sudo cp shorty /usr/local/bin/shorty
chmod +x tracksize && sudo cp tracksize /usr/local/bin/tracksize

#### Windows - Automated:
Run PowerShell as Administrator and execute:
.\install.ps1

This will:
- Check for and install required dependencies using winget (if missing)
- Copy the scripts to a local directory
- Add the directory to your PATH environment variable
- Add aliases to your PowerShell profile for easy access

#### Windows - Manual:
Run PowerShell as Administrator and execute:
.\install.ps1

This will:
- Check for and install required dependencies using winget (if missing)
- Copy the scripts to a local directory
- Add the directory to your PATH environment variable
- Add aliases to your PowerShell profile for easy access
