#!/usr/bin/env bash

# ==============================================================================
# Installs Ghostty, a GPU-accelerated terminal emulator.
# ==============================================================================



# --- Variables ---
CMD="ghostty"
PKG="ghostty"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
