case "$OSTYPE" in
    darwin* )
        alias ls='ls -F -G'
        alias proxy="export http_proxy=http://127.0.0.1:1080; export https_proxy=http://127.0.0.1:1080; ip"
        alias unproxy="unset http_proxy; unset https_proxy; ip"
        ;;
    linux* )
        alias ls='ls -F --color=auto'
        ;;
    * )
        ;;
esac

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
# open file between terminal and folder

# utilities
alias cht=${DOTFILES_ROOT}/bin/cht
alias src='source ~/.zshrc'
alias ip="curl -s "ipinfo.io" | jq"

# command replacement
alias grep='grep --color=always --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
# -N show Chinese characters, -C print with color, -a show hidden files, -I exclude files, --dirsfirst show directory first
alias tree='_f() { tree -aNC -I ".git|node_modules|bower_components|.DS_Store" --dirsfirst "$@" | less -FRX }; _f'
[ -n "$(command -v bat)" ] && alias cat=bat
[ -n "$(command -v git)" ] && alias diff='_f() { git diff --no-index --color-words "$@" }; _f'    # Git’s colored diff
