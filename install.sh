#!/usr/bin/env bash

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

[ ! -e ${HOME}/.dotfiles ] && git clone https://github.com/fjchen7/dotfiles ~/.dotfiles

for file in ${HOME}/.dotfiles/install_{link,cli}.sh; do
    bash ${file}
done
