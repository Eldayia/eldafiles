#!/usr/bin/env bash

# ==============================================================================
# Installs starship, the minimal, blazing-fast, and infinitely customizable
# prompt for any shell.
# ==============================================================================



# --- Variables ---
CMD="starship"
PKG="starship"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
