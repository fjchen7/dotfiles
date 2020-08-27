#!/usr/bin/env bash

# install some common tools
cmds=( ["fuck"]="thefuck" ["tldr"]="tldr" )
for k in "${!cmds[@]}"; do
    [ -z "$(which $k)" ] && pip3 install ${cmds[$k]}
done
