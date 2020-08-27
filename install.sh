#!/usr/bin/env bash

set -e    # exit script when error happen
set -u    # report error if visiting undeclared variable

export DOTFILES_ROOT="${HOME}/.dotfiles"
[ ! -e ${DOTFILES_ROOT} ] && git clone https://github.com/fjchen7/dotfiles ${DOTFILES_ROOT}

source ${DOTFILES_ROOT}/common/helper.sh

setup_local_zshrc() {
    local DOTFILES_ZSH_ROOT=${DOTFILES_ROOT}/zsh
    if [[ ! -e ${DOTFILES_ZSH_ROOT}/zshrc.local.symlink ]]; then
        info 'setup zshrc.local'
        cp ${DOTFILES_ZSH_ROOT}/zshrc.local.symlink.example ${DOTFILES_ZSH_ROOT}/zshrc.local.symlink
        success 'zshrc.local'
    fi
}

setup_local_gitconfig() {
    local DOTFILES_GIT_ROOT=${DOTFILES_ROOT}/git
    if [[ ! -e ${DOTFILES_GIT_ROOT}/gitconfig.local.symlink ]]; then
        info 'setup gitconfig.local'

        ask ' - What is your github author name?'
        read -e git_authorname
        ask ' - What is your github author email?'
        read -e git_authoremail

        sed -e "s/AUTHORNAME/${git_authorname}/g" -e "s/AUTHOREMAIL/${git_authoremail}/g" \
            ${DOTFILES_GIT_ROOT}/gitconfig.local.symlink.example > ${DOTFILES_GIT_ROOT}/gitconfig.local.symlink

        success 'gitconfig.local'
    fi
}

link_file() {
    local src=$1 dst=$2

    local overwrite= backup= skip=
    local action=

    # -f file, -d directory, -L symlink
    if [[ -f "$dst" ]] || [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
        if [[ "$overwrite_all" == "false" ]] && [[ "$backup_all" == "false" ]] && [[ "$skip_all" == "false" ]]; then
            local currentSrc="$(readlink $dst)"

            if [[ "$currentSrc" == "$src" ]]; then
                skip=true;
            else
                ask "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
                [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"

                read -n 1 action
                case "$action" in
                    o )
                        overwrite=true;;
                    O )
                        overwrite_all=true;;
                    b )
                        backup=true;;
                    B )
                        backup_all=true;;
                    s )
                        skip=true;;
                    S )
                        skip_all=true;;
                    * )
                        ;;
                esac
            fi
        fi

        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}

        if [[ "$overwrite" == "true" ]]; then
            rm -rf "$dst"
            success "removed $dst"
        fi

        if [[ "$backup" == "true" ]]; then
            mv "$dst" "${dst}.backup"
            success "moved $dst to ${dst}.backup"
        fi
    fi

    if [[ "$skip" == "true" ]]; then
        success "skipped $src"
    else  # $skip == "false" or empty
        ln -s "$1" "$2"
        success "linked $1 to $2"
    fi
}

install_dotfiles() {
    info 'installing dotfiles'

    local overwrite_all=false backup_all=false skip_all=false
    for src in $(find "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink'); do
        dst="$HOME/.$(basename "${src%.*}")"
        link_file "$src" "$dst"
    done
}

setup_local_zshrc
setup_local_gitconfig
install_dotfiles

# pre install
[ -z "$(which python3)" ] && sudo apt-get -y install python3.8
[ -z "$(which pip3)" ] && sudo apt-get -y install python3-pip
# find and run all dotfiles installers iteratively
find ${DOTFILES_ROOT} -mindepth 2 -maxdepth 2 -name install.sh -exec readlink {} \; | while read installer ; do sh -c "${installer}" ; done
