
#!/usr/bin/env bash

if [[ -z "$(which fzf)" ]]; then
    git clone --depth=1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
    bash ${HOME}/.fzf/install
fi

# zsh
[ -z "$(which zsh)" ] && sudo apt install zsh
[ ! -e ${HOME}/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh plugin: autojump
if [[ ! -e ${HOME}/.autojump ]]; then
    git clone git://github.com/wting/autojump.git ${HOME}/autojump
    (cd ${HOME}/autojump; python3 ./install.py)
    rm -rf ${HOME}/autojump
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
