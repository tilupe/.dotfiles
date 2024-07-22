#!/bin/bash

if command -v apt &>/dev/null; then
  echo "apt package manager is available on this system."
else
  echo "apt package manager is not available on this system."
  exit 1
fi

pwd=$(pwd)

chmod +x $pwd/tools/install.sh
$pwd/tools/install.sh

mkdir -p ~/.local/share/cargo/
cat ~/.dotfiles/rust/cargoenv > ~/.local/share/cargo/env
