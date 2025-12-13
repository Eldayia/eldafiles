#!/usr/bin/env bash

# ==============================================================================
# Installs swappy, a Wayland native screenshot editing tool.
# ==============================================================================



# --- Variables ---
CMD="swappy"
PKG="swappy"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
