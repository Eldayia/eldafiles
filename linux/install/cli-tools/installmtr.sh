#!/usr/bin/env bash

# ==============================================================================
# Installs mtr, a network diagnostic tool.
# ==============================================================================



# --- Variables ---
CMD="mtr"
PKG="mtr"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
