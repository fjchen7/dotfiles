#!/bin/bash

# ask if using soft links
USE_SOFT_LINK="YES"
read -p "Do you want to configure with soft links? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Nn]$ ]]; then
    USE_SOFT_LINK="NO"
fi
# ask if keeping old configurations
KEEP_OLD_CONF="YES"
read -p "Do you want to keep old configurations? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Nn]$ ]]; then
    KEEP_OLD_CONF="NO"
fi
echo ""

if [[ ${KEEP_OLD_CONF} == "YES" ]]; then
    BACKUP_DIR=${HOME}/old_softDotFiles
    [ ! -e ${BACKUP_DIR} ] && mkdir ${BACKUP_DIR}
    echo "old configurations are kept in ${BACKUP_DIR}."
fi


# soft-linked configurations
softDotFiles=(
    'zshrc' 'zshrc.d'
    'vimrc' 'vimrc.d' 'vim/colors'
    'tmux.conf'
    'gitconfig' 'gitignore'
    'vim/colors'
    )
[ ! -e ${HOME}/.vim ] && mkdir ${HOME}/.vim
for file in "${softDotFiles[@]}"; do
    if [[ ${KEEP_OLD_CONF} == "YES" ]]; then
        mv ${HOME}/.${file} ${BACKUP_DIR} 2>/dev/null
    else
        rm -rf ${HOME}/.${file} ${BACKUP_DIR}
    fi
    if [[ ${USE_SOFT_LINK} == "YES" ]]; then
        ln -s ${HOME}/.dotfiles/${file} ${HOME}/.${file}
        echo "[${HOME}/.dotfiles/${file}] soft linked => [${HOME}/.${file}]"
    else
        cp -r ${HOME}/.dotfiles/${file} ${HOME}/.${file}

        echo "[${HOME}/.dotfiles/${file}] copied => [${HOME}/.${file}]"
    fi
done

# hard-linked configurations
hardDotFiles=(
    "zshrc_local"
    "gitconfig_local"
)
for file in "${hardDotFiles[@]}"; do
    [ ! -e ${HOME}/.${file} ] && cp ${HOME}/.dotfiles/${file} ${HOME}/.${file}
    echo "modify ${HOME}/.${file} for LOCAL configuration"
done
