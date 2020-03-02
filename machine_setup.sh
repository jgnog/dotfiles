#!/usr/bin/env bash

# Make sure we are in the homedir
cd ~

# Remove vim-tiny and install full Vim
sudo apt remove --assume-yes vim-tiny
sudo apt update
sudo apt install --assume-yes vim

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
sudo apt-get -y install htop xclip w3m ag ncdu

# Install latex
sudo apt-get -y install texlive-latex-extra texlive-pictures

# Install rclone and launch the interacrive config
sudo apt-get -y install rclone
rclone config

# Install R and RStudio
sudo apt-get -y install r-base gdebi-core
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb
sudo gdebi rstudio-1.2.5033-amd64.deb
rm rstudio-1.2.5033-amd64.deb

# Install Anaconda
sudo apt-get -y install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
bash Anaconda3-2019.10-Linux-x86_64.sh
rm Anaconda3-2019.10-Linux-x86_64.sh

# Install Google Cloud SDK and run the initial configuration
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
gcloud init

# Install chromium
sudo apt-get install chromium-browser

# Install VirtualBox Guest Additions in case this is a VM
sudo apt-get -y install virtualbox-guest-additions-iso
