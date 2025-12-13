#!/usr/bin/env bash

# ==============================================================================
# Installs lolcat, a tool for rainbow-colored text output.
# ==============================================================================



# --- Variables ---
CMD="lolcat"
PKG="lolcat"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
