install_vim_plugins: install vim-plug_installed.tmp
	vim +PluginInstall +qall

vim-plug_installed.tmp:
	sh install_vim_plug.sh	

install:
	ls -d */ | grep -v do-not-stow | xargs stow --no-folding 

uninstall:
	ls -d */ | grep -v do-not-stow | xargs stow -D --no-folding 
