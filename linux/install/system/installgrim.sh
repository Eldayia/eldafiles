#!/usr/bin/env bash

# ==============================================================================
# Installs grim, a screenshot utility for Wayland.
# ==============================================================================



# --- Variables ---
CMD="grim"
PKG="grim"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
