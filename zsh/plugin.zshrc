# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(${ZSH_CUSTOM}/themes/spaceship-prompt $fpath)

# fzf
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --extended --cycle -e --preview 'tree -C {} | head -200'"
# export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --extended --cycle --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_COMPLETION_OPTS='--border --info=inline'
# overwrite functions that generate list of `path` and `directory`
# see: https://github.com/junegunn/fzf#settings
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" --max-depth 2 . "$1"
}
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" --max-depth 2 . "$1"
}
export FZF_COMPLETION_TRIGGER=';'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# thefuck
eval $(thefuck --alias)

# cheat
# https://github.com/chubin/cheat.sh
fpath=(~/.zsh.d/ $fpath)
export CHEATCOLORS=true

# zsh-autosuggestions key bind
# ^[ is Alt
bindkey '^[J' autosuggest-execute # Accepts and executes the current suggestion.
bindkey '^[j' autosuggest-execute # Accepts and executes the current suggestion.
# Ctrl / Alt + m / M: accept line and execute command
bindkey '^[m' accept-line
bindkey '^[M' accept-line
