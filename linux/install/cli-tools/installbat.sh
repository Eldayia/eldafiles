#!/usr/bin/env bash

# ==============================================================================
# Installs bat, a cat(1) clone with syntax highlighting and Git integration.
# ==============================================================================



# --- Variables ---
CMD="bat"
PKG="bat"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
