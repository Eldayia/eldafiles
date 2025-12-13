#!/usr/bin/env bash

# ==============================================================================
# Installs fd, a simple, fast and user-friendly alternative to find.
# ==============================================================================



# --- Variables ---
CMD="fd"
PKG="fd"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
