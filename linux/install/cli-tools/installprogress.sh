#!/usr/bin/env bash

# ==============================================================================
# Installs progress, a tool to monitor the progress of coreutils commands.
# ==============================================================================



# --- Variables ---
CMD="progress"
PKG="progress"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
