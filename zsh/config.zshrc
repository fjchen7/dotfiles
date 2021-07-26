# configurations that will affect zsh's behaviours

# prevent > from overwriting existent file
# using >| to write forcedly
set -o noclobber

# enable IFS word split: https://stackoverflow.com/a/49628419
# setopt sh_word_split

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8a8a8a,bold,underline"

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(${ZSH_CUSTOM}/themes/spaceship-prompt $fpath)

# fzf
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FZF_OPT_BASE="--exact --extended --color=16 --ansi --tabstop=4 --no-sort --info=inline --layout=reverse --cycle \
--bind='ctrl-j:preview-down' \
--bind='ctrl-k:preview-up' \
--bind='ctrl-d:preview-half-page-down' \
--bind='ctrl-u:preview-half-page-up' \
--bind 'ctrl-/:toggle-preview'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="${FZF_OPT_BASE} --height=40%"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# auto completion via fzf
# ref: https://github.com/junegunn/fzf#settings
export FZF_COMPLETION_OPTS="${FZF_OPT_BASE} --border"
export FZF_COMPLETION_TRIGGER=';'
# git completion via fzf
# ref: https://github.com/junegunn/fzf/wiki/Examples-(completion)#zsh-complete-git-co-for-example
#      https://junegunn.kr/2016/07/fzf-git
_git_sub_command=  # global variable to store git sub-command
# command type pass path: _git_sub_command -> _fzf_complete_git_post() -> script _git_complete_post
_fzf_complete_git() {
    # "Nothing to see here, move along"
    $(git rev-parse HEAD > /dev/null 2>&1) || return
    # $@ is not an array but a string
    ARGS=$(echo $@ | cut -d' ' -f2-)
    case "$ARGS" in
        'co '* | 'checkout '* )
            _git_sub_command="checkout"
            local branches=$(git branch -vv --all)
            # tr -s " ": replace multiple spaces with only one
            # cut -d" " -f1: output 1st column seperated by " "
            _fzf_complete --height=65% --preview-window down,75%,wrap --preview 'b=$(echo {} | sed "s/^\t*\*//" | tr -s " " | xargs | cut -d" " -f1); git lga $b -10' -- "$@" < <(
                echo $branches
            )
            ;;
        'rebase '* | 'rbi '* )
            # format placeholder ("git show --help" for more)
            # %h abbreviated commit hash
            # %s subject
            # %b body, %B raw body (unwrapped subject and body)
            # %cr committer date, relative
            # %an author name
            # %n newline
            # >(40) padding on the left to make the next placeholder take at least 40 columns
            _git_sub_command="rebase"
            local commits=$(git log --color --pretty=format:"%Cred%h%Creset - %s %Cgreen(%cr) %C(bold blue)<%an>%Creset")
            _fzf_complete --height=70% --preview-window down,70%,wrap --preview 'git show --stat --color --pretty=format:"%Cred%h%Creset%n%B%>(40)%Cgreen(%cr)%C(bold blue) <%an>%Creset%n" {1}' -- "$@" < <(
                echo $commits
            )
            ;;
        'add '* | 'diff'* )
            _git_sub_command="add"
            local files=$(git -c color.status=always status --short)
            # "git ls-files --error-unmatch FILE" will exit 1 if file is inexistent
            _fzf_complete --height=70% --delimiter ' ' --multi --nth 2.. --preview-window right,65% --preview 'git ls-files --error-unmatch {-1} >/dev/null 2>&1 && (git diff --color=always -- {-1} | sed 1,4d) || bat --style=plain --color=always --tabs=4 --wrap=auto {-1}' -- "$@" < <(
                echo $files
            )
            ;;
        * )
            eval "zle ${fzf_default_completion:-expand-or-complete}"
            ;;
    esac
}

# When -m / --multi is added, each selected line will be processd by '_git_complete_post' respectively, and their outputs will be joint with ' ' as the final result.
_fzf_complete_git_post() {
    xargs -I{} _git_complete_post "${_git_sub_command} {}"
}
_fzf_complete_g() { _fzf_complete_git "$@" }
_fzf_complete_g_post() { _fzf_complete_git_post }

# thefuck
eval $(thefuck --alias)

# cheat
# https://github.com/chubin/cheat.sh
fpath=(~/.zsh.d/ $fpath)
export CHEATCOLORS=true
