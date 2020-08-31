#!/usr/bin/env bash

# install some common tools
cmds=( ["fuck"]="thefuck" )
for k in "${cmds[@]}"; do
    [ -z "$(command -v $k)" ] && pip3 install ${cmds[$k]}
done

cmds=( ["jq"]="jq" )
for k in "${cmds[@]}"; do
    [ -z "$(command -v $k)" ] && sudo apt-get install ${cmds[$k]}
done

# https://github.com/chubin/cheat.sh
[ ! -e "/usr/local/bin/cht" ] && curl -s https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht && sudo chmod +x /usr/local/bin/cht

# If we're on a Mac
if [[ "$(uname -s)" == "Darwin" ]]; then
    brew info coreutils > /dev/null 2>&1
    [ $? == "1" ] && brew install coreutils
fi
