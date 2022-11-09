SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

.PHONY: install_vim_plugins install uninstall

install_nvim_plugins: dotfiles/nvim/.config/nvim/autoload/plug.vim install-snaps
	nvim +PluginInstall +qall

dotfiles/nvim/.config/nvim/autoload/plug.vim:
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

stow-apps:
	cd apps && ls | xargs sudo stow --no-folding -R -t /usr/local

stow-dotfiles:
	cd dotfiles && ls | xargs sudo stow --no-folding -R -t ${HOME}

install-python-packages: install-apt-packages
	pip install --user -r packages/pip

install-apt-packages: add-repositories packages/apt
	cat packages/apt | xargs sudo apt install --yes

install-packages: install-apt-packages install-python-packages install_flatpaks install-snaps

add-repositories: bin/add_repositories.sh
	bin/add_repositories.sh && sudo apt update

add-flathub: install-apt-packages
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

install_flatpaks: install-apt-packages add-flathub
	cat packages/flatpak | xargs sudo flatpak install --assumeyes flathub 

install-snaps: install-apt-packages
	bin/install_snaps packages/snap

install-cargo-packages: install-apt-packages
	cat packages/cargo | xargs cargo install

populate-apt-packges:
	apt-mark showmanual > packages/apt
