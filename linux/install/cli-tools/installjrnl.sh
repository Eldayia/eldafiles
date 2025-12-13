#!/usr/bin/env bash

# ==============================================================================
# Installs jrnl, a command-line journal application.
# ==============================================================================



# --- Variables ---
CMD="jrnl"
PKG="jrnl"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
