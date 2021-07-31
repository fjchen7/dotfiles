
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
# shell edit keys shouldn't be bound, e.g. C-u, C-e/a, C-w...
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap"
export FZF_ALT_C_COMMAND="fd --hidden --follow --exclude .git --maxdepth=1 ."
# todo: alt-c to simulate "/" in faz-tab
export FZF_ALT_C_OPTS="--preview 'tree -CNFl -L 2 {} | head -200'"

# source fzf configurations
fzf_zshes=('complete.zsh' 'fzf.complete.zsh')
for zsh in "${fzf_zshes[@]}"; do
    source $DOTFILES_HOME/zsh/fzf/$zsh
done
unset fzf_zshes
