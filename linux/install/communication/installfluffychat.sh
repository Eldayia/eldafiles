#!/usr/bin/env bash

# ==============================================================================
# Installs Fluffychat, a Matrix client.
# ==============================================================================



# --- Variables ---
CMD="fluffychat"
PKG="fluffychat-bin"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
