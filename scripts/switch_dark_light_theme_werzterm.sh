#!/bin/bash

lua_file="$HOME/.dotfiles/wezterm/.config/wezterm/wezterm.lua"

if grep "Gruvbox Dark" "$lua_file" >/dev/null; then
	sed -i -e 's/Gruvbox Dark/Tokyo Night Day/g' $lua_file
else
	sed -i -e 's/Tokyo Night Day/Gruvbox Dark/g' $lua_file
fi
