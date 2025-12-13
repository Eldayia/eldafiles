#!/usr/bin/env bash

# ==============================================================================
# Installs ttyd, a command-line tool for sharing your terminal over the web.
# It installs ttyd from source, creates a systemd service, and enables it.
# ==============================================================================



# --- Variables ---
CMD="ttyd"
PKG="ttyd"
TTYD_REPO="https://github.com/tsl0922/ttyd.git"
TTYD_SERVICE_FILE="/etc/systemd/system/ttyd.service"

# --- Functions ---

install_ttyd_from_source() {
  display_message "Installing ${PKG} from source..."

  # Ensure libwebsockets is installed
  if ! pacman -Q libwebsockets &>/dev/null; then
    display_message "Installing dependency: libwebsockets..."
    yay -S --noconfirm --needed libwebsockets
  fi

  TEMP_DIR=$(mktemp -d)
  git clone "$TTYD_REPO" "$TEMP_DIR/ttyd"
  (
    cd "$TEMP_DIR/ttyd"
    mkdir build && cd build
    cmake ..
    make && sudo make install
  )
  rm -rf "$TEMP_DIR"
  display_message "${PKG} installed successfully."
}

configure_systemd_service() {
  display_message "Configuring systemd service for ${PKG}..."

  sudo tee "$TTYD_SERVICE_FILE" >/dev/null <<EOF
[Unit]
Description=ttyd terminal service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/ttyd -W nu
Restart=always
User=dedsec
# Uncomment if you want ttyd to not show output in logs
# StandardOutput=null
# StandardError=null

[Install]
WantedBy=multi-user.target
EOF

  sudo systemctl daemon-reload
  sudo systemctl enable ttyd.service
  sudo systemctl start ttyd.service
  display_message "Systemd service for ${PKG} configured and started."
}

# --- Main Logic ---
display_message "Installing ${PKG}..."

if command -v ${CMD} &>/dev/null; then
  display_message "${PKG} is already installed."
else
  install_ttyd_from_source
fi

configure_systemd_service
