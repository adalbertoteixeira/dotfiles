.PHONY: all
all: dotfiles

.PHONY: vimubuntu
vimubuntu:
	sudo apt update
	sudo apt upgrade
	sudo apt build-dep vim
	git clone https://github.com/vim/vim.git ~/vim
	cd ~/vim
	git pull
	./configure --with-features=huge
	make
	sudo make install
	make clean
	make distclean

.PHONY: zshubuntu
zshubuntu:
	sudo apt update
	sudo apt install zsh
	zsh --version
	chsh -s $(which zsh)

.PHONY: ohmyzshubuntu
ohmyzshubuntu:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

.PHONY: dotfiles
dotfiles:
	ln -sf $(PWD)/vimrc $(HOME)/.vimrc
	ln -sf $(PWD)/path $(HOME)/.path
	ln -sf $(PWD)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(PWD)/zprofile $(HOME)/.zprofile
	ln -sf $(PWD)/zshrc $(HOME)/.zshrc
	ln -sf $(PWD)/extra $(HOME)/.extra
	ln -sf $(PWD)/exports $(HOME)/.exports
	ln -sf $(PWD)/aliases $(HOME)/.aliases
	mkdir -p $(HOME)/.vim/plugins/vim-snippets
	ln -sf $(PWD)/vim-snippets $(HOME)/.vim/plugins/vim-snippets/snippets
	mkdir -p $(HOME)/.oh-my-zsh/themes/
	ln -sf $(PWD)/adalbertoteixeira.zsh-theme $(HOME)/.oh-my-zsh/themes/adalbertoteixeira.zsh-theme
	# ln -sf profile $(HOME)/.profile
