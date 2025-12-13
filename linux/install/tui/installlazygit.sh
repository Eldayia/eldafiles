#!/usr/bin/env bash

# ==============================================================================
# Installs Lazygit, a simple terminal UI for git commands.
# ==============================================================================



# --- Variables ---
CMD="lazygit"
PKG="lazygit"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
