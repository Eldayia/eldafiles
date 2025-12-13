#!/usr/bin/env bash

# ==============================================================================
# Installs VLC, a free and open source cross-platform multimedia player.
# ==============================================================================



# --- Variables ---
CMD="vlc"
PKG="vlc"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
