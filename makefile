# Creates symbolic links.
link:
	# general
	ln -sf `pwd`/git/gitconfig ~/.gitconfig
	ln -sf `pwd`/bash_profile ~/.bash_profile
	ln -sf `pwd`/bashrc ~/.bashrc

	# vim & coc
	ln -sf `pwd`/vim/vimrc ~/.vimrc
	ln -sf `pwd`/zathura/zathurarc ~/.config/zathura/zathurarc

	# zsh + theme
	ln -sf `pwd`/zsh/zshrc ~/.zshrc
	ln -sf `pwd`/zsh/themes/theunraveler.zsh-theme ~/.oh-my-zsh/themes/theunraveler.zsh-theme

