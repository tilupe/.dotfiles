#!/bin/bash

if command -v zellij >/dev/null 2>&1; then
  export ZELLIJ_AUTO_ATTACH=0
  alias ze="zellij"
  bindkey -s '^f' "zellij-sessionizer /home/$USER \n"
fi
