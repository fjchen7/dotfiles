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
_git_completition_command=  # global variable to record command for _fzf_complete_git_post
_git_completition_command_enum_checkout='checkout'
_git_completition_command_enum_rebase='rebase'
_fzf_complete_git() {
    # $@ is not an array but a string
    ARGS=$(echo $@ | cut -d' ' -f2-)
    case "$ARGS" in
        'co '* | 'checkout '* )
            _git_completition_command="$_git_completition_command_enum_checkout"
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
            _git_completition_command="$_git_completition_command_enum_rebase"
            local commits=$(git log --color --pretty=format:"%Cred%h%Creset - %s %Cgreen(%cr) %C(bold blue)<%an>%Creset")
            _fzf_complete --height=70% --preview-window down,70%,wrap --preview 'hash=$(echo {} | cut -d" " -f1); git show --stat --color --pretty=format:"%Cred%h%Creset%n%B%>(40)%Cgreen(%cr)%C(bold blue) <%an>%Creset%n" $hash' -- "$@" < <(
                echo $commits
            )
            ;;
        * )
            eval "zle ${fzf_default_completion:-expand-or-complete}"
            ;;
    esac
}
_git_post() {
    read var  # input from pipeline, which is not a array but a string.
    var="$(echo $var | xargs)"  # trim string.
    case "$_git_completition_command" in
        "$_git_completition_command_enum_checkout" )
            echo $var | sed "s/^\t*\*//" | tr -s " " | xargs | awk '{print $1}'
            ;;
        "$_git_completition_command_enum_rebase" )
            echo "$var" | awk '{print $1}'
            ;;
        * )
            awk '{print $1}'
    esac
    _git_completition_command=
}
_fzf_complete_git_post() { _git_post }
_fzf_complete_g() { _fzf_complete_git "$@" }
_fzf_complete_g_post() { _fzf_complete_git_post }

# thefuck
eval $(thefuck --alias)

# cheat
# https://github.com/chubin/cheat.sh
fpath=(~/.zsh.d/ $fpath)
export CHEATCOLORS=true
