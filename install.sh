#!/bin/bash

if command -v apt &> /dev/null; then
    echo "apt package manager is available on this system."
else
    echo "apt package manager is not available on this system."
fi

mkdir -p ~/.local/share/cargo/
cat ~/.dotfiles/rust/cargoenv > ~/.local/share/cargo/env
