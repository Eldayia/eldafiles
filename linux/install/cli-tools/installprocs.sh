#!/usr/bin/env bash

# ==============================================================================
# Installs procs, a modern replacement for ps.
# ==============================================================================



# --- Variables ---
CMD="procs"
PKG="procs"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
