#!/bin/bash
PWD=$(pwd)


wget https://github.com/wez/wezterm/releases/download/20221119-145034-49b9839f/wezterm-20221119-145034-49b9839f.Ubuntu22.04.deb 
sudo apt install -y $PWD/wezterm-20221119-145034-49b9839f.Ubuntu22.04.deb 

rm $PWD/wezterm-20221119-145034-49b9839f.Ubuntu22.04.deb 

cd ~/.dotfiles &&
stow --adopt -v ./wezterm/

cd $PWD
