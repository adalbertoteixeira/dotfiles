local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

# NVM: Node version manager
if [ ! -n "${BULLETTRAIN_NVM_BG+1}" ]; then
  BULLETTRAIN_NVM_BG=green
fi
if [ ! -n "${BULLETTRAIN_NVM_FG+1}" ]; then
  BULLETTRAIN_NVM_FG=white
fi
if [ ! -n "${BULLETTRAIN_NVM_PREFIX+1}" ]; then
  BULLETTRAIN_NVM_PREFIX="⬡ "
fi

prompt_nvm() {
  local nvm_prompt
  if type nvm >/dev/null 2>&1; then
    nvm_prompt=$(nvm current 2>/dev/null)
    [[ "${nvm_prompt}x" == "x" ]] && return
  elif type node >/dev/null 2>&1; then
    nvm_prompt="$(node --version)"
  else
    return
  fi
	echo %{$fg_bold[green]%}${nvm_prompt}%{$reset_color%} \
}

# Ruby / rbenv
prompt_ruby() {
	if command -v rbenv > /dev/null 2>&1; then
    current_gemset() {
      echo "$(rbenv gemset active 2&>/dev/null | sed -e 's/ global$//')"
    }

    if [[ -n $(current_gemset) ]]; then
      echo $(rbenv version | sed -e 's/ (set.*$//')"@"$(current_gemset)
    else
      echo $(rbenv version | sed -e 's/ (set.*$//')
    fi
fi
}

# GO
prompt_go() {
  setopt extended_glob
  if [[ (-f *.go(#qN) || -d Godeps || -f glide.yaml) ]]; then
    if command -v go > /dev/null 2>&1; then
      echo $(go version | grep --colour=never -oE '[[:digit:]].[[:digit:]]')
    fi
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 && $BULLETTRAIN_STATUS_EXIT_SHOW != true ]] && symbols+="✘"
  [[ $RETVAL -ne 0 && $BULLETTRAIN_STATUS_EXIT_SHOW == true ]] && symbols+="✘ $RETVAL"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡%f"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="⚙"

  if [[ -n "$symbols" && $RETVAL -ne 0 ]]; then
    prompt_segment $BULLETTRAIN_STATUS_ERROR_BG $BULLETTRAIN_STATUS_FG "$symbols"
  elif [[ -n "$symbols" ]]; then
    prompt_segment $BULLETTRAIN_STATUS_BG $BULLETTRAIN_STATUS_FG "$symbols"
  fi

}


PROMPT='%{$fg_bold[white]%}%* \
%{$fg_bold[cyan]%}%n@%m %{$reset_color%}%{$fg[whit]%}in%{$reset_color%} %{$fg_bold[cyan]%}%{%~%} \
$(prompt_nvm) \
%{$fg_bold[red]%}$(prompt_ruby)%{$reset_color%} \
%{$fg_bold[blue]%}$(prompt_go)%{$reset_color%} \
$(git_prompt_info)
${prompt_status}\
%{$fg_bold[green]%}$%{$reset_color%} '


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%} ✔︎"

