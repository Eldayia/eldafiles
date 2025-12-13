#!/usr/bin/env bash

# ==============================================================================
# Installs Microsoft Edge browser.
# ==============================================================================



# --- Variables ---
CMD="microsoft-edge-stable"
PKG="microsoft-edge-stable-bin"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
