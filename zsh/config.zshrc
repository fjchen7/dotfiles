# configurations that will affect zsh behaviours

# prevent > from overwriting existent file
# using >| to write forcedly
set -o noclobber
# turn off bell/beep
unsetopt BEEP

# enable IFS word split: https://stackoverflow.com/a/49628419
# setopt sh_word_split

# zsh behaviours
# auto-update
DISABLE_AUTO_UPDATE="true"
# skip the verification of insecure directories
# if it doesn't work, try compaudit | xargs chmod g-w,o-w
ZSH_DISABLE_COMPFIX="true"

# oh-my-zsh plugin: zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# oh-my-zsh plugin: zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8a8a8a,bold,underline"
# oh-my-zsh plugin: zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=($ZSH_CUSTOM/themes/spaceship-prompt $fpath)
# oh-my-zsh plugin: timer (https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/timer)
export TIMER_FORMAT='[%d]'
# brew install without updating (https://github.com/Homebrew/brew/issues/1670)
export HOMEBREW_NO_AUTO_UPDATE=1

source $DOTFILES_ZSH_ROOT/fzf/fzf.zsh

# thefuck
eval $(thefuck --alias)

# cheat
# https://github.com/chubin/cheat.sh
fpath=(~/.zsh.d/ $fpath)
export CHEATCOLORS=true
