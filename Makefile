.PHONY: all
all: yarn go dotfiles vimubuntu zshubuntu ohmyzshubuntu

.PHONY: ubuntu
ubuntu:
	mkdir -p $(HOME)/.config/
	sudo apt-get install -y bat make zsh git unzip autoconf patch build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev ripgrep fzf bat make zsh git patch ripgrep snapdapt fd-find
	sudo locale-gen pt_PT.UTF-8 && sudo locale-gen en_GB.UTF-8
	sudo apt install zsh
	zsh --version
	chsh -s $(which zsh)
	echo $SHELL
	rm -rf $(HOME)/.oh-my-zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	cd ~
	sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -b ~/
	make dotfiles
	rm -rf $(HOME)/.zplug
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	mkdir -p $(HOME)/.ssh
	source $(HOME)/.zshrc
	curl -fsSL https://fnm.vercel.app/install | bash
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	# echo 'export PATH="/root/.local/share/fnm:$PATH"' >> $(HOME)/dotfiles/extra
	# git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
	sudo snap install zellij --classic
	zplug 'wfxr/forgit'
	# fix bat alias
	mkdir -p ~/.local/bin
	ln -s /usr/bin/batcat ~/.local/bin/bat
	sudo snap install --beta nvim --classic 
	echo "Configure neovim to use vim's config: https://neovim.io/doc/user/nvim.html#nvim-from-vim"

.PHONY: rust
rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup component add rust-analyzer

.PHONY: macOS
macOS:
	brew install diff-so-fancy bat fzf fd
	make git
	cd ~
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install --cask alacritty
	brew install diff-so-fancy bat kalker sk zellij neovim zsh fnm starship zsh-syntax-highlighting mosh
	source ~/.zshrc
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
	zplug install
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup component add rust-analyzer
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	brew install --cask font-victor-mono-nerd-font
	make dotfiles

	

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


.PHONY: dotfiles
dotfiles:
	# ln -sf $(PWD)/vimrc $(HOME)/.vimrc
	ln -sf $(PWD)/path $(HOME)/.path
	ln -sf $(PWD)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(PWD)/zprofile $(HOME)/.zprofile
	ln -sf $(PWD)/zshrc $(HOME)/.zshrc
	ln -sf $(PWD)/extra $(HOME)/.extra
	ln -sf $(PWD)/exports $(HOME)/.exports
	ln -sf $(PWD)/aliases $(HOME)/.aliases
	mkdir -p $(HOME)/.oh-my-zsh/themes/
	mkdir -p ~/.config/zellij
	ln -sf $(PWD)/starship.toml $(HOME)/.config/
	mkdir -p $(HOME)/zellij/
	ln -sf $(PWD)/zellij/config.kdl $(HOME)/.config/zellij/config.kdl
	mkdir -p $(HOME)/.vim/
	mkdir -p $(HOME)/.vim/plugins
	mkdir -p $(HOME)/.nvim/plugins
	mkdir -p $(HOME)/.config/alacritty
	touch $(HOME)/.config/alacritty/alacritty.toml
	echo "import = [\"$HOME/dev/dotfiles/alacritty.toml\"]" >> $(HOME)/.config/alacritty/alacritty.toml
	ln -sf $(PWD)/zshrc $(HOME)/.zshrc
	# for i in  $(PWD)/ftplugin/*; do ln -sf $i $(HOME)/.vim/ftplugin/; done;


	# for i in  $(PWD)/ftplugin/*; do ln -sf $i $(HOME)/.vim/ftplugin/; done;
	# mkdir -p $(HOME)/.vim/lua
	#for i in  $(PWD)/lua/*; do ln -sf $i $(HOME)/.vim/lua/; done;
	ln -sf $(PWD)/nvim/init.lua $(HOME)/.config/nvim/
	ln -sf $(PWD)/nvim/coc-settings.json $(HOME)/.config/nvim/
	ln -sf $(PWD)/nvim/init.lua $(HOME)/.config/nvim/
	mkdir ~/.config/nvim/lua/config
	mkdir -p $(HOME)/.config/lua/config/plugins/
	ln -sf $(PWD)/nvim/lua/config/lazy.lua $HOME/.config/nvim/lua/config/lazy.lua
	mkdir -p $(HOME)/.config/nvim/ftplugin/
	for i in  $(PWD)/ftplugin/*; do ln -sf $i $(HOME)/.config/nvim/ftplugin/; done;
	mkdir -p $(HOME)/.config/nvim/after/
	for i in  $(PWD)/ftplugin/*; do ln -sf $i $(HOME)/.config/nvim/after/; done;


.PHONY: dotfiles-ubuntu
dotfiles-ubuntu:
	# ln -sf $(PWD)/vimrc $(HOME)/.vimrc
	ln -sf $(PWD)/path $(HOME)/.path
	ln -sf $(PWD)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(PWD)/zprofile $(HOME)/.zprofile
	ln -sf $(PWD)/zshrc $(HOME)/.zshrc
	ln -sf $(PWD)/extra $(HOME)/.extra
	ln -sf $(PWD)/exports $(HOME)/.exports
	ln -sf $(PWD)/aliases $(HOME)/.aliases
	mkdir -p $(HOME)/.oh-my-zsh/themes/
	ln -sf $(PWD)/starship.toml $(HOME)/.config/
	mkdir -p $(HOME)/.config/zellij/
	ln -sf $(PWD)/zellij/config.kdl $(HOME)/.config/zellij/config.kdl
	mkdir -p $(HOME)/.vim/plugins
	mkdir -p $(HOME)/.nvim/plugins
#	mkdir -p $(HOME)/.vim/after/ftplugin
#	for i in  $(PWD)/ftplugin/*; do ln -sf $i $(HOME)/.vim/after/ftplugin/; done;
	mkdir -p ~/.config/nvim/ftplugin
	for i in  $(PWD)/ftplugin/*; do ln -sf $i $(HOME)/.config/nvim/ftplugin/; done;
	mkdir -p $(HOME)/.nvim/lua
	for i in  $(PWD)/lua/*; do ln -sf $i $(HOME)/.config/nvim/lua/; done;
	ln -sf $(PWD)/nvim/init.lua $(HOME)/.config/nvim/
	ln -sf $(PWD)/nvim/coc-settings.json $(HOME)/.config/nvim/
	ln -sf $(PWD)/nvim/init.lua $(HOME)/.config/nvim/
	mkdir ~/.config/nvim/lua/config
	mkdir -p $(HOME)/.config/lua/config/plugins/
	ln -sf $(PWD)/nvim/lua/config/lazy.lua $HOME/.config/nvim/lua/config/lazy.lua
	mkdir -p $(HOME)/.config/nvim/ftplugin/
	for i in  $(PWD)/ftplugin/*; do ln -sf $i $(HOME)/.config/nvim/ftplugin/; done;
	mkdir -p $(HOME)/.config/nvim/after/
	for i in  $(PWD)/ftplugin/*; do ln -sf $i $(HOME)/.config/nvim/after/; done;

.PHONY: ohmyzsh
ohmyzsh:
	rm -rf $(HOME)/.oh-my-zsh
	mkdir -p $(HOME)/.oh-my-zsh/themes/
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
