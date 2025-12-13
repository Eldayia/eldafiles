#!/usr/bin/env bash

# ==============================================================================
# Installs Newsboat, an RSS/Atom feed reader for the terminal, and configures
# some default feeds.
# ==============================================================================



# --- Variables ---
CMD="newsboat"
PKG="newsboat"
NEWSBOAT_URLS_FILE="$HOME/.newsboat/urls"

# --- Functions ---

install_newsboat() {
  display_message "Installing ${PKG}..."
  if command -v ${CMD} &>/dev/null; then
    display_message "${PKG} is already installed."
  else
    yay -S --noconfirm --needed ${PKG}
    display_message "${PKG} installed successfully."
  fi
}

configure_newsboat_feeds() {
  display_message "Configuring Newsboat RSS feeds..."

  mkdir -p "$HOME/.newsboat"
  touch "$NEWSBOAT_URLS_FILE"

  local URLS=(
    "https://blog.dreamsofcode.io/rss.xml"
    "https://hostinger.com/tutorials/feed"
    "https://feeds.leonid.codes/hacker_news.rss"
    "https://bullrich.dev/tldr-rss/feed.rss"
  )

  for url in "${URLS[@]}"; do
    if ! grep -qF "$url" "$NEWSBOAT_URLS_FILE"; then
      echo "$url" >>"$NEWSBOAT_URLS_FILE"
      display_message "Added $url to Newsboat feeds."
    else
      display_message "$url already exists in Newsboat feeds."
    fi
  done
  display_message "Newsboat feed configuration complete."
}

# --- Main Logic ---
install_newsboat
configure_newsboat_feeds

