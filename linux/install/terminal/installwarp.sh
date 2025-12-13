#!/usr/bin/env bash

# ==============================================================================
# Installs Warp, a modern terminal with AI features.
# ==============================================================================



# --- Variables ---
CMD="warp-terminal"
PKG="warp-terminal"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
