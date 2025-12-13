#!/usr/bin/env bash

# ==============================================================================
# Installs ncdu, a disk usage analyzer with an Ncurses interface.
# ==============================================================================



# --- Variables ---
CMD="ncdu"
PKG="ncdu"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
