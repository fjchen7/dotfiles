# yazi: https://yazi-rs.github.io/docs/quick-start#shell-wrapper
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

alias pc='tee >(pbcopy)' # copy + stdout
alias pp=pbpaste
alias proxy_clash="export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897"
alias unproxy="unset http_proxy https_proxy all_proxy"
alias proxy_proxyman="export https_proxy=http://172.20.10.2:9090 http_proxy=http://172.20.10.2:9090 all_proxy=socks5://172.20.10.2:9090"
alias 'proxy?'="_is_proxy"
_is_proxy() {
    r=$(curl -sL -vv https://www.google.com --max-time 3 2>/dev/null)
    if [[ -z "$r" ]]; then
        echo "❗️ $(tput setaf 1)"No Proxy!"$(tput sgr0)"
    else
        echo "✅ $(tput setaf 2)"In Proxy!"$(tput sgr0)"
    fi
}

export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="l gti g"

# ls
# alias exa='exa -Fh --git --time-style=long-iso --sort=name'
alias eza='eza --sort=name --time-style=long-iso'
alias gls='gls --color=tty -F'
alias ls='eza'
alias l='eza'
alias ll='eza -lg'
alias la='eza -a'
alias lla='eza -alg'
# only list directories
alias ld='eza -D'
alias lld='eza -Dlg'
# only list hidden files (dotfiles)
alias l.='_f(){ (cd ${@:-.}; eza -ad .*)}; _f'
alias ll.='_f(){ (cd ${@:-.}; eza -algd .*)}; _f'
# only list symlinks
alias lls='_f(){ (cd ${@:-.}; _fs=( $(find . -maxdepth 1 -type l | xargs -I _ basename _) ); [ -n "$_fs" ] && eza -algd $_fs) }; _f'

# cd
alias cdl='_f(){ cd $@; ls }; _f'  # cd and list
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
# Create a new directory and enter it
alias mkdircd='_f(){ mkdir -p "$@" && cd "$_" }; _f'

# quick grep
# ls? abc    - search "abc" from $PWD
# ls? ~ abc  - search "abc" from ~
alias 'ls?'='_f() {
        local dir=$PWD
        [[ "$#" != 1 ]] && dir=$1 && shift
        _fs=( $(cd $dir && fd -d1 --hidden | grep -i $1) );
        eza -ad -1 $_fs
    }; _f'
alias 'l?'='ls?'
alias 'll?'='_f() {
        local dir=$PWD
        [[ "$#" != 1 ]] && dir=$1 && shift
        _fs=( $(cd $dir && fd -d1 --hidden | grep -i $1) );
        eza -ald $_fs
    }; _f'
alias 'ps?'='_quick_grep "ps aux" $@'
alias 'path?'='_quick_grep "_list_path" $@'
alias 'bin?'='_quick_grep "_list_my_bin" $@'
alias 'bindkey?'='_quick_grep "bindkey" $@'
alias 'key?'='_quick_grep "bindkey" $@'
alias 'brew?'='_quick_grep "_brew_list" $@'
alias 'zstyle?'='_quick_grep "zstyle -L" $@'

# git
git_current_branch () {
    local ref
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]
    then
        [[ $ret == 128 ]] && return
        ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return
    fi
    echo ${ref#refs/heads/}
}
get_file () {
fd --color=always --hidden --follow --exclude .git --maxdepth=10 . | fzf --preview '([[ -d {} ]] && echo "[DIRECTORY]" && tree -CNFl -L 5 {} | head -200) || (echo "[FILE]" && bat --style=plain --color=always {})' --preview-window right,75%,wrap,hidden | __join_lines
}
get_commit () {
    COMMAND='git log --color --pretty=format:"%Cred%h%Creset - %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
    # -p: generat path (changed content)
    PREVIEW_DEFAULT='git show --stat --color {1}'
    PREVIEW_FULL="$PREVIEW_DEFAULT -p | $GIT_WIDGET_PAGER"
    eval $COMMAND |
    fzf --no-cycle --preview "$PREVIEW_FULL" \
        --height=80% --preview-window down,65%,wrap | awk '{print $1}'
}
alias g='git'
alias gs='git status'
alias gss='git status -sb'
alias gsh='git stash'
alias gshp='git stash pop'
alias gshm='git stash push -m'
alias ga='git add'
alias gaa='git add -A'
alias gab="git absorb"
alias gabr="git absorb --and-rebase"
# alias gab='_f(){ git add $@ && git absorb }; _f'
# alias gabr='_f(){ git add $@ && git absorb --and-rebase }; _f'
alias gc='git commit'
alias gcm='git commit -m'
alias gcf='print -z "git commit --fixup $(get_commit)"'  # fixup a commit
alias gc!='git commit --amend -v'
alias gc!!='git commit --amend -v -C HEAD'
# alias 'gc-'='git commit -t <(sed "1 i\### Last commit\n$(git log --format=%B -n 1 HEAD)\n" ~/.dotfiles/git/gitmessage) -v'
alias gn='git clone'
alias gk='git checkout'
alias gk-='git checkout -'
# checkout branch
alias gkb='git checkout $(git branch --sort=-committerdate --color=always -a | fzf --query "!remote " --preview "git lg {-1} -20" --height=70% --preview-window down,70%,wrap,border --header="^d delete branch" --bind "ctrl-d:execute(git branch -d {-1} > /dev/null)+reload(git branch --sort=-committerdate --color=always -a)" | awk "{print $NF}" |  sed -e "s/remotes\///" -e "s/*//")'
alias goo='git open'
alias gp='git push'
# push and create PR
alias gpr='git push && gh pr create --title "<pr_title>" --web'
alias gpo='git push && git open'
alias gp!='git push -f'
alias gpo!='git push -f && git open'
# alias gpb='git push --set-upstream origin $(git_current_branch)'
alias gpl='git pull'
alias gb='git branch'
alias gbv='git branch -v'
alias gbd='git branch -d'
alias gd='git diff'
alias gf='git fetch'
alias gfp='git fetch --prune'  # prune branch that is deleted on remote
alias glg='git lg'
alias glgs='git lg --stat'  # show changed files
alias glgv='git lgv'
alias glgvv='git lgvv'
alias gro='git restore'
alias gros='git restore --staged'
alias gt='git reset'
alias ge='git remote'
alias gev='git remote -v'
alias gr='git rebase'
alias gri='git rebase -i --autosquash --autostash'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gac='_f(){ [[ "$#" == 0 ]] && echo "Error: nothing to add and commit" && return 1; git add $@ && git commit -t <(sed "1 i\### Last commit\n$(git log --format=%B -n 1 HEAD)\n" ~/.dotfiles/git/gitmessage) }; _f'
alias gac.='gac .'  # add and commit all
alias gac!='_f(){ [[ "$#" == 0 ]] && echo "Error: nothing to add and commit" && return 1; git add $@ && gc! }; _f'

# cargo
alias c='cargo'
alias cb='cargo build'
alias cr='cargo run'
alias cre='cargo run --example'
alias cc='cargo clean'
alias ck='cargo check'
alias cud='cargo update'
alias cug='cargo upgrade'
# alias ct='cargo nextest'
alias ct='cargo nextest run'
alias ctn='cargo nextest run --no-capture'
alias cta='cargo nextest run --run-ignored all'
alias ctl='cargo nextest list'

# show information
alias @shell-pid='echo $$'
alias @shell-name='echo $0'
alias @shell='echo $SHELL'
# alias @sysinfo=
alias @system='echo "[System]: $(uname -a)" && echo "[Uptime]: $(uptime)" && echo "[User]: $(whoami)" '
#alias ip='curl -s "ipinfo.io" | jq'
alias @user='whoami'
alias @user-all='less /etc/passwd'
alias @file-permission="stat -c '%n %U:%G-%a' * | column -t"
alias @ip='curl -s "cip.cc"'
alias wtf='_wtf'
alias which='_wtf'

# more efficient
alias now='date +"%Y-%m-%d %T"'
alias rr='func() { if [ $# -eq 0 ]; then open -na "RustRover.app" --args .; else open -na "RustRover.app" --args "$@"; fi; }; func'

# Shorter
alias o="open"
alias cls='clear'
alias h="fc -l"
alias q="exit"
# alias n='nnn -T d -io -P v'
alias du='_f(){ du -sh $@ | sort -h }; _f'
alias 'du.'='_f(){ du -sh * | sort -h }; _f'
alias trn='tr -d "\n"'
# Fix neovim highlight in tmux: https://gist.github.com/gutoyr/4192af1aced7a1b555df06bd3781a722
alias tmux='env TERM=xterm-256color tmux'
alias tn='tmux new -A -s main'
alias ta='tmux attach'
alias tl='tmux list-session'
# Copilot CLI
# https://docs.github.com/en/copilot/github-copilot-in-the-cli/using-github-copilot-in-the-cli#setting-up-aliases-for-copilot-in-the-cli
# eval "$(gh copilot alias -- zsh)"
alias ghc="gh copilot"
alias ghcs="gh copilot suggest"
alias ghce="gh copilot explain"

# Replace default
alias rg='rg -L'
# tree: -N show Chinese characters, -C print with color, -a show hidden files, -I exclude files, --dirsfirst show directory first
# alias tree='_f(){ tree -aNC -I ".git|node_modules|bower_components|.DS_Store" --dirsfirst "$@" | less -FR }; _f'
alias tree1='tree -L 1'
alias tree2='tree -L 2'
alias tree3='tree -L 3'
alias diff='colordiff'  # diff with color
alias ping='ping -c 5'  # Stop after sending count ECHO_REQUEST packets #
alias curl='curl -SL'  # Show error && redirect
# https://twitter.com/carsonyangk8s/status/1498254329429762054
alias ping='_f(){ping -c5 $@ | nali}; _f' # -c5 Stop after sending count ECHO_REQUEST packets #
alias dig='_f(){dog $@ | nali}; _f'
alias ipy=ipython
alias pip=pip3
alias python=python3
alias py=python3

# Safety alias
# do not delete & prompt if deleting more than 3 files at a time
# alias rm='rm -I --preserve-root'
alias rm='trash'
# prompt before overwrite
alias mv='mv -i -v'
alias cp='cp -i -v'
alias ln='ln -i -v'
# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Others
alias cleanup='brew cleanup && pip cache purge'
alias -s md='open -a Typora'    # open *.md with Typora by default
# Blog
alias blog-deploy='hugo server --source $BLOG_HOME -e production --disableFastRender -F'
alias blog-new='_f() { hugo new -s $BLOG_HOME posts/$1.md; open $BLOG_HOME/content/posts/$1.md; }; _f'
alias diff="delta"
alias diffcolor='colordiff'

# alias loadzsh='source ~/.zshrc'
alias loadzsh="echo 'Zsh is reloaded!'; exec zsh"
alias loadhammerspoon="hs -c 'hs.reload()'; echo 'HammerSpoon is reloaded!'"
alias loadgoku="goku; echo 'Goku is reloaded!'"
alias loadall="loadhammerspoon; loadgoku; loadzsh"
alias "]app"='open "/Applications/$(eza /Applications | fzf)"'
alias "]blog"='code $BLOG_HOME'

# helper functions
function _quick_grep {
    [[ "$#" == 0 ]] && exit 1
    local cmd="$1"
    shift 1

    local _delimiter=" "
    for ((i=1; i<=$#; i++)); do
        case "$@[$i]" in
            "-o" | "--or" )
                _delimiter="|"
                set -- "${@:1:$((i-1))}" "${@:$((i+1))}"  # remove -o from $@
                break
                ;;
            * )
                ;;
        esac
    done
    if [[ "$#" == 0 ]]; then
        eval "$cmd"
    else
        # join parameters with delimiter
        local _p=$(_join_by "${_delimiter}" ${@:1})
        eval "$cmd" | grep -i -E "${_p}"  # operation OR
    fi
}

function _join_by {
    # https://stackoverflow.com/a/17841619
    local d=${1-} f=${2-}; if shift 2; then printf %s "$f" "${@/#/$d}"; fi;
}

function _list_my_bin() {
    fd --type executable --max-depth 1 --exclude '_*' . "${DOTFILES_BIN_HOME}" --exec basename {} \; | sort -n
}

function _list_path() {
    echo $PATH | tr ":" "\n"
}

function _wtf() {
    command -V "$@"
    if [[ -n $(alias $@) ]]; then
        # grep text like "alias $'ls?=" or "alias 'wtf="
        PS4='+%x:%I>' zsh -i -x -c '' |& grep "alias \$\?'$1="
    else
        which "$@"
    fi
}

function _brew_list() {
    # ref: https://stackoverflow.com/a/55445034
    brew leaves | xargs brew deps --installed --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"
}
