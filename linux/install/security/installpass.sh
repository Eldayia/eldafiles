#!/usr/bin/env bash

# ==============================================================================
# Installs pass, the standard unix password manager.
# ==============================================================================



# --- Variables ---
CMD="pass"
PKG="pass"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
