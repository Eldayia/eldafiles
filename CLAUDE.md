# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository (`eldafiles`) centralizes personal configuration files (dotfiles) and installation scripts for both Windows and Linux environments. The primary goal is to automate system setup and maintain consistent configurations across different machines.

## Repository Structure

```
eldafiles/
├── windows/
│   ├── install/          # Windows installation scripts
│   ├── config/           # Windows configuration files (currently empty)
│   └── hyperv/           # Hyper-V virtualization scripts
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

### Software Installation

The Windows side uses:
- `windows/install/downloadSoftware.bat` - Batch script that downloads 68+ applications using winget or curl
- Downloads are organized into `Downloads/` subdirectories by application
- Falls back to direct downloads if winget fails
- Covers development tools, gaming platforms, productivity software, etc.

### Hyper-V Virtualization Scripts

The `windows/hyperv/` directory contains scripts for automated deployment of Linux VMs with GPU acceleration (GPU-PV) on Hyper-V.

**Key Files:**
- `deploy-vm-hyperv.ps1` - Main PowerShell script for VM deployment with GPU-PV support
- `quick-deploy.bat` - Batch launcher that ensures proper UTF-8 encoding and admin privileges
- `setup-hyperv-gpu.ps1` - GPU-PV configuration script
- `start-hyperv.ps1` / `start-hyperv.bat` - VM startup scripts
- `README-DEPLOIEMENT.md` - Deployment documentation (French)
- `README-GPU.md` - GPU-PV configuration guide (French)
- `INDEX.md` - Overview of available scripts

**Features:**
- Automated Hyper-V feature detection and installation
- GPU-PV (GPU Paravirtualization) support for Intel/NVIDIA/AMD GPUs
- Dynamic memory and CPU allocation
- Network switch configuration (NAT/External)
- Generation 2 VM with UEFI firmware
- Secure Boot disabled for Linux compatibility
- UTF-8 encoding for proper French character display
- Idempotent operations (safe to re-run)

**Script Architecture:**

1. **deploy-vm-hyperv.ps1** - Comprehensive deployment script that:
   - Checks Windows edition compatibility (Pro/Enterprise/Education required)
   - Verifies/installs Hyper-V and required Windows features
   - Detects GPU-PV compatible hardware
   - Creates virtual switches (Default Switch or NAT)
   - Configures VM with dynamic VHDX, memory, and CPU
   - Mounts ISO and sets boot order
   - Configures GPU partition adapter with optimal VRAM settings
   - Handles UTF-8 encoding for correct display of accented characters

2. **quick-deploy.bat** - Wrapper that:
   - Sets console to UTF-8 (chcp 65001)
   - Verifies administrator privileges
   - Launches PowerShell with proper encoding configuration

**Important Implementation Notes:**

- **UTF-8 Encoding**: The scripts use UTF-8 with BOM for PowerShell compatibility. The batch file sets `[Console]::OutputEncoding` to ensure French characters display correctly.
- **Error Handling**: Uses proper error handling with `try-catch` blocks and fallback mechanisms (e.g., external switch if internal NAT fails).
- **Int64 Casting**: Memory calculations use explicit `[int64]` casting to avoid Int32 overflow errors with large memory values.
- **Service Dependencies**: Checks that `vmms` (Virtual Machine Management Service) is running before VM operations.
- **Parentheses in Strings**: Avoids parentheses in Write-Host strings to prevent PowerShell command interpretation issues.

**Usage:**
```powershell
# Quick deployment with defaults (8GB RAM, 4 CPUs, 80GB disk)
.\windows\hyperv\quick-deploy.bat

# Custom deployment
powershell.exe -ExecutionPolicy Bypass -File deploy-vm-hyperv.ps1 -VMName "Ubuntu" -Memory 16 -CPUCount 8 -ISOPath "C:\ISOs\ubuntu.iso"
```

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
