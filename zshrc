export ZSH="$HOME/.oh-my-zsh"

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
# AUTOCOMPLETION

# # initialize autocompletion
# autoload -U compinit && compinit
#
# # history setup
# setopt SHARE_HISTORY
# HISTFILE=$HOME/.zhistory
# SAVEHIST=1000
# HISTSIZE=999
# setopt HIST_EXPIRE_DUPS_FIRST
# autocompletion using arrow keys (based on history)
# bindkey '\e[A' history-search-backward
# bindkey '\e[B' history-search-forward

# bindkey '^H' backward-kill-word
# bindkey '5~' kill-word
# WORDCHARS='~!#$%^&*(){}[]<>?.+;-'
# bindkey $'\E[1;5D' vi-backward-blank-word
# bindkey $'\E[1;5C' vi-forward-blank-word

# How to delete from current position to the beginning of the line
# Use Ctrl+U
# unix-line-discard (C-u) Kill backward from point to the beginning of the line. The killed text is saved on the kill-ring.
# In case you use zsh, you should add this line: bindkey \^U backward-kill-line to your .zshrc. See this. 

# GENERAL

# (bonus: Disable sound errors in Zsh)

# never beep
# setopt NO_BEEP

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git git-extras npm yarn zsh-syntax-highlighting ssh-agent rust poetry)
# brew zsh-autosuggestions rails jira vagrant ruby rake osx zsh-nvm 
# zstyle :omz:plugins:ssh-agent identities bitbucket_ben
# plugins=(zsh-autosuggestions)
 
source $ZSH/oh-my-zsh.sh
# source $ZSH/oh-my-zsh.sh
# source $ZSH
# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR=$(which nvim)
fi

export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh
zplug "wfxr/forgit"
zplug load



if [  "$(which frum)" = "frum not found" ]; then 
  echo "No frum installed";
else
  eval "$(frum init)";
fi

# if command -v rbenv > /dev/null 2>&1; then eval "$(rbenv init - zsh)"; fi
# eval "$(~/.rbenv/bin/rbenv init - zsh)"
fpath+=${ZDOTDIR:-~}/.zsh_functions
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -n $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi


# export PATH="/opt/homebrew/sbin:$PATH"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # fnm
  FNM_PATH="/root/.local/share/fnm"
  if [ -d "$FNM_PATH" ]; then
    export PATH="/root/.local/share/fnm:$PATH"
    eval "`fnm env`"
  fi
  SNAP_PATH="/snap/bin"
  if [ -n "$SNAP_PATH" ]; then
    export PATH=$PATH:/snap/bin
  fi
  if [ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi

  eval "$(starship init zsh)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
  if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi

  # if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  #   source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  # fi
  # fnm macOs
  export FNM_PATH=$(which fnm)
  if [ -n "$FNM_PATH" ]; then
    export PATH=$FNM_PATH:$PATH
    eval "`fnm env`"
    eval "$(fnm env --use-on-cd --shell zsh)"
  fi
  eval "$(starship init zsh)"
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
else
        # Unknown.
fi

