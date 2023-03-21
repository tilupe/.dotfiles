#!/bin/bash

pwd=$(pwd)
sudo apt install zsh &&
zsh --version &&
chsh -s "$(which zsh)"


mkdir -p ~/.zsh
cd ~/.zsh || exit

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

sd 'plugins=\(.*\)' 'plugins=(git docker)'

cd "$pwd" || exit
