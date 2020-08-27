export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export PYTHONIOENCODING='UTF-8';
export EDITOR='code'

export LSCOLORS=ExFxCxDxBxegedabagacad # ls color
export LESS='-iMs'  # -i: ignore case at search; -M: more information; -s: combine multiple blank lines into one line, -C:...

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTCONTROL='ignoreboth' # Omit duplicates and commands that begin with a space from history.
setopt SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt EXTENDED_HISTORY # add timestamps to history
setopt HIST_IGNORE_ALL_DUPS # don't record duplicated commands in history
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks from each command line being added to the history list.

#setopt CORRECT # turns on spelling correction for commands

# auto-update
export UPDATE_ZSH_DAYS=13
export HOMEBREW_NO_AUTO_UPDATE=1    # https://github.com/Homebrew/brew/issues/1670
DISABLE_AUTO_UPDATE="false"

# skip the verification of insecure directories
ZSH_DISABLE_COMPFIX=true

# prevent > overwriting existent file
# using >| for write forcedly
# set -o noclobber
