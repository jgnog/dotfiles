# Options

setopt AUTO_CD
setopt AUTO_PUSHD
setopt CDABLE_VARS
setopt CD_SILENT
setopt CORRECT
setopt HASH_LIST_ALL
setopt VI

unsetopt CASE_GLOB

fpath=($ZDOTDIR $fpath)

# Load prompt
autoload -Uz prompt_purification_setup && prompt_purification_setup

# This function calls cheat.sh with the name of a command to get TLDR for that
# command
cheat () {
    curl cheat.sh/$1
}

# Function to create a new note
newnote () {
    # Get the current date in the format yyyymmddhhmm and convert it to hexadecimal
    # and append the md extension. Finally, open it using the environment's editor
    new_filename=$(printf '%x\n' $(date +"%Y%m%d%H%M")).md
    cd $NOTESDIR
    touch $new_filename
    echo "#" >> $new_filename
    date +"%Y-%m-%d %H:%M" >> $new_filename
    $EDITOR $new_filename
}

# Add fzf keybindings
source $HOME/.config/zsh/fzf-key-bindings.zsh
# Add fzf auto-completion
source $HOME/.config/zsh/fzf-completion.zsh

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $ZDOTDIR/aliases ]; then
. $ZDOTDIR/aliases
fi

source $ZDOTDIR/completion.zsh


# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
