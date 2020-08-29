#!/usr/bin/env bash

# install some common tools
cmds=( ["fuck"]="thefuck" ["tldr"]="tldr" )
for k in "${!cmds[@]}"; do
    [ -z "$(command -v $k)" ] && pip3 install ${cmds[$k]}
done

cmds=( ["jq"]="jq" )
for k in "${!cmds[@]}"; do
    [ -z "$(command -v $k)" ] && sudo apt-get install ${cmds[$k]}
done
