#!/usr/bin/env bash

# ==============================================================================
# Installs GNU Stow, a symlink farm manager.
# ==============================================================================



# --- Variables ---
CMD="stow"
PKG="stow"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
