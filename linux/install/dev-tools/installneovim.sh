#!/usr/bin/env bash

# ==============================================================================
# Installs Neovim, a hyperextensible Vim-based text editor.
# ==============================================================================



# --- Variables ---
CMD="nvim"
PKG="neovim"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
