#!/usr/bin/env bash

# ==============================================================================
# Generates an ED25519 SSH key if one doesn't exist and configures git user.
# ==============================================================================



# --- Functions ---

generate_ssh_key() {
  display_message "Checking for SSH key..."
  if [ -f ~/.ssh/id_ed25519 ]; then
    display_message "SSH key already exists."
  else
    display_message "Generating new SSH key..."
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
    display_message "SSH key generated successfully."
  fi
}

configure_git() {
  display_message "Configuring git user..."
  git config --global user.email "chloe.mortreux@proton.me"
  git config --global user.name "RikiLaNeko"
  display_message "Git user configured."
}

# --- Main Logic ---
generate_ssh_key
configure_git

