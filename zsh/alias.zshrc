alias cl='clear'
alias cls='clear'

# ls
alias ls='ls -F --color=tty'
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
alias cdl='_f() { cd $1; ls }; _f'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

# git
alias gti='git'

# utility
alias e='exit'
alias h="fc -l"
# -N show Chinese characters, -C print with color, -a show hidden files, -I exclude files, --dirsfirst show directory first
alias tree='_f() { tree -aNC -I ".git|node_modules|bower_components|.DS_Store" --dirsfirst "$@" | less -FRX }; _f'
# Git’s colored diff
alias diffg='_f() { git diff --no-index --color-words "$@" }; _f'

# quick source zshrc
alias src='source ~/.zshrc'

# open file between terminal and folder
alias t2f='ofd'  # open directory：iTerminal -> finder (need plugin osx)
alias f2t='cdf'  # open direc¡tory：finder -> iterminal (need plugin osx)

# python
alias p3=python3
alias python=python3
alias python2=python2.7
# update all python packages
alias pip3-upgrade-all='pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip3 install -U'

# If we're on a Mac
if [[ "$(uname -s)" == "Darwin" ]]; then
    # make sed compatible with that in linux version
    alias sed=gsed

    alias cat='bat'
    alias -s md='open -a Typora' # open *.md with Typora by default
    #alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
    alias ipy=ipython
    alias virtualenv2='virtualenv -p /usr/local/bin/python2'

    # upgrade
    alias brew-cask-upgrade-all='brew update && brew cask reinstall `brew cask outdated`'
    alias brew-upgrade-all='brew update && brew upgrade `brew outdated`'
    alias upgrade='pip3-upgrade-all && brew-upgrade-all'

    # proxy
    alias proxy="export http_proxy=http://127.0.0.1:1080;export https_proxy=http://127.0.0.1:1080; ip"
    alias unproxy="unset http_proxy;unset https_proxy; ip"
else  # If we're on Linux or Windows
    # Normalize `open`
    if grep -q Microsoft /proc/version; then
        # Ubuntu on Windows using the Linux subsystem
        alias open='explorer.exe';
    else
        alias open='xdg-open';
    fi
fi
