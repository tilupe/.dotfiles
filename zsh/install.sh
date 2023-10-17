#!/bin/bash

sudo apt install zsh &&
	zsh --version &&
	chsh -s "$(which zsh)"

 cargo install starship --locked

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh && zplug install
