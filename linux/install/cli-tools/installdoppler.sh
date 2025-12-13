#!/usr/bin/env bash

# ==============================================================================
# Installs the Doppler CLI for managing secrets.
# ==============================================================================



# --- Variables ---
CMD="doppler"
PKG="Doppler CLI"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
  exit 0
fi

# Ensure curl or wget is installed
if ! command_exists "curl" && ! command_exists "wget"; then
  display_message "Error: curl or wget is required to install Doppler." >&2
  display_message "Installing dependency: curl..."
  install_package "curl"
fi

display_message "Installing ${PKG} from cli.doppler.com..."
(curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh || wget -t 3 -qO- https://cli.doppler.com/install.sh) | sudo sh

display_message "${PKG} installed successfully."
