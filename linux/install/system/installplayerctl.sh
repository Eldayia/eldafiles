#!/usr/bin/env bash

# ==============================================================================
# Installs playerctl, a command-line utility to control media players.
# ==============================================================================



# --- Variables ---
CMD="playerctl"
PKG="playerctl"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
