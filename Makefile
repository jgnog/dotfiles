SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

.PHONY: install_vim_plugins install uninstall

install_nvim_plugins: nvim/.config/nvim/autoload/plug.vim install-snaps
	nvim +PluginInstall +qall

nvim/.config/nvim/autoload/plug.vim:
	curl -fLo nvim/.config/nvim/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install: uninstall # Always uninstall before installing
	ls -d */ | grep -v bin | xargs stow --no-folding  --ignore=README.*

uninstall:
	ls -d */ | grep -v bin | xargs stow -D --no-folding 

install-python-packages: install-packages
	pip install -r python-packages

install-packages: add-repositories
	cat packages | xargs sudo apt install --yes

add-repositories:
	bin/add_repositories.sh && sudo apt update

add-flathub: install-packages
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

install_flatpaks: install-packages add-flathub
	cat flatpaks | xargs sudo flatpak install --assumeyes flathub 

install-snaps:
	bin/install_snaps snaps
