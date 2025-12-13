#!/usr/bin/env bash

# ==============================================================================
# Installs Waybar, a highly customizable Wayland bar for Sway and other
# Wayland compositors.
# ==============================================================================



# --- Variables ---
CMD="waybar"
PKG="waybar"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
