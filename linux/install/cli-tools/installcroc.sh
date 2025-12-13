#!/usr/bin/env bash

# ==============================================================================
# Installs croc, a tool for securely transferring files and folders.
# ==============================================================================



# --- Variables ---
CMD="croc"
PKG="croc"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
  exit 0
fi

# Ensure curl is installed, as it's a dependency for downloading
if ! command_exists "curl"; then
  display_message "Installing dependency: curl..."
  install_package "curl"
fi

display_message "Installing ${PKG} from getcroc.schollz.com..."
curl https://getcroc.schollz.com | bash

display_message "${PKG} installed successfully."