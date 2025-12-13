#!/usr/bin/env bash

# ==============================================================================
# Installs wl-clipboard, a command-line copy/paste utility for Wayland.
# ==============================================================================



# --- Variables ---
CMD="wl-copy"
PKG="wl-clipboard"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
