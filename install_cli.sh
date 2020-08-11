#!/bin/bash

# install command line tolls if not found


case "$OSTYPE" in
    "linux-gnu"* )    # ubuntu only now
        # sudo apt-get update
        # sudo apt-get upgrade
        ;;
    "darwin"* )    # macOS
        # brew update
        # brew upgrade
        ;;
    * )
        echo "os system is not supported"
        exit
        ;;
esac

# apt-get install
declare -A cmds=( ["python3"]="python3.8" ["pip3"]="python3-pip" ["tmux"]="tmux" )
for k in "${!cmds[@]}"; do
    # -z: empty string
    [ -z "$(which $k)" ] && sudo apt-get -y install ${cmds[$k]}
done


# pip install
cmds=( ["fuck"]="thefuck" ["tldr"]="tldr" )
for k in "${!cmds[@]}"; do
    [ -z "$(which $k)" ] && pip3 install ${cmds[$k]}
done


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
    cd ${HOME}/autojump
    python3 ./install.py
    cd -
    rm -rf ${HOME}/autojump
fi

# zsh plugins
ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom
for plugin in {zsh-completions,zsh-syntax-highlighting,zsh-autosuggestions}; do
    [ ! -e ${ZSH_CUSTOM}/plugins/${plugin} ] && git clone https://github.com/zsh-users/${plugin} ${ZSH_CUSTOM}/plugins/${plugin}
done;

if [[ ! -e $ZSH_CUSTOM/themes/spaceship-prompt ]]; then
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    read -p "Do you want to install zsh powerline fonts? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git clone --depth=1 https://github.com/powerline/fonts.git ${HOME}/.fonts
        bash ${HOME}/.fonts/install.sh
        rm -rf ${HOME}/.fonts
        echo "zsh powerline fonts installed!"
    fi;
fi

# vim plugin manager
[ ! -e ${HOME}/.vim ] && mkdir ${HOME}/.vim
[ ! -e ${HOME}/.vim/bundle ] && mkdir -p ${HOME}/.vim/bundle
[ ! -e ${HOME}/.vim/bundle/Vundle.vim ] && git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

# function existcommand() {
#     if type ${1} >/dev/null 2>&1; then
#         return 0    # true
#     else
#         return 1    # false
#     fi
# }
# if ! existcommand python3; do
#         sudo apt-get -y install python3.8
# fi