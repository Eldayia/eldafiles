#!/usr/bin/env bash

# ==============================================================================
# Installs pavucontrol, a volume control tool for PulseAudio.
# ==============================================================================



# --- Variables ---
CMD="pavucontrol"
PKG="pavucontrol"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
