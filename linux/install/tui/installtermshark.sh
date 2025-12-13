#!/usr/bin/env bash

# ==============================================================================
# Installs Termshark, a terminal UI for tshark (Wireshark).
# ==============================================================================



# --- Variables ---
CMD="termshark"
PKG="termshark"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
