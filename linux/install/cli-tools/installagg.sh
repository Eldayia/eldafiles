#!/usr/bin/env bash

# ==============================================================================
# Installs agg, a tool for aggregating terminal session recordings.
# It is installed from source using cargo.
# ==============================================================================



# --- Variables ---
CMD="agg"
PKG="agg"

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command_exists "${CMD}"; then
  display_message "${PKG} is already installed."
  exit 0
fi

# Ensure cargo is installed, as it's a dependency
if ! command_exists "cargo"; then
  display_message "Error: cargo is not installed. Please run the rust installer first." >&2
  exit 1
fi

display_message "Installing ${PKG} from source..."
cargo install --git https://github.com/asciinema/agg
display_message "${PKG} installed successfully."
