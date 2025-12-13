# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository (`eldafiles`) centralizes personal configuration files (dotfiles) and installation scripts for both Windows and Linux environments. The primary goal is to automate system setup and maintain consistent configurations across different machines.

## Repository Structure

```
eldafiles/
├── windows/
│   ├── install/          # Windows installation scripts
│   └── config/           # Windows configuration files (currently empty)
├── linux/
│   ├── install/          # Modular Linux installation scripts
│   └── config/           # Linux configuration files (dotfiles)
└── README.md             # French documentation
```

## Linux Installation System

### Architecture

The Linux installation system is highly modular, with a master orchestrator script that sources individual installation scripts organized by category.

**Key Files:**
- `linux/install/installall.sh` - Master script that orchestrates all installations in dependency order
- `linux/install/template.sh` - Template for creating new installation scripts
- `linux/install/shared/functions.sh` - Shared utility functions used by all scripts
- `linux/install/packages-list.txt` - Documentation of all packages with descriptions

### Script Categories

Installation scripts are organized into directories by purpose:
- `pkg-manager/` - Package manager setup (yay for AUR)
- `cli-tools/` - Command-line utilities
- `tui/` - Terminal user interface applications
- `shell/` - Shell enhancements (nushell, zoxide, fzf, atuin)
- `terminal/` - Terminal emulators (ghostty, warp)
- `font/` - Font installations (JetBrains Mono Nerd Font)
- `themed/` - Theming applications (plymouth, ly, waybar)
- `system/` - System utilities (brightnessctl, grim, swappy, playerctl)
- `audio/` - Audio configuration (pipewire)
- `security/` - Security tools (SSH key generation, pass)
- `dev-tools/` - Development tools (diff-so-fancy, stow)
- `containers/` - Containerization (podman)
- `browser/` - Web browsers (Microsoft Edge)
- `communication/` - Communication apps (vesktop, fluffychat)
- `media/`, `games/`, `lang/`, `proton/` - Other categories

### Shared Functions

All installation scripts source `linux/install/shared/functions.sh` which provides:

- `display_message(msg)` - Displays messages using figlet/lolcat if available, otherwise plain echo
- `command_exists(cmd)` - Checks if a command exists in PATH
- `package_installed(pkg)` - Checks if a package is installed via pacman
- `install_package(pkg...)` - Installs packages using yay, skipping already-installed packages

### Installation Script Pattern

Each installation script follows this pattern:
1. Set error exit mode (`set -e`)
2. Define `CMD` (command to check) and `PKG` (package to install)
3. Call `display_message` to announce the installation
4. Check if already installed using `command_exists` or `package_installed`
5. Install using `install_package` if not present
6. Some tools (like agg) are installed from source using cargo

### Execution Order

`installall.sh` sources scripts in a specific dependency order:
1. Package manager (yay) - must be first
2. CLI tools for display (figlet, lolcat) - needed for pretty output
3. Fonts, themed apps, system utilities
4. Terminal emulators and shell enhancements
5. TUI applications and general CLI tools
6. Development tools, audio, security
7. Containers, browsers, communication apps

## Linux Configuration Files

The `linux/config/` directory contains dotfiles and configurations for:
- **fastfetch** - System information display
- **hypr** (Hyprland) - Wayland compositor configuration
- **mpd** - Music Player Daemon
- **nushell** - Modern shell with structured data support (includes nupm package manager)
- **nvim** - Neovim configuration (LazyVim based)
- **waybar** - Wayland status bar with modular JSON configs
- **wofi** - Wayland application launcher

## Windows Setup

The Windows side uses:
- `windows/install/downloadSoftware.bat` - Batch script that downloads 68+ applications using winget or curl
- Downloads are organized into `Downloads/` subdirectories by application
- Falls back to direct downloads if winget fails
- Covers development tools, gaming platforms, productivity software, etc.

## Common Development Tasks

### Adding a New Linux Installation Script

1. Copy `linux/install/template.sh` to the appropriate category directory
2. Update `CMD` and `PKG` variables
3. Add any special installation logic if needed
4. Source the new script in `linux/install/installall.sh` at the appropriate position
5. Document the package in `linux/install/packages-list.txt`

### Testing Installation Scripts

Run individual scripts by sourcing the shared functions first:
```bash
cd linux/install
source shared/functions.sh
./category/installTool.sh
```

Or run the full installation:
```bash
cd linux/install
./installall.sh
```

### Managing Linux Configurations

Configuration files are stored directly in `linux/config/`. Tools like GNU Stow (installed as part of dev-tools) can be used to create symlinks to the appropriate locations in `$HOME/.config/`.

## Notes

- The repository uses French language for documentation and user-facing messages
- Linux scripts target Arch Linux (uses pacman/yay)
- All scripts use `set -e` for safety (exit on error)
- Installation scripts are idempotent (safe to run multiple times)
- Windows script uses UTF-8 encoding (`chcp 65001`)
