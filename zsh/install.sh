#!/usr/bin/env bash

# install zsh-related stuffs

set -e

# zsh
[ -z "$(command -v zsh)" ] && sudo apt install zsh
[ ! -e ${HOME}/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh plugins
ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom
for plugin in {zsh-completions,zsh-syntax-highlighting,zsh-autosuggestions}; do
    [ ! -e ${ZSH_CUSTOM}/plugins/${plugin} ] && git clone https://github.com/zsh-users/${plugin} ${ZSH_CUSTOM}/plugins/${plugin}
done;

# zsh theme
if [[ ! -e ${ZSH_CUSTOM}/themes/powerlevel10k ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi
