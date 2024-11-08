# AUTOCOMPLETION

# initialize autocompletion
autoload -U compinit && compinit

# history setup
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

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
# plugins=(git git-extras npm yarn zsh-syntax-highlighting ssh-agent rust)
# brew zsh-autosuggestions rails jira vagrant ruby rake osx zsh-nvm 
# zstyle :omz:plugins:ssh-agent identities bitbucket_ben

# source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR=$(which nvim)
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
#if [ -z "$SSH_AUTH_SOCK"  ] ; then
#  eval `ssh-agent`
#  ssh-add ~/.ssh/bitbucket
#fi
# eval `ssh-agent -s`
# ssh-add -A
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#



export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh
zplug "wfxr/forgit"
zplug load

SNAP_PATH="/snap/bin"
if [ -d "$SNAP_PATH" ]; then
  export PATH=$PATH:/snap/bin
fi
eval "$(starship init zsh)"

if command -v rbenv > /dev/null 2>&1; then eval "$(rbenv init - zsh)"; fi
# eval "$(~/.rbenv/bin/rbenv init - zsh)"
fpath+=${ZDOTDIR:-~}/.zsh_functions
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi



# fnm linux
# FNM_PATH="/home/adalbertoteixeira/.local/share/fnm"
# if [ -d "$FNM_PATH" ]; then
#   export PATH="/home/adalbertoteixeira/.local/share/fnm:$PATH"
#   eval "`fnm env`"
#   eval "$(fnm env --use-on-cd)"
# fi

# # fnm macOs
FNM_PATH=$(which fnm)
if [ -d "$FNM_PATH" ]; then
  export PATH=$FNM_PATH:$PATH
  eval "`fnm env`"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
