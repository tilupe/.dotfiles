#!/bin/sh

sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
chmod +x ~/.config/tmux/tmux-sessionizer
