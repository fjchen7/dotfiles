
# --------------------------------------------------------------------------------------------- #
# ----------------------------------------------  zsh ----------------------------------------- #
export ZSH=~/.oh-my-zsh
export ZSH_CUSTOM=${ZSH}/custom
export ZSH_THEME=${ZSH}/themes
# auto-update
DISABLE_AUTO_UPDATE="false"
# how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# skip the verification of insecure directories
ZSH_DISABLE_COMPFIX=true

plugins=(git osx zsh-syntax-highlighting zsh-completions zsh-autosuggestions autojump)
# Load sub configuration
for file in ~/.{alias,func,zshrc_extra,zshrc_appearance}; do
    [ -r ${file} ] && [ -f ${file} ] && source ${file};
done;
source $ZSH/oh-my-zsh.sh



# --------------------------------------------------------------------------------------------- #
# ---------------------------------------  General Settings ----------------------------------- #
export PATH=~/.local/bin:$PATH

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export PYTHONIOENCODING='UTF-8';
export EDITOR='vim'

export HISTSIZE=32768
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

export LSCOLORS=ExFxCxDxBxegedabagacad # ls color
export LESS='-iMs'  # -i: ignore case at search; -M: more information; -s: combine multiple blank lines into one line, -C:...

export HOMEBREW_NO_AUTO_UPDATE=1    # https://github.com/Homebrew/brew/issues/1670
export VIMRC=$HOME/.vim_runtime/vimrcs

# prevent > overwriting existent file
# using >| for write forcedly
# set -o noclobber

# Ctrl-Z switch Vim and ZSH
fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z



# --------------------------------------------------------------------------------------------- #
# ------------------------------  Plugin/Extension Configuration ------------------------------ #
# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# fzf
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --extended --cycle"
# export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --extended --cycle --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tldr
export TLDR_COLOR_BLANK="white"
export TLDR_COLOR_NAME="cyan"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="green"
export TLDR_COLOR_COMMAND="red"
export TLDR_COLOR_PARAMETER="white"
export TLDR_CACHE_ENABLED=1

# thefuck
eval $(thefuck --alias)

# cheat
# https://github.com/chubin/cheat.sh
fpath=(~/.zsh.d/ $fpath)
export CHEATCOLORS=true



# --------------------------------------------------------------------------------------------- #
# ------------------------------  macOS Specified Configuration ------------------------------- #
if [[ "$OSTYPE" == "darwin"* ]]; then    # macOS alias
        # zsh-autosuggestions key bind for iTerm2
		# further step for iTerm2: set key mapping in Preferences->Profiles->Keys
		bindkey '^[[ZE' autosuggest-execute # Accepts and executes the current suggestion.
		bindkey '^[[ZC' autosuggest-clear # Clears the current suggestion.

		# nnn
		export NNN_BMS='t:~/Documents/Notes;d:~/Desktop;D:~/Downloads'
fi

echo "Oh My Zsh!"  # Welcome