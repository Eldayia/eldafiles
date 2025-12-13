#!/usr/bin/env bash

# ==============================================================================
# Installs Plymouth, a graphical boot animation.
# ==============================================================================



# --- Variables ---
CMD="plymouth"
PKG="plymouth"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
