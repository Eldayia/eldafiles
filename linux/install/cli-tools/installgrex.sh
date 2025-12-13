#!/usr/bin/env bash

# ==============================================================================
# Installs grex, a command-line tool for generating regular expressions.
# ==============================================================================



# --- Variables ---
CMD="grex"
PKG="grex"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
