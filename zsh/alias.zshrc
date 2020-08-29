if [[ "$(uname -s)" == "Darwin" ]]; then
    alias ls='ls -F -G'

    alias proxy="export http_proxy=http://127.0.0.1:1080;export https_proxy=http://127.0.0.1:1080; ip"
    alias unproxy="unset http_proxy;unset https_proxy; ip"
else
    alias ls='ls -F --colors=auto'
fi

# clear
alias cl='clear'
alias cls='clear'

# ls
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'
# only list hidden files (dotfiles)
alias l.='_f() { (cd ${1:-.}; ls -d .*) }; _f'
alias ll.='_f() { (cd ${1:-.}; ls -ld .??*) }; _f'
# only list symlinks
alias lls='_f() { (cd ${1:-.}; _fs=( $(find . -maxdepth 1 -type l | xargs -I _ basename _) ); [ -n "$_fs" ] && ls -adl $_fs) }; _f'
# only list directories
alias lld='_f() { (cd ${1:-.}; _fs=( $(find . -maxdepth 1 -type d -not -path "." | xargs -I _ basename _) ); [ -n "$_fs" ] && ls -adl $_fs) }; _f'

# cd
alias cdls='_f() { cd $1; ls }; _f'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

# open *.md with Typora by default
alias -s md='open -a Typora'

# easy to type
alias gti='git'    # avoid typo
alias e='exit'
alias h="fc -l"
alias ipy=ipython
alias src='source ~/.zshrc'
# open file between terminal and folder
alias t2f='ofd'  # iTerminal -> finder (need plugin osx)
alias f2t='cdf'  # finder -> iterminal (need plugin osx)

# command replacement
# -N show Chinese characters, -C print with color, -a show hidden files, -I exclude files, --dirsfirst show directory first
alias tree='_f() { tree -aNC -I ".git|node_modules|bower_components|.DS_Store" --dirsfirst "$@" | less -FRX }; _f'
[ -n "$(command -v bat)" ] && alias cat=bat

# functionality
# Git’s colored diff
alias diffg='_f() { git diff --no-index --color-words "$@" }; _f'
