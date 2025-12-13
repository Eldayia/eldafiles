#!/usr/bin/env bash

# ==============================================================================
# Installs Yazi, a modern terminal file manager.
# ==============================================================================



# --- Variables ---
CMD="yazi"
PKG="yazi"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
