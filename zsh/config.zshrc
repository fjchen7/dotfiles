export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export PYTHONIOENCODING='UTF-8';
export EDITOR='code'

export LSCOLORS=ExFxCxDxBxegedabagacad # ls color
# -i: ignore case at search
# -M: more information in prompt
# -s: combine multiple blank lines into one line
# -F: quit if screen can shows all content
# -R: not show escape sequences like ESC[, and will convert them into ANSI color
export LESS='-iMsFR'

# history
HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL='ignoreboth' # don't show duplicates and commands that begin with a space in history.
setopt SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt EXTENDED_HISTORY # add timestamps to history
setopt HIST_IGNORE_ALL_DUPS # don't record duplicated commands in history
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks from each command line being added to the history list.

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
