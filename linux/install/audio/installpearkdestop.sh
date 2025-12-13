#!/usr/bin/env bash

# ==============================================================================
# Template script for installing a single command-line tool or package.
#
# This template provides a standardized structure for installation scripts,
# including dependency sourcing, variable definitions, and consistent messaging.
# ==============================================================================

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Variables ---
CMD="pear-desktop" # The command to check for (e.g., rg)
PKG="pear-desktop" # The package to install (e.g., ripgrep)

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
else
  install_package "${PKG}"
fi
