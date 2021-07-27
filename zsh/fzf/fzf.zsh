
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
# shell edit keys shouldn't be bound, e.g. C-u, C-e/a, C-w...
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FZF_OPT_BASE="--extended --multi --color=16 --ansi --tabstop=4 --no-sort --info=inline --layout=reverse --cycle \
--bind 'tab:down' \
--bind 'btab:up' \
--bind='ctrl-n:down' \
--bind='ctrl-p:up' \
--bind='ctrl-k:page-down' \
--bind='ctrl-j:page-up' \
--bind 'ctrl-s:toggle' \
--bind='right:preview-half-page-down' \
--bind='left:preview-half-page-up' \
--bind='down:preview-down' \
--bind='up:preview-up' \
--bind 'ctrl-/:toggle-preview'"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="$FZF_OPT_BASE --height=40%"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap"
export FZF_ALT_C_COMMAND="fd --hidden --follow --exclude .git --maxdepth=1 ."
# todo: alt-c to simulate "/" in faz-tab
export FZF_ALT_C_OPTS="--preview 'tree -CNFl -L 2 {} | head -200'"

# source fzf configurations
fzf_zshes=('complete.zsh' 'fzf.complete.zsh')
for zsh in "${fzf_zshes[@]}"; do
    source $DOTFILES_FZF_ROOT/$zsh
done
unset fzf_zshes
