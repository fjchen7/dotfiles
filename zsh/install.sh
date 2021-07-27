#!/usr/bin/env bash

# install zsh-related stuffs

set -e

# zsh
[[ -z "$(command -v zsh)" ]] && sudo apt install zsh
[[ ! -e $HOME/.oh-my-zsh ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh plugins
# ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
plugins=(zsh-user/{zsh-completions,zsh-syntax-highlighting,zsh-autosuggestions})
plugins+=(Aloxaf/fzf-tab)
for plugin in "${plugins[@]}"; do
    plugin_root=$ZSH_CUSTOM/plugins/${plugin##*/}
    [[ ! -e $plugin_root ]] && git clone git@github.com:$plugin $plugin_root
done;

# zsh theme
if [[ ! -e $ZSH_CUSTOM/themes/powerlevel10k ]]; then
    git clone --depth=1 git@github.com:romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# ls color for faf-tab
# https://gist.github.com/thomd/7667642
ls_color_sh=$HOME/.local/share/lscolors.sh
if [[ ! -e $ls_color_sh ]]; then
    [[ "$OSTYPE" =~ "^darwin" ]] && alias dircolors=gdircolors  # FreeBSD/macOS does not have 'dircolors'
    dircolors -b <(curl -L "https://github.com/trapd00r/LS_COLORS/blob/master/LS_COLORS?raw=true") > $ls_color_sh
    echo "$ls_color_sh downloaded."
fi
