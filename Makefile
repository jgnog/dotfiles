install_vim_plugins: install
	vim +PluginInstall +qall

install: update_submodules
	ls -d */ | grep -v oh-my-bash | xargs stow --no-folding 

uninstall:
	ls -d */ | grep -v oh-my-bash | xargs stow -D --no-folding 

update_submodules:
	git submodule update --init --recursive
