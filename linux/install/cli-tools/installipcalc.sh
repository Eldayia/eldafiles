#!/usr/bin/env bash

# ==============================================================================
# Installs ipcalc, a command-line tool for IP address calculations.
# ==============================================================================



# --- Variables ---
CMD="ipcalc"
PKG="ipcalc"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
