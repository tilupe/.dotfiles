#!/usr/bin/sh

if command -v cargo >/dev/null 2>&1; then
  cargo install eza
  cargo install fd-find
  cargo install starship
  cargo install ripgrep
  cargo install zoxide --locked
fi

if command -v brew >/dev/null 2>&1; then
  brew install fzf
  brew install yazi
  brew install antidote
fi

# if command -v apt >/dev/null 2>&1; then
#   sudo apt install
# elif command -v nix >/dev/null 2>&1; then
#
# fi
