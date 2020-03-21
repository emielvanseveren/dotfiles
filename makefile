# Creates symbolic links.
link:
	# vim & coc
	ln -sf `pwd`/vim/vimrc ~/.vimrc
	ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf
	# zsh + theme
	ln -sf `pwd`/zsh/zshrc ~/.zshrc
	ln -sf `pwd`/zsh/themes/theunraveler.zsh-theme ~/.oh-my-zsh/themes/theunraveler.zsh-theme
	ln -sf `pwd`/git/gitconfig ~/.gitconfig
	ln -sf `pwd`/bash_profile ~/.bash_profile
