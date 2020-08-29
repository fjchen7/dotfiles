#!/usr/bin/env bash

VIM_DOTFILES_ROOT="$(dirname $0)"
VIM_HOME="${HOME}/.vim"
# install vim plugin manager
[ ! -e ${VIM_HOME} ] && mkdir ${VIM_HOME}
[ ! -e ${VIM_HOME}/bundle ] && mkdir -p ${VIM_HOME}/bundle
[ ! -e ${VIM_HOME}/bundle/Vundle.vim ] && git clone https://github.com/VundleVim/Vundle.vim.git ${VIM_HOME}/bundle/Vundle.vim

if [[ ! -d ${VIM_HOME}/colors ]]; then
    rm -rf ${VIM_HOME}/colors > /dev/null 2>&1
    mkdir -p ${VIM_HOME}/colors
fi

( cd "${VIM_DOTFILES_ROOT}/colors"; find . -not -path "." -exec basename {} \; | xargs -I _ sh -c "[ ! -e ${VIM_HOME}/colors/_ ] && cp ${VIM_DOTFILES_ROOT}/colors/_ ${VIM_HOME}/colors/" )
