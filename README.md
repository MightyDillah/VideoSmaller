# VPT

## Moxy
Remove unneeded tracks in MKV files
moxy /path/to/mkv/files

## Vincon
Batch convert videos to HEVC using Apple VideoToolbox
vincon /path/to/videos

## Shorty
Trim MP4/MKV without re-encoding
shorty '3:10' video.mp4
shorty 'h1:30:00' video.mp4
shorty '3:10-3:15' video.mp4
shorty 'h1:20:00-h1:25:00' video.mp4
shorty '-90' video.mp4

## Install

### Automated Installation:
chmod +x update_vincon.sh && ./update_vincon.sh

### Manual Installation:

#### macOS:
chmod +x vincon && sudo cp vincon /usr/local/bin/vincon
chmod +x moxy && sudo cp moxy /usr/local/bin/moxy
chmod +x shorty && sudo cp shorty /usr/local/bin/shorty

#### Linux:
chmod +x vincon && sudo cp vincon /usr/local/bin/vincon
chmod +x moxy && sudo cp moxy /usr/local/bin/moxy
chmod +x shorty && sudo cp shorty /usr/local/bin/shorty