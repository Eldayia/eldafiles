#!/usr/bin/env bash

# ==============================================================================
# Installs zoxide, a smarter cd command.
# ==============================================================================



# --- Variables ---
CMD="zoxide"
PKG="zoxide"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command -v ${CMD} &>/dev/null; then
  display_message "${PKG} is already installed."
  exit 0
fi

# Ensure curl is installed, as it's a dependency for downloading
if ! command -v curl &>/dev/null; then
  display_message "Installing dependency: curl..."
  yay -S --noconfirm --needed curl
fi

display_message "Installing ${PKG} from GitHub..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

display_message "${PKG} installed successfully."

