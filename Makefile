.PHONY: all
all: yarn go dotfiles vimubuntu zshubuntu ohmyzshubuntu

.PHONY: ubuntu
ubuntu:
	mkdir -p $(HOME)/.config/
	sudo apt-get install -y neovim bat make zsh git
	sudo apt-get install zsh
	zsh --version
# 	chsh -s $(which zsh)
# 	/root/dotfiles/vimrc
	rm -rf $(HOME)/.oh-my-zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$(ZSH_CUSTOM)/themes/spaceship-prompt" --depth=1
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	cd ~
	sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -b ~/
	make dotfiles
	rm -rf $(HOME)/.zplug
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	source $(HOME)/.zshrc

.PHONY: macOS
macOS:
	brew install diff-so-fancy bat
	make git
	make niceaddons

.PHONY: git
git: 
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"		
	git config --global color.ui true
	git config --global color.diff-highlight.oldNormal    "red bold"
	git config --global color.diff-highlight.oldHighlight "red bold 52"
	git config --global color.diff-highlight.newNormal    "green bold"
	git config --global color.diff-highlight.newHighlight "green bold 22"
	git config --global color.diff.meta       "11"
	git config --global color.diff.frag       "magenta bold"
	git config --global color.diff.func       "146 bold"
	git config --global color.diff.commit     "yellow bold"
	git config --global color.diff.old        "red bold"
	git config --global color.diff.new        "green bold"
	git config --global color.diff.whitespace "red reverse"

.PHONY: niceaddons
niceaddons:
	cd ~
	sh -c "$(curl -fsSL https://starship.rs/install.sh)" 
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	source ~/.zshrc
	zplug install
	brew install kalker
	brew install tokei
	brew install exa
	brew install skim
	brew install zellij

# CocInstall coc-tsserver

.PHONY: ohmyzsh
ohmyzsh:
	rm -rf $(HOME)/.oh-my-zsh
	mkdir -p $(HOME)/.oh-my-zsh/themes/
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1

.PHONY: dotfiles
dotfiles:
	cd $(HOME)/dotfiles
	ln -sf $(PWD)/vimrc $(HOME)/.vimrc
	ln -sf $(PWD)/path $(HOME)/.path
	ln -sf $(PWD)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(PWD)/zprofile $(HOME)/.zprofile
	ln -sf $(PWD)/zshrc $(HOME)/.zshrc
	ln -sf $(PWD)/extra $(HOME)/.extra
	ln -sf $(PWD)/exports $(HOME)/.exports
	ln -sf $(PWD)/aliases $(HOME)/.aliases
	mkdir -p $(HOME)/.vim/plugins
	for i in  $(PWD)/vim-snippets/*; do ln -sf $i $(HOME)/.vim/plugins/; done;
#	mkdir -p $(HOME)/.vim/after/ftplugin
#	for i in  $(PWD)/ftplugin/*; do ln -sf $i $(HOME)/.vim/after/ftplugin/; done;
	mkdir -p $(HOME)/.oh-my-zsh/themes/
	ln -sf $(PWD)/starship.toml $(HOME)/.config/

.PHONY: bap_cloud_instance
bap_cloud_instance:
	sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -b ~/
	rm -rf $(HOME)/.oh-my-zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	rm -rf ~/.fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --key-bindings --completion --64 --no-fish
	rm -rf ~/.vim/bundle/Vundle.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	cd $(HOME)/.vim/bundle/youcompleteme && python3 $(HOME)/.vim/bundle/youcompleteme/install.py --clang-completer --rust-completer --ts-completer
	rm -rf ~/.fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --key-bindings --completion --64 --no-fish


.PHONY: ohmyzsh
ohmyzsh:
	rm -rf $(HOME)/.oh-my-zsh
	mkdir -p $(HOME)/.oh-my-zsh/themes/
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

.PHONY: yarn
yarn:
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt-get update && sudo apt-get install yarn

.PHONY: vimubuntu
vimubuntu:
	sudo apt update
	sudo apt upgrade -y
	sudo apt remove vim vim-runtime gvim
	sudo apt install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
		libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
		libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
		python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git \
		cmake
	cd $(HOME)
	sudo rm -rf $(HOME)/vim
	git clone https://github.com/vim/vim.git ~/vim
	cd $(HOME)/vim
	git pull
	cd $(HOME)/vim &&  \
		./configure --with-features=huge \
			--enable-multibyte \
			--enable-rubyinterp=yes \
			--enable-python3interp=yes \
			--enable-perlinterp=yes \
			--with-python3-command=python3.6 \
			--with-python3-config-dir=$(python3-config --configdir) \
			--enable-luainterp=yes \
			--enable-gui=gtk2 \
			--enable-cscope \
			--prefix=/usr/local
	cd $(HOME)/vim && make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
	cd $(HOME)/vim
	cd $(HOME)/vim && sudo make install
	cd $(HOME)/vim && make clean
	cd $(HOME)/vim && make distclean
	sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
	sudo update-alternatives --set editor /usr/local/bin/vim
	sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
	sudo update-alternatives --set vi /usr/local/bin/vim
	rm -rf ~/.fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --key-bindings --completion --64 --no-fish
	rm -rf ~/.vim/bundle/Vundle.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

.PHONY: update
update:
	cd ~/.fzf && git pull && ./install --all --key-bindings --completion --64 --no-fish &&  source ~/.zshrc
