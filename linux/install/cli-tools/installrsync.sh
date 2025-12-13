#!/usr/bin/env bash

# ==============================================================================
# Installs rsync, a utility for file copying and synchronization.
# ==============================================================================



# --- Variables ---
CMD="rsync"
PKG="rsync"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
