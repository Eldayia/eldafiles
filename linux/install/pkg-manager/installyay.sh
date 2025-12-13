#!/usr/bin/env bash

# ==============================================================================
# Installs yay, an AUR helper for Arch Linux.
#
# This script is a prerequisite for many other installation scripts. It cannot
# use the shared display function because it runs before figlet and lolcat are
# guaranteed to be installed.
# ==============================================================================

# --- Local Functions ---

# A simplified display function for this bootstrap script.
display_message() {
  echo "--- $1 ---"
}

# --- Main Logic ---

if command -v yay &>/dev/null; then
  display_message "yay is already installed."
  return 0
fi

display_message "Installing yay..."

# Update system and install dependencies for building packages
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed base-devel git

# Clone and build yay from the AUR
TEMP_DIR=$(mktemp -d)
git clone https://aur.archlinux.org/yay.git "$TEMP_DIR/yay"
(
  cd "$TEMP_DIR/yay"
  makepkg -si --noconfirm
)
rm -rf "$TEMP_DIR"

display_message "yay installed successfully."
