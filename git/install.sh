#!/usr/bin/env bash

if [[ -z "$(command -v diff-so-fancy)" ]]; then
    git clone https://github.com/so-fancy/diff-so-fancy ${HOME}/.local/diff-so-fancy
    ln -s ${HOME}/.local/diff-so-fancy/bin/diff-so-fancy /usr/local/bin/diff-so-fancy
fi
