#!/bin/bash

# tmux-sessionizer
tmux_sessionizer_path="$HOME/.dotfiles/scripts/tmux/tmux-sessionizer.sh"
if ! command -v tmux-sessionizer &>/dev/null; then
	chmod +x "$tmux_sessionizer_path"
	ln -s "$tmux_sessionizer_path" ~/.local/bin/tmux-sessionizer
fi
