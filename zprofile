for file in ~/.{exports,aliases,path,extra}; do
  # functions, dockerfunc
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    # shellcheck source=/dev/null
    source "$file"
  fi
done
unset file

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
