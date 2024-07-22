export DOTFILES="$HOME/.dotfiles"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GOBIN="$GOPATH"/bin
export ZPLUG_HOME="$XDG_DATA_HOME"/zplug
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export NVM_DIR="$XDG_DATA_HOME"/nvm
export AZURE_CONFIG_DIR="$XDG_DATA_HOME"/azure
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export ZAUTOJUMP="$XDG_DATA_HOME/autojump/autojump.txt "
export TF_CLI_CONFIG_FILE="$XDG_CONFIG_HOME/terraform/.terraformrc"
export POETRY_HOME="$XDG_DATA_HOME/poetry"
# TODO do I still need that? export JIRA_API_TOKEN=$(cat ~/.config/secrets/jira_token)
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export DOTNET_ROOT=/opt/dotnet
export BROWSER="/usr/bin/firefox"
export GPGKEY=

export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/share/nvim/mason/bin/:$XDG_DATA_HOME/zplug/bin/:

# Cargo
if command -v cargo >/dev/null 2>&1; then
  export CARGO_HOME="$XDG_DATA_HOME"/cargo
  export CARGO_TARGET_DIR="$XDG_DATA_HOME/cargo_target"
  export PATH=$PATH:$HOME/.local/share/cargo/bin/

  alias cargi='f() { cargo install "\$1" && echo "\$1" >> ~/.dotfiles/rust/cargo_packages; unset -f f; }; f'
fi

# User configuration
source "$ZPLUG_HOME"/init.zsh

zplug "woefe/wbase.zsh" #Faster startup
zplug "jeffreytse/zsh-vi-mode"
zplug "zsh-users/zsh-completions"
# completion based on history
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
# Then, source plugins and add commands to $PATH
zplug load

# Should be called before compinit
zmodload zsh/complist

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit)

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                     # Insert
bindkey -M menuselect '^xh' accept-and-hold               # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history # Next
bindkey -M menuselect '^xu' undo                          # Undo

_comp_options+=(globdots) # With hidden files
source "$XDG_CONFIG_HOME/zsh/completion.zsh"

## ENVIRONEMENT VARIALES
export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
export EDITOR=nvim

# custom functions
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

if command -v exa >/dev/null 2>&1; then
  alias l='exa --icons --git --no-user'
  alias ll='exa -l --icons --git -a'
  alias lt='exa --tree --level=2 --long --icons --git'
else
  alias l='ls'
  alias ll='ls -la'
fi

if command -v fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --style=plain'
fi

if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='-i --height=50%'
  bindkey -s '^v' "fzf --preview 'bat --color=always {}' \n"
  alias txkill="tmux ls | fzf | awk '{print $1;}' | xargs -n1 tmux kill-session -t"

  eval "$(fzf --zsh)"
fi

# Swap <Esc> and <Capslock> for better vim experience on foreign keyboards
alias swapesc='/usr/bin/setxkbmap -option "caps:swapescape"'
alias v="nvim"
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias oscpvpn="sudo -b openvpn --config ~/projects/offsec/universal.ovpn "
alias cd..="cd .."
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias pbcopy='xsel --input --clipboard'
alias pbpaste='xsel --output --clipboard'
alias ip='ip -c'

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export WORKRC="$HOME/.config/zsh/.workrc.sh"
# Work specific configs
if [[ -f $WORKRC ]]; then
  source $WORKRC
fi

if command -v zellij >/dev/null 2>&1; then
  source "$XDG_CONFIG_HOME/zellij/zellij.zsh"
fi

# Created by `pipx` on 2023-04-18 06:15:55
export PATH="$PATH:/home/$USER/.local/bin"
export PATH="$PATH:/opt/mssql-tools18/bin"

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
