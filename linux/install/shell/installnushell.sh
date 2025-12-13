#!/usr/bin/env bash

# ==============================================================================
# Installs Nushell and sets it as the default shell.
# ==============================================================================



# --- Variables ---
CMD="nu"
PKG="nushell"

# --- Functions ---

install_nushell() {
  display_message "Installing ${PKG}..."
  if command -v ${CMD} &>/dev/null; then
    display_message "${PKG} is already installed."
  else
    yay -S --noconfirm --needed ${PKG}
    display_message "${PKG} installed successfully."
  fi
}

set_default_shell() {
  display_message "Setting ${PKG} as default shell..."
  if [ "$(getent passwd "$(logname)" | cut -d: -f7)" = "$(which nu)" ]; then
    display_message "${PKG} is already the default shell."
  else
    display_message "Setting ${PKG} as your default shell. You may be prompted for your password."
    local NU_PATH=$(which nu)
    if ! grep -q "$NU_PATH" /etc/shells; then
      display_message "Adding $NU_PATH to /etc/shells. You may be prompted for your password."
      echo "$NU_PATH" | sudo tee -a /etc/shells
    fi
    chsh -s "$NU_PATH"
    display_message "${PKG} set as default shell."
  fi
}

# --- Main Logic ---
install_nushell
set_default_shell