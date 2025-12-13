#!/usr/bin/env bash

# ==============================================================================
# Installs Atuin, a magical shell history.
# ==============================================================================



# --- Variables ---
CMD="atuin"
PKG="atuin"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
