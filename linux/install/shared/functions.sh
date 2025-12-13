#!/usr/bin/env bash

# ==============================================================================
# Shared functions for installation scripts
# ==============================================================================

# ------------------------------------------------------------------------------
# Displays a message using figlet and lolcat if available, otherwise uses echo.
#
# @param $1: The message to display.
# ------------------------------------------------------------------------------
display_message() {
  if command -v figlet &>/dev/null && command -v lolcat &>/dev/null; then
    figlet -t "$1" | lolcat -a -d 1 -t
  else
    echo "========================================"
    echo " $1"
    echo "========================================"
  fi
}

# ------------------------------------------------------------------------------
# Checks if a command exists in the system's PATH.
#
# @param $1: The command name to check.
# @return 0 if the command exists, 1 otherwise.
# ------------------------------------------------------------------------------
command_exists() {
  command -v "$1" &>/dev/null
}

# ------------------------------------------------------------------------------
# Checks if a package is installed using pacman.
#
# @param $1: The package name to check.
# @return 0 if the package is installed, 1 otherwise.
# ------------------------------------------------------------------------------
package_installed() {
  pacman -Q "$1" &>/dev/null
}

# ------------------------------------------------------------------------------
# Installs a package or a list of packages using yay.
#
# @param $@: A space-separated list of package names to install.
# ------------------------------------------------------------------------------
install_package() {
  local packages=("$@")
  if [ ${#packages[@]} -eq 0 ]; then
    display_message "No packages provided for installation."
    return 1
  fi

  local to_install=()
  for pkg in "${packages[@]}"; do
    if ! package_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -eq 0 ]; then
    display_message "All specified packages are already installed."
  else
    display_message "Installing packages: ${to_install[*]}..."
    yay -S --noconfirm --needed "${to_install[@]}"
    display_message "Packages installed successfully."
  fi
}
