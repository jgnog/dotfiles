install_vim_plugins: install
	vim +PluginInstall +qall

install: update_submodules
	ls -d */ | grep -v do-not-stow | xargs stow --no-folding 

uninstall:
	ls -d */ | grep -v do-not-stow | xargs stow -D --no-folding 

update_submodules:
	git submodule update --init --recursive
