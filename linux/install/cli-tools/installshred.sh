#!/usr/bin/env bash

# ==============================================================================
# Installs shred from coreutils, a tool for securely deleting files.
# ==============================================================================



# --- Variables ---
CMD="shred"
PKG="coreutils" # shred is part of coreutils

# --- Main Logic ---
display_message "Checking for ${CMD}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
