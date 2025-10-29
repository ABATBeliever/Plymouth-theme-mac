#!/bin/bash
# ===============================================
# plymouth-theme-mac-black Installer
# Author : ABATBeliever
# License: MIT
# Ver    : 1.0
# ===============================================

THEME_NAME="mac-black"
THEME_DIR="/usr/share/plymouth/themes/${THEME_NAME}"

echo "==============================================="
echo " Plymouth-Theme-Mac-Black Installer v1.0"
echo "==============================================="

if [ "$EUID" -ne 0 ]; then
  echo "Insufficient permissions"
  exit 1
fi

echo "Create a theme directory..."
mkdir -p "$THEME_DIR"

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

echo "Copying files..."
cp -f "$SCRIPT_DIR/apple-logo.png" "$THEME_DIR/"
cp -f "$SCRIPT_DIR/background.png" "$THEME_DIR/"
cp -f "$SCRIPT_DIR/mac-black.plymouth" "$THEME_DIR/"
cp -f "$SCRIPT_DIR/mac-black.script" "$THEME_DIR/"

echo "Registering theme to the list..."
update-alternatives --install /usr/share/plymouth/themes/default.plymouth \
  default.plymouth "$THEME_DIR/mac-black.plymouth" 100

echo "Setting theme..."
update-alternatives --set default.plymouth "$THEME_DIR/mac-black.plymouth"

echo "Reflecting in initramfs"
update-initramfs -u

echo "Task completed."
echo "Please : sudo reboot"
