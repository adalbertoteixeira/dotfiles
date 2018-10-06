.PHONY: all
	all: dotfiles

install:
		ln -sf $(PWD)/vimrc $(HOME)/.vimrc
		ln -sf $(PWD)/path $(HOME)/.path
		ln -sf $(PWD)/tmux.conf $(HOME)/.tmux.conf
		ln -sf $(PWD)/zprofile $(HOME)/.zprofile
		ln -sf $(PWD)/zshrc $(HOME)/.zshrc
		ln -sf $(PWD)/extra $(HOME)/.extra
		ln -sf $(PWD)/exports $(HOME)/.exports
		ln -sf $(PWD)/aliases $(HOME)/.aliases
		ln -sf $(PWD)/vim-snippets $(HOME)/.vim/plugins/vim-snippets/snippets
		ln -sf $(PWD)/adalbertoteixeira.zsh-theme $(HOME)/.oh-my-zsh/themes/adalbertoteixeira.zsh-theme
		# ln -sf profile $(HOME)/.profile
