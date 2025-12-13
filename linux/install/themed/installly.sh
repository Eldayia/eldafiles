#!/usr/bin/env bash

# ==============================================================================
# Installs Ly, a lightweight display manager, and enables its systemd service.
# ==============================================================================



# --- Variables ---
CMD="ly-dm" # The command to check for (e.g., rg)
PKG="ly"    # The package to install (e.g., ripgrep)

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
