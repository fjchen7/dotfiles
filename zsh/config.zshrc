# history
HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL='ignoreboth' # don't show duplicates and commands that begin with a space in history.
setopt SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt EXTENDED_HISTORY # add timestamps to history
setopt HIST_IGNORE_ALL_DUPS # don't record duplicated commands in history
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks from each command line being added to the history list.

# enable IFS word split: https://stackoverflow.com/a/49628419
# setopt sh_word_split

# turn off bell/beep
unsetopt BEEP

# auto-update
export UPDATE_ZSH_DAYS=13
export HOMEBREW_NO_AUTO_UPDATE=1    # https://github.com/Homebrew/brew/issues/1670
DISABLE_AUTO_UPDATE="true"

# skip the verification of insecure directories
# if it doesn't work, try compaudit | xargs chmod g-w,o-w
ZSH_DISABLE_COMPFIX="true"

# avoid line end with % when using `printf`
# https://unix.stackexchange.com/a/167600
export PROMPT_EOL_MARK=''

# prevent > overwriting existent file
# using >| for write forcedly
# set -o noclobber

# tldr python client
# https://github.com/tldr-pages/tldr-python-client
export TLDR_COLOR_NAME="cyan"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="green"
export TLDR_COLOR_COMMAND="red"
export TLDR_COLOR_PARAMETER="white"
export TLDR_LANGUAGE="es"
export TLDR_CACHE_ENABLED=1

export PATH=~/.local/bin:$PATH
export PATH=${DOTFILES_BIN_ROOT}:$PATH
