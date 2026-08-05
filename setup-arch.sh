#!/usr/bin/env bash
# ==============================================================================
# Arch Linux Development & Environment Setup Script
# ==============================================================================

set -euo pipefail

# ------------------------------------------------------------------------------
# Formatting & Color Definitions
# ------------------------------------------------------------------------------
if [[ -t 1 ]]; then
  BOLD='\033[1m'
  DIM='\033[2m'
  BLUE='\033[34m'
  CYAN='\033[36m'
  GREEN='\033[32m'
  YELLOW='\033[33m'
  RED='\033[31m'
  MAGENTA='\033[35m'
  RESET='\033[0m'
else
  BOLD='' DIM='' BLUE='' CYAN='' GREEN='' YELLOW='' RED='' MAGENTA='' RESET=''
fi

# ------------------------------------------------------------------------------
# Logging & Helper Functions
# ------------------------------------------------------------------------------
log_banner() {
  echo -e "${BOLD}${CYAN}"
  echo "┌──────────────────────────────────────────────────────────┐"
  echo "│         Arch Linux System Setup & Configuration          │"
  echo "└──────────────────────────────────────────────────────────┘"
  echo -e "${RESET}"
}

log_section() {
  echo -e "\n${BOLD}${MAGENTA}==>${RESET} ${BOLD}$1${RESET}"
}

log_info() {
  echo -e " ${BLUE}ℹ${RESET} $1"
}

log_success() {
  echo -e " ${GREEN}✔${RESET} $1"
}

log_warn() {
  echo -e " ${YELLOW}⚠${RESET} $1"
}

log_skip() {
  echo -e " ${DIM}➜ $1 (Already satisfied)${RESET}"
}

log_error() {
  echo -e " ${RED}✖ $1${RESET}" >&2
}

on_error() {
  echo -e "\n${RED}${BOLD}Error occurred on line $1. Setup aborted.${RESET}"
  exit 1
}

trap 'on_error $LINENO' ERR

command_exists() {
  command -v "$1" &>/dev/null
}

# ------------------------------------------------------------------------------
# Main Setup Routine
# ------------------------------------------------------------------------------
log_banner

# Keep-alive sudo authentication
log_info "Requesting sudo authentication..."
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_PID=$!
trap 'kill $SUDO_PID 2>/dev/null || true' EXIT

# 1. Base dependencies & AUR Helper (yay)
log_section "[1/7] Core Dependencies & AUR Helper"

log_info "Ensuring git and base-devel are installed..."
sudo pacman -S --noconfirm --needed git base-devel

if ! command_exists yay; then
  log_info "Installing yay AUR helper..."
  BUILD_DIR=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$BUILD_DIR"
  (cd "$BUILD_DIR" && makepkg -si --noconfirm)
  rm -rf "$BUILD_DIR"
  log_success "yay installed successfully."
else
  log_skip "yay"
fi

# 2. Pacman Packages
log_section "[2/7] Official Pacman Packages"

PACMAN_PKGS=(
  # Desktop & Wayland Ecosystem
  hyprland hyprlock hypridle hyprpaper
  greetd greetd-tuigreet waybar kitty tmux swaync
  qt6-wayland hyprpolkitagent brightnessctl wl-clipboard cliphist
  man-db grim slurp swappy thunar firefox pipewire
  hyprshutdown hyprpicker wireplumber impala openssh bind wget zsh
  unzip bat stow

  # Fonts
  ttf-jetbrains-mono-nerd otf-font-awesome

  # Neovim & Development Helpers
  ripgrep python python-pip luarocks fzf ast-grep fd
  dotnet-sdk

  # Terminal Utilities & TUI Apps
  lazygit lazydocker yazi eza
)

log_info "Installing ${#PACMAN_PKGS[@]} pacman packages..."
sudo pacman -S --noconfirm --needed "${PACMAN_PKGS[@]}"
log_success "Official pacman packages up to date."

# 3. AUR Packages
log_section "[3/7] AUR Packages (yay)"

AUR_PKGS=(
  # Launcher & Application Switcher
  elephant elephant-providerlist elephant-desktopapplications walker
  snappy-switcher

  # Theming
  catppuccin-gtk-theme-mocha papirus-icon-theme nwg-look

  # Desktop Apps
  localsend brave-bin spotify
)

log_info "Installing ${#AUR_PKGS[@]} AUR packages..."
yay -S --noconfirm --needed "${AUR_PKGS[@]}"
log_success "AUR packages up to date."

# 4. Services Configuration
log_section "[4/7] System Services"

if command_exists elephant; then
  log_info "Enabling and starting elephant service..."
  elephant service enable 2>/dev/null || log_warn "elephant service enable returned exit code $?"
  systemctl --user start elephant.service 2>/dev/null || log_warn "Failed to start elephant user service"
  log_success "Elephant service configured."
else
  log_warn "elephant binary not found. Skipping service enablement."
fi

# 5. Shell & Terminal Tools (zoxide, catppuccin tmux)
log_section "[5/7] Shell & Terminal Tools"

# Zoxide
if ! command_exists zoxide; then
  log_info "Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  log_success "zoxide installed."
else
  log_skip "zoxide"
fi

# Catppuccin Tmux Plugin
TMUX_CATPPUCCIN_DIR="$HOME/.config/tmux/plugins/catppuccin/tmux"
if [ ! -d "$TMUX_CATPPUCCIN_DIR" ]; then
  log_info "Installing Catppuccin theme for tmux..."
  mkdir -p "$(dirname "$TMUX_CATPPUCCIN_DIR")"
  git clone -b v2.3.0 https://github.com/catppuccin/tmux.git "$TMUX_CATPPUCCIN_DIR"
  log_success "Catppuccin tmux theme installed."
else
  log_skip "Catppuccin tmux theme"
fi

# 6. Node Environment (NVM & Node LTS & opencode)
log_section "[6/7] Node.js Environment & Tools"

export NVM_DIR="$HOME/.config/nvm"
if [ ! -d "$NVM_DIR" ]; then
  log_info "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
  log_success "NVM installed."
else
  log_skip "NVM"
fi

# Source NVM for current session
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # shellcheck disable=SC1090
  \. "$NVM_DIR/nvm.sh"
fi

if ! command_exists node; then
  log_info "Installing Node.js LTS via NVM..."
  nvm install --lts
  log_success "Node.js LTS installed."
else
  log_skip "Node.js"
fi

if ! command_exists opencode; then
  log_info "Installing opencode-ai globally via npm..."
  npm install -g opencode-ai
  log_success "opencode-ai installed."
else
  log_skip "opencode"
fi

# 7. Summary & Final Notes
log_section "[7/7] Setup Complete!"

echo -e "${GREEN}${BOLD}✔ System setup completed successfully!${RESET}\n"
echo -e "${BOLD}Next steps & reminders:${RESET}"
echo -e " • Add zoxide to your shell configuration if not present:"
echo -e "   ${CYAN}echo 'eval \"\$(zoxide init zsh --cmd cd)\"' >> ~/.zshrc${RESET}"
echo -e " • Restart your shell or log out and back in to apply all changes."
echo

