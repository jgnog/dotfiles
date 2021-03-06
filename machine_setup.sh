#!/usr/bin/env bash
# Enable bash strict mode
set -euo pipefail
IFS=$'\n\t'

# Make sure we are in the homedir
cd ~

# Remove vim-tiny and install full Vim
sudo apt remove --assume-yes vim-tiny
sudo apt update && sudo apt upgrade
sudo apt install --assume-yes $(cat packages_to_install)

# Generate RSA ssh key pair,add it to ssh-agent and to GitHub
 function git_upload_ssh_key () {
     read -p "Enter github email : " email
     echo "Using email $email"
     if [ ! -f ~/.ssh/id_rsa ]; then
         ssh-keygen -t rsa -b 4096 -C "$email"
 	eval `ssh-agent`
         ssh-add ~/.ssh/id_rsa
     fi
     pub=`cat ~/.ssh/id_rsa.pub`
     read -p "Enter github username: " githubuser
     echo "Using username $githubuser"
     read -s -p "Enter github password for user $githubuser: " githubpass
     curl -u "$githubuser:$githubpass" -X POST -d "{\"title\":\"`hostname`\",\"key\":\"$pub\"}" https://api.github.com/user/keys
 }
 
 git_upload_ssh_key
 
# Clone dotfiles repo and install dotfiles
git clone git@github.com:jgnog/dotfiles.git ~/dotfiles
# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
# Install Tmux Plugin Manager
# Use prefix + I to install the plugins once you are in a tmux session
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Install base16-shell
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# Install dotfiles
cd ~/dotfiles
make
cd ~

# Install Anaconda
sudo apt-get -y install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
bash Anaconda3-2019.10-Linux-x86_64.sh
rm Anaconda3-2019.10-Linux-x86_64.sh
