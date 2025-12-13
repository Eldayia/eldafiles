#!/usr/bin/env bash

# ==============================================================================
# Installs figlet, a tool for creating ASCII text banners.
# ==============================================================================



# --- Variables ---
CMD="figlet"
PKG="figlet"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
