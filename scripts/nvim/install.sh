#!/bin/bash
PWD=$(pwd)
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
sudo chmod u+x $PWD/nvim.appimage

sudo mv $PWD/nvim.appimage /usr/bin/nvim
sudo rm /usr/bin/vi
sudo ln -s /usr/bin/nvim /usr/bin/vi

