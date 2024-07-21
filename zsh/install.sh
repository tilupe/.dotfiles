#!/bin/bash

# Function to install zsh using apt
install_zsh_with_apt() {
  echo "Using apt to install zsh..."
  sudo apt update
  sudo apt install -y zsh
}

# Function to install zsh using nix
install_zsh_with_nix() {
  echo "Using nix to install zsh..."
  nix-env -i zsh
}

# Check if apt is installed
if command -v apt >/dev/null 2>&1; then
  install_zsh_with_apt
elif command -v nix-env >/dev/null 2>&1; then
  install_zsh_with_nix
else
  echo "Neither apt nor nix package manager is installed."
  exit 1
fi

# Verify zsh installation
if command -v zsh >/dev/null 2>&1; then
  echo "zsh has been installed successfully."
  chsh -s "$(which zsh)"
  echo "switched to zsh"

else
  echo "Failed to install zsh."
  exit 1
fi

cargo install starship --locked

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh && zplug install
