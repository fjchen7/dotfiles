#!/bin/bash

# install command line tolls if not found


case "$OSTYPE" in
    "linux-gnu"* )    # ubuntu only now
        # apt-get update
        # apt-get upgrade
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
cmds=( ["python3"]="python3.8" ["pip3"]="python3-pip" ["tmux"]="tmux" )
for k in "${!cmds[@]}"; do
    # -z: empty string
    [ -z "$(which $k)" ] && apt-get -y install ${cmds[$k]}
done


# pip install
cmds=( ["fuck"]="thefuck" ["tldr"]="tldr" )
for k in "${!cmds[@]}"; do
    [ -z "$(which $k)" ] && pip3 install ${cmds[$k]}
done


if [[ -z "$(which fzf)" ]]; then
    git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf
    bash ~/.fzf/install
fi


# zsh
if [[ -z "$(which zsh)" ]]; then
    apt install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="~/.oh-my-zsh/custom"
for plugin in {zsh-completions,zsh-syntax-highlighting,zsh-autosuggestions}; do
    [ ! -e ${ZSH_CUSTOM}/plugins/${plugin} ] && git clone https://github.com/zsh-users/${plugin} ${ZSH_CUSTOM}/plugins/${plugin}
done;

if [[ ! -e $ZSH_CUSTOM/themes/spaceship-prompt ]]; then
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    read -p "Do you want to install zsh powerline fonts? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git clone --depth=1 https://github.com/powerline/fonts.git ~/.fonts
        bash ~/.fonts/install.sh
        rm -rf ~/.fonts
        echo "zsh powerline fonts installed!"
    fi;

fi

# vim plugin manager
[ ! -e ~/.vim/bundle ] && mkdir -p ~/.vim/bundle
[ ! -e ~/.vim/bundle/Vundle.vim ] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# function existcommand() {
#     if type ${1} >/dev/null 2>&1; then
#         return 0    # true
#     else
#         return 1    # false
#     fi
# }
# if ! existcommand python3; do
#         apt-get -y install python3.8
# fi

main "$@"; exit