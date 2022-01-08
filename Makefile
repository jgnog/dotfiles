SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

.PHONY: install_vim_plugins install uninstall

install_nvim_plugins: nvim/.local/share/nvim/site/autoload/plug.vim install-snaps
	nvim +PluginInstall +qall

nvim/.local/share/nvim/site/autoload/plug.vim:
	curl -fLo nvim/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install: uninstall # Always uninstall before installing
	ls -d */ | grep -v bin | xargs stow --no-folding 

uninstall:
	ls -d */ | grep -v bin | xargs stow -D --no-folding 

add-repositories:
	sudo add-apt-repository ppa:regolith-linux/release

install-python-packages: install-packages
	pip install -r python-packages

install-packages: add-repositories
	cat packages | xargs sudo apt install --yes

install-snaps:
	bin/install_snaps snaps
