#!/usr/bin/env bash

# ==============================================================================
# Installs PipeWire and related audio components.
#
# This script installs the core PipeWire package along with replacements for
# PulseAudio and ALSA, and the ALSA utilities.
# ==============================================================================



# --- Variables ---
PACKAGES=(
  "pipewire"
  "pipewire-pulse"
  "pipewire-alsa"
  "alsa-utils"
)

# --- Main Logic ---
display_message "Installing PipeWire..."

install_package "${PACKAGES[@]}"
