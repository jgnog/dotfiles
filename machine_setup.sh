#!/usr/bin/env bash

# Make sure we are in the homedir
cd ~

# Install git
sudo apt-get -y install git

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

# Install make and run it on dotfiles
sudo apt-get -y install make
cd ~/dotfiles
make
cd ~

# Install tmux
sudo apt-get -y install tmux

# Install some utilities
sudo apt-get -y install htop xclip

# Install latex
sudo apt-get -y install texlive-latex-extra texlive-pictures

#r
#anaconda
#gcloud
#google drive (rclone)
#dropbox (rclone)
#chrome
