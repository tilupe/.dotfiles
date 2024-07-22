#!/bin/bash

# Check if cargo is installed
if ! command -v cargo &>/dev/null; then
  echo "Cargo is not installed. Installing now..."

  # Download and install rustup
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  # Source the cargo env
  source $HOME/.cargo/env

  echo "Cargo has been installed."
else
  echo "Cargo is already installed."
fi

# The file to check
file="$HOME/.local/share/cargo/env"

# Check if the file exists
if [[ ! -f "$file" ]]; then

  mkdir -p ~/.local/share/cargo/
  cat "$HOME/.dotfiles/rust/cargoenv" >"$HOME/.local/share/cargo/env"

fi

cat ~/.dotfiles/rust/cargo_packages | xargs cargo install
