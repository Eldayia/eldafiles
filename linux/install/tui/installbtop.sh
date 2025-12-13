#!/usr/bin/env bash

# ==============================================================================
# Installs btop, a resource monitor that shows usage and stats for processor,
# memory, disks, network and processes.
# ==============================================================================



# --- Variables ---
CMD="btop"
PKG="btop"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
