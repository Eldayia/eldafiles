#!/usr/bin/env bash

# ==============================================================================
# Installs dog, a command-line DNS client.
# ==============================================================================



# --- Variables ---
CMD="dog"
PKG="dog"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
