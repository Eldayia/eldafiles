#!/usr/bin/env bash

# ==============================================================================
# Installs Podman, a daemonless container engine.
# ==============================================================================



# --- Variables ---
CMD="podman"
PKG="podman"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
