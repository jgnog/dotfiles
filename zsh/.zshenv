export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file
export HISTCONTROL=ignoreboth

export EDITOR="nvim"
export VISUAL="nvim"

PATH="$HOME/bin:$HOME/.local/bin:$HOME/.config/local/bin:$HOME/.poetry/bin:$HOME/.cargo/bin:$PATH"
PATH="$PATH:/opt/nvim-linux64/bin"
PATH="$HOME/.opencode/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="$PATH:/opt/nvim/bin"
export PATH

# Note-taking system
export NOTESDIR=$HOME"/my-notes/"

export LEDGER_FILE=~/personal-finances/ribnog.ledger

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:/usr/sbin:$PATH"

PRIVATE_ENV_FILE="$HOME/.config/zsh/private_zshenv"
if [ -f $PRIVATE_ENV_FILE ]; then
    source "$HOME/.config/zsh/private_zshenv"
fi

export DEFAULT_MODEL=gpt-4o-mini

# MacOS
# Enable color on Mac terminal
export CLICOLOR=1

# Quick access to config files
export NVIMCONFIG="$HOME/.config/nvim/init.lua"
export TMUXCONFIG="$HOME/.tmux.conf"
export ALIASESCONFIG="$HOME/.config/zsh/aliases"
export ZSHCONFIG="$HOME/.config/zsh/.zshrc"
