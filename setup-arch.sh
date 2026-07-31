#!/bin/bash
set -e

command_exists() {
  command -v "$1" &>/dev/null
}

sudo pacman -S --noconfirm --needed git base-devel

if ! command_exists yay; then
  if [ -d yay-install ]; then
    rm -rf yay-install
  fi
  git clone https://aur.archlinux.org/yay.git yay-install
  pushd yay-install
  makepkg -si
  if [ -d yay-install ]; then
    rm -rf yay-install
  fi
else
  echo "yay already installed"
fi

# base
sudo pacman --noconfirm --needed -S \
  hyprland \
  hyprlock \
  hypridle \
  hyprpaper \
  greetd greetd-tuigreet \
  waybar \
  kitty \
  tmux \
  swaync \
  qt6-wayland \
  hyprpolkitagent \
  brightnessctl \
  wl-clipboard \
  cliphist \
  man-db \
  grim \
  slurp \
  swappy \
  thunar \
  firefox \
  pipewire \
  hyprshutdown \
  hyprpicker \
  wireplumber \
  impala \
  openssh \
  bind \
  wget \
  zsh \
  ttf-jetbrains-mono-nerd \
  otf-font-awesome \
  unzip \
  bat \
  stow

# walker application launcher
yay -S --noconfirm --needed \
  elephant \
  elephant-providerlist \
  elephant-desktopapplications \
  walker
# yay -S --noconfirm --needed rofi-wayland
elephant service enable
systemctl --user start elephant.service

yay -S --noconfirm --needed \
  snappy-switcher

# themeing
yay -S --noconfirm --needed \
  catppuccin-gtk-theme-mocha \
  papirus-icon-theme \
  nwg-look
# catppuccin-icon-theme

# useful tools
if ! command_exists zoxide; then
  echo "Installing zoxide"
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

  echo 'Add eval "$(zoxide init zsh --cmd cd)" to your .zshrc file'

else
  echo "zoxide already installed"
fi

yay -S --noconfirm --needed \
  localsend
# dev
NVM_DIR="$HOME/.config/nvm"
if [ ! -d "$NVM_DIR" ]; then
  echo "Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
else
  echo "nvm already installed"
fi

if ! command_exists node; then
  nvm install --lts
else
  echo "node already installed"
fi

# nvim
sudo pacman -S --noconfirm --needed \
  ripgrep \
  python \
  python-pip \
  luarocks \
  fzf \
  ast-grep \
  fd

if ! [ -d ~/.config/tmux/plugins/catppuccin ]; then
  mkdir -p ~/.config/tmux/plugins/catppuccin
  git clone -b v2.3.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi

if ! command_exists opencode; then
  npm i -g opencode-ai
else
  echo "opencode already installed"
fi

sudo pacman -S --noconfirm --needed \
  dotnet-sdk

#utils
sudo pacman -S --noconfirm --needed \
  lazygit \
  lazydocker \
  yazi \
  eza

# apps

yay -S --noconfirm --needed \
  brave-bin
