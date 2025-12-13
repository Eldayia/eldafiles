#!/usr/bin/env bash

# ==============================================================================
# Installs jq, a lightweight and flexible command-line JSON processor.
# ==============================================================================



# --- Variables ---
CMD="jq"
PKG="jq"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
