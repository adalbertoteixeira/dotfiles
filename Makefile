.PHONY: all
all: nvm go dotfiles

.PHONY: go
go:
	cd $(HOME)
	export VERSION=1.11.1
	export OS=linux
	export ARCH=amd64 
	curl https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz -o go$VERSION.$OS-$ARCH.tar.gz
	tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz

.PHONY: nvm
nvm:
	mkdir $(HOME)/.nvm
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
	source $(HOME)/.zprofile
	nvm install node
	nvm use node

.PHONY: vimubuntu
vimubuntu:
	sudo apt update
	sudo apt upgrade
	sudo apt remove vim vim-runtime gvim
	sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
		libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
		libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
		python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git \
		cmake
	cd $(HOME)
	git clone https://github.com/vim/vim.git ~/vim
	cd $(HOME)/vim
	git pull
	./configure --with-features=huge \
		--enable-multibyte \
		--enable-rubyinterp=yes \
		--enable-pythoninterp=yes \
		--enable-python3interp=yes \
		--with-python3-config-dir=/usr/lib/python3.5/config \
		--enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-gui=gtk2 \
		--enable-cscope \
		--prefix=/usr/local
	make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
	cd $(HOME)/vim
	sudo make install
	make clean
	make distclean
	sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
	sudo update-alternatives --set editor /usr/local/bin/vim
	sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
	sudo update-alternatives --set vi /usr/local/bin/vim
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --key-bindings --completion --64 --no-fish &&	source ~/.zshrc
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	cd $(HOME)/.vim/bundle/youcompleteme
	python3 ./install.py --clang-completer --rust-completer --js-completer --go-completer

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

.PHONY: update
update:
	cd ~/.fzf && git pull && ./install --all --key-bindings --completion --64 --no-fish &&  source ~/.zshrc
