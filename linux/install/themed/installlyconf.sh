#!/usr/bin/env bash

# ==============================================================================
# Copies the Ly display manager configuration file to its system location.
#
# This script ensures the destination directory exists and uses sudo for the
# copy operation.
# ==============================================================================



# --- Configuration ---

# Source path is relative to the project root (newArch) where this script is called from
SOURCE_CONFIG_FILE="../etc/ly/config.ini"
DEST_CONFIG_FILE="/etc/ly/config.ini"
DEST_CONFIG_DIR=$(dirname "$DEST_CONFIG_FILE")

# --- Functions ---

# Function to handle errors
handle_error() {
  echo "Error: $1" >&2
  exit 1
}

# --- Main Logic ---

display_message "Configuring ly display manager..."

# 1. Check for source file
if [ ! -f "$SOURCE_CONFIG_FILE" ]; then
  handle_error "Source configuration file not found at '$SOURCE_CONFIG_FILE'. Make sure you are running this from the 'newArch' directory."
fi
display_message "Source file found: $SOURCE_CONFIG_FILE"

# 2. Ensure destination directory exists
if [ ! -d "$DEST_CONFIG_DIR" ]; then
  display_message "Destination directory '$DEST_CONFIG_DIR' does not exist. Creating it with sudo."
  sudo mkdir -p "$DEST_CONFIG_DIR" || handle_error "Failed to create destination directory."
fi

# 3. Copy the configuration file
display_message "Copying '$SOURCE_CONFIG_FILE' to '$DEST_CONFIG_FILE'..."
sudo cp -f "$SOURCE_CONFIG_FILE" "$DEST_CONFIG_FILE" || handle_error "Failed to copy configuration file."

display_message "ly configuration updated successfully."
