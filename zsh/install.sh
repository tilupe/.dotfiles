#!/bin/bash

sudo apt install zsh &&
zsh --version &&
chsh -s "$(which zsh)"

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
