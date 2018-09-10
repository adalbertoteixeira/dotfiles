for file in ~/.{exports,bashrc,bash_prompt,aliases,functions,path,dockerfunc,extra}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

