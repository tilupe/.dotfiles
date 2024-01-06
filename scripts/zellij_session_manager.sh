#!/usr/bin/env bash

# Get the list using zellij ls -n | awk '{print $1}' and pass it to fzf

#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Development/ ~/.dotfiles ~ ~/notes ~/projects -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

active_sessions=$(zellij ls -n | awk '{print $1}')
selected_name=$(basename "$selected" | tr . _)

if [[ $active_sessions =~ $selected_name ]]; then
    echo "$selected_name 1" 
    #zellij a "$selected_name"
else
    echo "$selected_name 2" 
    #zellij a --create "$selected"
fi
