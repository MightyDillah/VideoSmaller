#!/bin/bash

# Script to install/update Vincon video processing tools
# Detects OS and performs appropriate installation

echo "Vincon Video Processing Tools Installation/Update Script"
echo "======================================================"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
    INSTALL_CMD="sudo cp"
    INSTALL_PATH="/usr/local/bin"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
    INSTALL_CMD="sudo cp"
    INSTALL_PATH="/usr/local/bin"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

echo "Detected OS: $OS"
echo ""

# Check if running from the correct directory
if [ ! -f "vincon" ] || [ ! -f "moxy" ] || [ ! -f "shorty" ] || [ ! -f "README.md" ]; then
    echo "Error: This script must be run from the Vincon directory containing vincon, moxy, shorty, and README.md files."
    exit 1
fi

echo "The following commands will be executed:"
echo "  chmod +x vincon && $INSTALL_CMD vincon $INSTALL_PATH/vincon"
echo "  chmod +x moxy && $INSTALL_CMD moxy $INSTALL_PATH/moxy"
echo "  chmod +x shorty && $INSTALL_CMD shorty $INSTALL_PATH/shorty"
echo ""

read -p "Do you want to proceed with installation? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "Installing/updating Vincon tools..."
echo ""

# Install each tool
echo "Installing vincon..."
chmod +x vincon && $INSTALL_CMD vincon $INSTALL_PATH/vincon
if [ $? -eq 0 ]; then
    echo "✓ vincon installed/updated successfully"
else
    echo "✗ Failed to install/update vincon"
fi

echo ""

echo "Installing moxy..."
chmod +x moxy && $INSTALL_CMD moxy $INSTALL_PATH/moxy
if [ $? -eq 0 ]; then
    echo "✓ moxy installed/updated successfully"
else
    echo "✗ Failed to install/update moxy"
fi

echo ""

echo "Installing shorty..."
chmod +x shorty && $INSTALL_CMD shorty $INSTALL_PATH/shorty
if [ $? -eq 0 ]; then
    echo "✓ shorty installed/updated successfully"
else
    echo "✗ Failed to install/update shorty"
fi

echo ""
echo "Installation/Update Complete!"
echo "You can now use the tools from anywhere in your system:"
echo "  vincon /path/to/videos"
echo "  moxy /path/to/mkv/files"
echo "  shorty '3:10' video.mp4"