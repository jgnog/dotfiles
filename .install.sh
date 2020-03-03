#!/bin/bash
############################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/.dotfilesbk             # old dotfiles backup directory
files="bashrc vimrc vim bash_aliases gitconfig tmux.conf"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
mkdir -p $olddir

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    mv ~/.$file $olddir
    ln -s $dir/$file ~/.$file
done
