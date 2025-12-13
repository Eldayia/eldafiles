#!/usr/bin/env bash

# ==============================================================================
# Installs the JetBrains Mono Nerd Font and sets it as the default monospace
# font for the system.
# ==============================================================================



# --- Variables ---
PKG="ttf-jetbrains-mono-nerd"

# --- Functions ---

install_font() {
  display_message "Installing ${PKG}..."
  if pacman -Q ${PKG} &>/dev/null; then
    display_message "${PKG} is already installed."
  else
    yay -S --noconfirm --needed ${PKG}
    display_message "${PKG} installed successfully."
  fi
}

configure_font() {
  display_message "Configuring default font..."
  if fc-match mono | grep -q "JetBrains Mono"; then
    display_message "JetBrains Mono is already the default monospace font."
  else
    display_message "Setting JetBrains Mono as default..."
    local FONT_CONFIG_DIR="$HOME/.config/fontconfig/conf.d"
    mkdir -p "$FONT_CONFIG_DIR"
    cat <<'EOF' > "$FONT_CONFIG_DIR/50-jetbrains-mono.conf"
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias>
    <family>monospace</family>
    <prefer>
      <family>JetBrains Mono</family>
    </prefer>
  </alias>
</fontconfig>
EOF
    display_message "Updating font cache..."
    fc-cache -f
    display_message "JetBrains Mono set as default."
  fi
}

# --- Main Logic ---
install_font
configure_font
