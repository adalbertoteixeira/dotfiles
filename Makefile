.PHONY: all
all: yarn go dotfiles vimubuntu zshubuntu ohmyzshubuntu

.PHONY: ubuntu
ubuntu:
	mkdir -p $(HOME)/.config/
	sudo apt-get install -y neovim bat make zsh git unzip autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
	sudo locale-gen pt_PT.UTF-8 && sudo locale-gen en_GB.UTF-8
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
	curl -fsSL https://fnm.vercel.app/install | bash
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
	sudo snap install zellij --classic

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
	rm -rf ~/.fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --key-bindings --completion --64 --no-fish


.PHONY: ohmyzsh
ohmyzsh:
	rm -rf $(HOME)/.oh-my-zsh
	mkdir -p $(HOME)/.oh-my-zsh/themes/
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
