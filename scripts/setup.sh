#!/bin/bash

sudo apt install stow -y
sudo apt install ripgrep -y
sudo apt install fzf -y
sudo apt install fd-find -y # find replacement
sudo apt install duf -y     # df replacement
sudo apt install bat -y &&  # cat replacement
	sudo ln -s /usr/bin/batcat /usr/local/bin/bat
sudo apt install neofetch -y
sudo apt install python3-pip -y
sudo apt install python3-virtualenv -y

# install rust and cargo
curl https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/bin"
cargo install sd      # sed replacement
cargo install du-dust # du replacement
cargo install exa

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install dog # dig replacemnet

# install xh
# xh is a friendly and fast tool for sending HTTP requests. It reimplements as much as possible of HTTPie's excellent design, with a focus on improved performance.
curl -sfL https://raw.githubusercontent.com/ducaale/xh/master/install.sh | sh
