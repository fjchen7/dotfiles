#!/usr/bin/env bash

if [[ ! -e ${HOME}/.local/diff-so-fancy ]]; then
    [ ! -e ${HOME}/.local ] && mkdir ${HOME}/.local
    git clone https://github.com/so-fancy/diff-so-fancy ${HOME}/.local/diff-so-fancy
fi
