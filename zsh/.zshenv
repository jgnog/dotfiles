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

PATH="$HOME/bin:$HOME/.local/bin:$HOME/.poetry/bin:$HOME/.cargo/bin:$PATH"
PATH="$PATH:/opt/nvim-linux64/bin"
export PATH

# Note-taking system
export NOTESDIR=$HOME"/my-notes/"

export LEDGER_FILE=~/personal-finances/ribnog.ledger

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

PRIVATE_ENV_FILE="$HOME/.config/zsh/private_zshenv"
if [ -f $PRIVATE_ENV_FILE ]; then
    source "$HOME/.config/zsh/private_zshenv"
fi

export DEFAULT_MODEL=gpt-4o-mini
