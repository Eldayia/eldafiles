#!/usr/bin/env bash

# ==============================================================================
# Installs ripgrep (rg), a line-oriented search tool.
# ==============================================================================



# --- Variables ---
CMD="rg"
PKG="ripgrep"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi

