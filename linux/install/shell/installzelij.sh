#!/usr/bin/env bash

# ==============================================================================
# Installs Zellij, a terminal workspace multiplexer.
# ==============================================================================



# --- Variables ---
CMD="zellij"
PKG="zellij"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}" &>/dev/null; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
