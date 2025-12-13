#!/usr/bin/env bash

# ==============================================================================
# Installs asciinema, a tool for recording terminal sessions.
# ==============================================================================



# --- Variables ---
CMD="asciinema"
PKG="asciinema"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
