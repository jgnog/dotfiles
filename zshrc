# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

# Example aliases
alias zshconfig="cd ~/dotfiles && vim zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git debian cp extract colorize autojump)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH

export EDITOR='vim'

# Use the zmv renaming tool
autoload -U zmv

#=====================#
#                     #
#      Aliases        #
#                     #
#=====================#

# Normal aliases
# ==============
alias subs='subliminal -l pt -l pt-br -l en --'
alias rm='rm -I'
alias vimconfig='cd ~/dotfiles && vim vimrc'

# Pomodoro aliases
alias pomowork='sh ~/scripts/timer.sh 25 "Pomodoro" "25 minutes left!" "Take a break!"'
alias pomobreak='sh ~/scripts/timer.sh 5 "Pomodoro short break" "5 minutes left!" "Get to work!"'
alias pomolongbreak='sh ~/scripts/timer.sh 15 "Pomodoro long break" "15 minutes left!" "Get to work!"'

alias latexmake='latexmk -pdf -pvc'
alias latexclean='latexmk -C'

# Global aliases
# ==============
alias -g Gp='| grep -i'

# Suffix aliases
# ==============
alias -s tex=vim
alias -s pdf=evince

# 'Function' aliases
snippets () { cat ~/.vim/bundle/vim-snippets/snippets/$1.snippets }
cheat () {evince documents/cheatsheets/$1.pdf}
