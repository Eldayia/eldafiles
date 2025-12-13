#!/usr/bin/env bash

# ==============================================================================
# Installs duf, a Disk Usage/Free Utility.
# ==============================================================================



# --- Variables ---
CMD="duf"
PKG="duf"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
