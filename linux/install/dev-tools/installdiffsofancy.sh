#!/usr/bin/env bash

# ==============================================================================
# Installs diff-so-fancy and configures git to use it.
# ==============================================================================



# --- Variables ---
CMD="diff-so-fancy"
PKG="diff-so-fancy"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi

display_message "Configuring git to use ${PKG}..."
git config --global core.pager "diff-so-fancy | less --tabs=4 -RF"
git config --global interactive.diffFilter "diff-so-fancy --patch"
display_message "Git configured successfully."
