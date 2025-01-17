# Options

setopt AUTO_CD
setopt AUTO_PUSHD
setopt CDABLE_VARS
setopt CD_SILENT
setopt CORRECT
setopt HASH_LIST_ALL
setopt VI
setopt share_history

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
    new_filename=n_$(printf '%x\n' $(shuf -i 0-16777215 -n1)).md
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

function agfzf() {
    ag -l "$1" | fzf --preview='batcat {}' --multi | xargs nvim
}

function muxsess() {
    tmux new-session -s "$1"
}

function pomo() {
    tmux new-window -d -n pomo 'nohup play -c2 -n synth "$1":00 pinknoise 60 > /dev/null & termdown "$1"m'
}

function switch_jabra_profile() {
    # Possible profiles are: a2dp_sink (normal playback) and handsfree_head_unit (for calls)
    jabra_card_id="bluez_card.08_C8_C2_63_08_93"
    current_profile=$(pacmd list-cards | grep -A 30 'name: <'$jabra_card_id'>' | grep 'active profile' | awk -F': ' '{print $2}' | tr -d '<>')
    if [ "$current_profile" = "handsfree_head_unit" ]
    then
        echo "Switching to a2dp_sink"
        pacmd set-card-profile $jabra_card_id a2dp_sink
    elif [ "$current_profile" = "a2dp_sink" ]
    then
        echo "Switching to handsfree_head_unit"
        pacmd set-card-profile $jabra_card_id handsfree_head_unit
    else
        echo "Unknown profile"
    fi
}
