alias cl='clear'
alias cls='clear'

# ls
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'
# only show hidden files
alias l.='_f(){ if [ $# -eq 0 ]; then ls -d .*; else ( cd $1; ls -d .*; ) fi; }; _f'
alias ll.='_f(){ if [ $# -eq 0 ]; then ls -ld .??*; else ( cd $1; ls -ld .??*; ) fi; }; _f'

# cd
alias cdl='_f(){ cd $1; ls; }; _f'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

# git
alias gti='git'

# utility
alias e='exit'
alias h="fc -l"
alias tree="tree -aNC -I '.git|node_modules|bower_components' --dirsfirst"  # -N show Chinese characters, -C print with color, -a show hidden files, -I exclude files, --dirsfirst show directory first
alias eee='echo $1'

GEO_API="ipinfo.io"
alias ip="curl ${GEO_API}"

# quick source zshrc
alias src='source ~/.zshrc'

# open file between terminal and folder
alias t2f='ofd'  # open directory：iTerminal -> finder (need plugin osx)
alias f2t='cdf'  # open direc¡tory：finder -> iterminal (need plugin osx)

# python
alias p3=python3
alias python=python3
alias python2=python2.7
alias pip3-upgrade-all='pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip3 install -U' # update all python package

if [[ "$OSTYPE" == "darwin"* ]]; then    # macOS alias
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
    alias proxy="export http_proxy=http://127.0.0.1:1080;export https_proxy=http://127.0.0.1:1080;curl ${GEO_API}"
    alias unproxy="unset http_proxy;unset https_proxy;curl ${GEO_API}"
fi
