#!/bin/bash

sudo apt install stow
sudo apt install ripgrep
sudo apt install fzf
sudo apt install fd-find # find replacement
sudo apt install duf     # df replacement
sudo apt install bat &&  # cat replacement
	sudo ln -s /usr/bin/batcat /usr/local/bin/bat
sudo apt install neofetch
sudo apt-get install python3-pip

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
