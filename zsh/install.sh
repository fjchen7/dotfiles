#!/usr/bin/env bash

set -e

if [[ -z "$(command -v fzf)" ]]; then
    git clone --depth=1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
    bash ${HOME}/.fzf/install
fi

# zsh
[ -z "$(command -v zsh)" ] && sudo apt install zsh
[ ! -e ${HOME}/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# autojump
# In macOS brew install autojump
if [[ ! -e ${HOME}/.autojump ]] && [[ "$(uname -s)" != "Darwin" ]]; then
    git clone git://github.com/wting/autojump.git
    (cd autojump; python3 ./install.py)
    rm -rf autojump
fi

# zsh plugins
ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom
for plugin in {zsh-completions,zsh-syntax-highlighting,zsh-autosuggestions}; do
    [ ! -e ${ZSH_CUSTOM}/plugins/${plugin} ] && git clone https://github.com/zsh-users/${plugin} ${ZSH_CUSTOM}/plugins/${plugin}
done;

# zsh theme
if [[ ! -e ${ZSH_CUSTOM}/themes/powerlevel10k ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi
