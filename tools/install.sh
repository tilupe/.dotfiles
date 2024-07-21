#!/usr/bin/sh

if command -v cargo >/dev/null 2>&1; then
  cargo install exa
  cargo install fd-find
  cargo install starship
fi

if command -v brew >/dev/null 2>&1; then
  brew install fzf
fi

if command -v apt >/dev/null 2>&1; then

elif command -v nix >/dev/null 2>&1; then

fi
