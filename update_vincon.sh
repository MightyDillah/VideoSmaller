#!/bin/bash

# Script to install/update Vincon video processing tools
# Uses selection menu for OS choice

echo "Vincon Video Processing Tools Installation/Update Script"
echo "======================================================"

# Selection menu for OS
echo "Please select your operating system:"
echo "1) Linux"
echo "2) macOS"
echo "3) Exit"
echo ""
printf "Enter your choice (1-3): "
read OS_CHOICE

case $OS_CHOICE in
    1)
        OS="Linux"
        INSTALL_CMD="sudo cp"
        INSTALL_PATH="/usr/local/bin"
        ;;
    2)
        OS="macOS"
        INSTALL_CMD="sudo cp"
        INSTALL_PATH="/usr/local/bin"
        ;;
    3)
        echo "Installation cancelled."
        exit 0
        ;;
    *)
        echo "Invalid choice. Installation cancelled."
        exit 1
        ;;
esac

echo "Selected OS: $OS"
echo ""

# Check if running from the correct directory
if [ ! -f "vincon" ] || [ ! -f "moxy" ] || [ ! -f "shorty" ] || [ ! -f "README.md" ]; then
    echo "Error: This script must be run from the Vincon directory containing vincon, moxy, shorty, and README.md files."
    exit 1
fi

# Check if required tools exist and are readable
for tool in vincon moxy shorty; do
    if [ ! -r "$tool" ]; then
        echo "Error: Required file '$tool' not found or not readable in current directory."
        exit 1
    fi
done

echo "The following commands will be executed:"
echo "  chmod +x vincon && $INSTALL_CMD vincon $INSTALL_PATH/vincon"
echo "  chmod +x moxy && $INSTALL_CMD moxy $INSTALL_PATH/moxy"
echo "  chmod +x shorty && $INSTALL_CMD shorty $INSTALL_PATH/shorty"
echo ""

printf "Do you want to proceed with installation? (y/N): "
read REPLY
echo
if [ ! "$REPLY" = "y" ] && [ ! "$REPLY" = "Y" ]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "Installing/updating Vincon tools..."
echo ""

# Install each tool
echo "Installing vincon..."
if chmod +x vincon && $INSTALL_CMD vincon $INSTALL_PATH/vincon; then
    echo "✓ vincon installed/updated successfully"
else
    echo "✗ Failed to install/update vincon"
    exit 1
fi

echo ""

echo "Installing moxy..."
if chmod +x moxy && $INSTALL_CMD moxy $INSTALL_PATH/moxy; then
    echo "✓ moxy installed/updated successfully"
else
    echo "✗ Failed to install/update moxy"
    exit 1
fi

echo ""

echo "Installing shorty..."
if chmod +x shorty && $INSTALL_CMD shorty $INSTALL_PATH/shorty; then
    echo "✓ shorty installed/updated successfully"
else
    echo "✗ Failed to install/update shorty"
    exit 1
fi

echo ""
echo "Installation/Update Complete!"
echo "You can now use the tools from anywhere in your system:"
echo "  vincon /path/to/videos"
echo "  moxy /path/to/mkv/files"
echo "  shorty '3:10' video.mp4"