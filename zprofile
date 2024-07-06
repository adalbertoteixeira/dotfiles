for file in ~/.{exports,aliases,path,extra}; do
  # functions, dockerfunc
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    # shellcheck source=/dev/null
    source "$file"
  fi
done
unset file
