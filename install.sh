#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BACKUP_DIR="~/old_dotfiles"
dotFiles=(
	'zshrc' 'zshrc.d'
	'vimrc' 'vim'
	'tmux.conf'
	'gitconfig' 'gitignore'
	'fzf.zsh'
	)

# install command line software
bash ${SCRIPT_DIR}/install_cli.sh

# soft link configuration files
[ ! -e ${BACKUP_DIR} ] && mkdir ${BACKUP_DIR}
for file in "${dotFiles[@]}"; do
	if [[ -e ~/.${file} ]]; then
        mv ~/.${file} ${BACKUP_DIR}
    fi
    ln -s ${SCRIPT_DIR}/${file} ~/.${file}
done
unset file

# local configurations that are not soft-linked
[ ! -e ~/.zshrc_extra ] && cp ${SCRIPT_DIR}/zshrc_extra ~/.zshrc_extra
echo "You can use ~/.zshrc_extra to customize LOCAL zsh configuration"

# prompt to determin if keep old configurations
read -p "Do you want to keep old configurations? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Nn]$ ]]; then
    rm -rf ${BACKUP_DIR} >/dev/null 2>&1
else
    echo "old configurations are kept in ${BACKUP_DIR}."
fi;