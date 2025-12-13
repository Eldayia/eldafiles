#!/usr/bin/env bash

# ==============================================================================
# Installs moreutils, a collection of useful Unix tools.
# ==============================================================================



# --- Variables ---
CMD="vipe" # A command from the moreutils package to check for installation
PKG="moreutils"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
