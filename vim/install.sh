#!/usr/bin/env bash


DOTFILES_VIM_ROOT="$( dirname "$(readlink -f "$0")" )"
HOME_VIM="${HOME_VIM}"
# install vim plugin manager
[ ! -e ${HOME_VIM} ] && mkdir ${HOME_VIM}
[ ! -e ${HOME_VIM}/bundle ] && mkdir -p ${HOME_VIM}/bundle
[ ! -e ${HOME_VIM}/bundle/Vundle.vim ] && git clone https://github.com/VundleVim/Vundle.vim.git ${HOME_VIM}/bundle/Vundle.vim

if [[ ! -d ${HOME_VIM}/colors ]]; then
    rm -rf ${HOME_VIM}/colors > /dev/null 2>&1
    mkdir -p ${HOME_VIM}/colors
fi
cp -f ${DOTFILES_VIM_ROOT}/colors/* ${HOME_VIM}/colors/
