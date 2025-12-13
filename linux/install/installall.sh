#!/usr/bin/env bash

# ==============================================================================
# Main installation script for all tools and configurations.
#
# This script orchestrates the installation of various software packages and
# configurations by calling individual installation scripts.
# ==============================================================================

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Dependencies ---
#  shared functions for consistent messaging.
# Note: pkg-manager/installyay.sh is called before this as it's a bootstrap
# script and cannot rely on figlet/lolcat being installed yet.
source shared/functions.sh

# --- Main Logic ---

display_message "Starting all installations..."

# Package Manager (must be installed first)
source ./pkg-manager/installyay.sh

# CLI Tools that need to be installed early (e.g., for display messages)
source ./cli-tools/installfiglet.sh
source ./cli-tools/installlolcat.sh

# Nerd Font
source ./font/installnerdfont.sh

# Themed applications and configurations
source ./themed/installplymouth.sh
source ./themed/installly.sh
source ./themed/installlyconf.sh
source ./themed/installwaybar.sh


# System utilities
source ./system/installbrightnessctl.sh
source ./system/installgrim.sh
source ./system/installswappy.sh
source ./system/installplayerctl.sh

# Terminal emulators and related tools
source ./terminal/installghostty.sh
source ./terminal/installttyd.sh
source ./terminal/installwarp.sh

# Shell enhancements and utilities
source ./shell/installnushell.sh
source ./shell/installzoxide.sh
source ./shell/installzelij.sh
source ./shell/installfzf.sh
source ./shell/installatuin.sh

# Terminal User Interface (TUI) applications
source ./tui/installnewsboat.sh
source ./tui/installncdu.sh
source ./tui/installyazi.sh
source ./tui/installbtop.sh
source ./tui/installtermshark.sh
source ./tui/installlazygit.sh

# General CLI Tools
source ./cli-tools/installbat.sh
source ./cli-tools/installcroc.sh
source ./cli-tools/installgrex.sh
source ./cli-tools/installrg.sh
source ./cli-tools/installfd.sh
source ./cli-tools/installasciinema.sh
source ./cli-tools/installjrnl.sh
source ./cli-tools/installdoppler.sh
source ./cli-tools/installduf.sh
source ./cli-tools/installmtr.sh
source ./cli-tools/installprogress.sh
source ./cli-tools/installdog.sh
source ./cli-tools/installipcalc.sh
source ./cli-tools/installprocs.sh
source ./cli-tools/installrsync.sh
source ./cli-tools/installshred.sh
source ./cli-tools/installunp.sh
source ./cli-tools/installjq.sh
source ./cli-tools/installmoreutils.sh
source ./cli-tools/installstarship.sh
source ./cli-tools/installagg.sh

# Development Tools
source ./dev-tools/installdiffsofancy.sh
source ./dev-tools/installstow.sh

# Audio configuration
source ./audio/installpipewire.sh
source ./audio/installpavu.sh

# Security tools and configurations
source ./security/generatesshkey.sh
source ./security/installpass.sh

# Containerization tools
source ./containers/installpodman.sh

# Web Browsers
source ./browser/installedge.sh

# Communication applications
source ./communication/installvesktop.sh
source ./communication/installfluffychat.sh


display_message "All installations are complete!"
