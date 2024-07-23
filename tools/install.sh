#!/usr/bin/sh

if command -v cargo >/dev/null 2>&1; then
  cargo install eza
  cargo install fd-find
  cargo install starship
  cargo install ripgrep
fi

if command -v brew >/dev/null 2>&1; then
  brew install fzf
  brew install yazi
fi

if command -v apt >/dev/null 2>&1; then

elif command -v nix >/dev/null 2>&1; then

fi
