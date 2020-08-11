#!/bin/bash

USE_SOFT_LINK="YES"
read -p "Do you want to configure with soft links? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Nn]$ ]]; then
    USE_SOFT_LINK="NO"
fi;

BACKUP_DIR=~/old_softDotFiles
# soft-linked configurations
softDotFiles=(
	'zshrc' 'zshrc_appearance'
    'alias'
	'vimrc' 'vim'
	'tmux.conf'
	'gitconfig' 'gitignore'
    'vim/colors'
	)

[ ! -e ${BACKUP_DIR} ] && mkdir ${BACKUP_DIR}
for file in "${softDotFiles[@]}"; do
	if [[ -e ~/.${file} ]]; then
        mv ~/.${file} ${BACKUP_DIR}
    fi
    if [[ USE_SOFT_LINK == "YES" ]]; then
        ln -s ~/.dotfiles/${file} ~/.${file}
    else
        cp -r ~/.dotfiles/${file} ~/.${file}
    fi
done

# hard-linked configurations
hardDotFiles=(
    "zshrc_extra"
    "gitconfig_local"
)
for file in "${hardDotFiles[@]}"; do
    [ ! -e ~/.${file} ] && cp ~/.dotfiles/${file} ~/.${file}
    echo "modify ~/.${file} for LOCAL configuration"
done

# ask if keeping old configurations
read -p "Do you want to keep old configurations? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Nn]$ ]]; then
    rm -rf ${BACKUP_DIR} >/dev/null 2>&1
else
    echo "old configurations are kept in ${BACKUP_DIR}."
fi;