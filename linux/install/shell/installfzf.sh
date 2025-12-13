#!/usr/bin/env bash

# ==============================================================================
# Installs fzf, a command-line fuzzy finder.
# ==============================================================================



# --- Variables ---
CMD="fzf"
PKG="fzf"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
