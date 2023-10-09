#!/bin/bash

sudo apt install tmux
sudo apt install tmuxp

scrip_path="$HOME/.dotfiles/scripts"

chmod +x "$scrip_path/tmux/tmux-sessionizer.sh"
sudo ln -s "$scrip_path/tmux/tmux-sessionizer.sh /usr/local/bin/tmux-sessionizer"
