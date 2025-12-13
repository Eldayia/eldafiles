#!/usr/bin/env bash

# ==============================================================================
# Installs unp, a script that unpacks archives.
# ==============================================================================



# --- Variables ---
CMD="unp"
PKG="unp"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
