#!/bin/bash

# Check if cargo is installed
if ! command -v cargo &> /dev/null
then
    echo "Cargo is not installed. Installing now..."
    
    # Download and install rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    
    # Source the cargo env
    source $HOME/.cargo/env
    
    echo "Cargo has been installed."
else
    echo "Cargo is already installed."
fi


cat ~/.dotfiles/rust/cargo_packages | xargs cargo install
