export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
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
export JIRA_API_TOKEN=$(cat ~/.config/secrets/jira_token)
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export DOTNET_ROOT=/opt/dotnet
export BROWSER="/usr/bin/firefox"
export GPGKEY=
export CARGO_TARGET_DIR="$XDG_DATA_HOME/cargo_target"
export ZELLIJ_AUTO_ATTACH=0

export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/share/nvim/mason/bin/:$HOME/.local/share/cargo/bin/:$XDG_DATA_HOME/zplug/bin/:

# fuzzy finder
export FZF_DEFAULT_OPTS='-i --height=50%'

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# User configuration
source "$ZPLUG_HOME"/init.zsh

zplug "woefe/wbase.zsh"
zplug "woefe/git-prompt.zsh", use:"{git-prompt.zsh,examples/wprompt.zsh}"
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*"
zplug "sharkdp/fd", from:gh-r, as:command, rename-to:fd, use:"*x86_64-unknown-linux-gnu.tar.gz"
zplug "junegunn/fzf"
zplug "jeffreytse/zsh-vi-mode"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
# Then, source plugins and add commands to $PATH
zplug load

## ENVIRONEMENT VARIALES
export MonolithRoot=/home/$USER/Development/devinite/
export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# custom functions
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias l='exa --icons --git --no-user'
alias ll='exa -l --icons --git -a'
alias lt='exa --tree --level=2 --long --icons --git'
alias swapesc='/usr/bin/setxkbmap -option "caps:swapescape"'
alias kdev='kubectl config use-context $(kubectl config get-contexts -o name | grep core-dev)'
alias ktest='kubectl config use-context $(kubectl config get-contexts -o name | grep core-test)'
alias kprod='kubectl config use-context $(kubectl config get-contexts -o name | grep core-prod)'
alias k9='k9s -n dg-sales'
alias v="nvim"
alias ze="zellij"
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias oscpvpn="sudo -b openvpn --config ~/projects/offsec/universal.ovpn "
alias sales="cd $HOME/Development/Dg.Sales/ && zj attach sales || zj -s sales"
alias config="cd $HOME/.dotfiles/neovim/.config/nvim/ && zj attach config || zj -s config"
alias cd..="cd .."
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias txkill="tmux ls | fzf | awk '{print $1;}' | xargs -n1 tmux kill-session -t"
alias cat='bat --style=plain'
alias fd='fdfind'
alias pbcopy='xsel --input --clipboard'
alias pbpaste='xsel --output --clipboard'
alias ip='ip -c'
bindkey -s '^f' "zellij-sessionizer /home/$USER \n"


[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Created by `pipx` on 2023-04-18 06:15:55
export PATH="$PATH:/home/$USER/.local/bin"
export PATH="$PATH:/opt/mssql-tools18/bin"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(fzf --zsh)"
