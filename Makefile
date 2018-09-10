.PHONY: install
	install:
		ln -sf $(pwd)/vimrc $HOME/.vimrc
		ln -sf $(pwd)/path $HOME/.path
		ln -sf $(pwd)/tmux.conf $HOME/.tmux.conf
		ln -sf $(pwd)/zprofile $HOME/.zprofile
		# ln -sf $(pwd)/profile $HOME/.profile
		ln -sf $(pwd)/zshrc $HOME/.zshrc
		ln -sf $(pwd)/extra $HOME/.extra
		ln -sf $(pwd)/exports $HOME/.exports
