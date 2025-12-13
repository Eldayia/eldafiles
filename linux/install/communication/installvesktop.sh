#!/usr/bin/env bash

# ==============================================================================
# Installs Vesktop, a Discord client with performance and privacy enhancements.
# ==============================================================================



# --- Variables ---
CMD="vesktop"
PKG="vesktop"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
