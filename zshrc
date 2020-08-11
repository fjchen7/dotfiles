# -r: redeable
# -f: file
for file in ~/.zshrc.d/{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r ${file} ] && [ -f ${file} ] && source ${file};
done;
unset file;