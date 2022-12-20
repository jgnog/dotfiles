# All the Python versions
sudo add-apt-repository --yes ppa:deadsnakes/ppa

# Neovim
sudo add-apt-repository --yes ppa:neovim-ppa/unstable

# NodeJS
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

# Docker
# From this guide - https://docs.docker.com/engine/install/ubuntu/
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
