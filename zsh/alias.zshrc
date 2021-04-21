case "$OSTYPE" in
    darwin* )
        alias ls='ls -F -G'
        alias proxy="export http_proxy=http://127.0.0.1:1087; export https_proxy=http://127.0.0.1:1087; ip"
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
alias l.='_f(){ (cd ${1:-.}; ls -d .*)}; _f'
alias ll.='_f(){ (cd ${1:-.}; ls -ld .??*)}; _f'
# only list symlinks
alias lls='_f(){ (cd ${1:-.}; _fs=( $(find . -maxdepth 1 -type l | xargs -I _ basename _) ); [ -n "$_fs" ] && ls -adl $_fs) }; _f'
# only list directories
alias lld='_f(){ (cd ${1:-.}; _fs=( $(find . -maxdepth 1 -type d -not -path "." | xargs -I _ basename _) ); [ -n "$_fs" ] && ls -adl $_fs) }; _f'

# cd
alias cdl='_f(){ cd $1; ls }; _f'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

# quick grep
# ls? abc    - search "abc" from $PWD
# ls? ~ abc  - search "abc" from ~
alias 'ls?'='_f() {
        local dir=$PWD
        [[ "$#" != 1 ]] && dir=$1 && shift
        ls -al $dir | grep -i $1
    }; _f'
alias 'ps?'='_quick_grep "ps aux" $@'
alias 'alias?'='_quick_grep "alias" $@'

# more efficient
alias 'vim$'="vim -c \"normal '0\""  # open last file
alias ':q'='exit'
alias src='source ~/.zshrc'
alias h="fc -l"
alias tmux-new='_f(){ tmux new-session -t ${1:-default} }; _f'

# customized ls and info
alias 'ls-user'="stat -c '%n %U:%G-%a' *"
alias 'info-shell-pid'='echo $$'
alias 'info-shell-name'='echo $0'
alias 'info-shell'='echo $SHELL'
alias 'info-distribution'='cat /etc/issue'

# utility
alias ipy=ipython
alias ip='curl -s "ipinfo.io" | jq'
alias timestamp='date "+%Y%m%dT%H%M%S"'

# command replacement
#alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
# -N show Chinese characters, -C print with color, -a show hidden files, -I exclude files, --dirsfirst show directory first
alias tree='_f(){ tree -aNC -I ".git|node_modules|bower_components|.DS_Store" --dirsfirst "$@" | less -FRX }; _f'
[ -n "$(command -v bat)" ] && alias cat=bat
[ -n "$(command -v git)" ] && alias diff='_f(){ git diff --no-index --color-words "$@" }; _f'    # Git’s colored diff
alias cht=${DOTFILES_ROOT}/bin/cht

# others
alias -s md='open -a Typora'    # open *.md with Typora by default
alias gti='git'    # avoid typo

# helper functions
function _quick_grep {
        [[ "$#" == 0 ]] && exit 1
        if [[ "$#" == 1 ]]; then
            eval "$1"
        else
            local _p=$(_join_by "|" ${@:2})
            eval "$1" | grep -i -E ${_p}  # operation OR
        fi
    }
function _join_by { local d=${1-} f=${2-}; if shift 2; then printf %s "$f" "${@/#/$d}"; fi; }
