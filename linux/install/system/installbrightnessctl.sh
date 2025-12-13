#!/usr/bin/env bash

# ==============================================================================
# Installs brightnessctl, a command-line utility to control screen brightness.
# ==============================================================================



# --- Variables ---
CMD="brightnessctl"
PKG="brightnessctl"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
