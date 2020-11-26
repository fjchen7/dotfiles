#!/usr/bin/env bash

#set -e    # exit script when error happens
#set -u    # report error if visiting undeclared variable

setup() {
    export DOTFILES_ROOT="${HOME}/.dotfiles"
    [ ! -e ${DOTFILES_ROOT} ] && git clone https://github.com/fjchen7/dotfiles ${DOTFILES_ROOT}
    source ${DOTFILES_ROOT}/bin/_msg    # print helper functions
    [ ! -e "${HOME}/.local" ] && mkdir -p "${HOME}/.local"
}

setup_local_zshrc() {
    local DOTFILES_ZSH_ROOT=${DOTFILES_ROOT}/zsh
    if [[ ! -e ${DOTFILES_ZSH_ROOT}/zshrc.local.symlink ]]; then
        _print_info 'setup zshrc.local'
        cp ${DOTFILES_ZSH_ROOT}/zshrc.local.symlink.example ${DOTFILES_ZSH_ROOT}/zshrc.local.symlink
        _print_ok 'zshrc.local'
    fi
}

setup_local_gitconfig() {
    local DOTFILES_GIT_ROOT=${DOTFILES_ROOT}/git
    if [[ ! -e ${DOTFILES_GIT_ROOT}/gitconfig.local.symlink ]]; then
        _print_info 'setup gitconfig.local'

        _print_ask ' - What is your github author name?'
        read -e git_authorname
        _print_ask ' - What is your github author email?'
        read -e git_authoremail

        sed -e "s/AUTHORNAME/${git_authorname}/g" -e "s/AUTHOREMAIL/${git_authoremail}/g" \
            ${DOTFILES_GIT_ROOT}/gitconfig.local.symlink.example > ${DOTFILES_GIT_ROOT}/gitconfig.local.symlink

        _print_ok 'gitconfig.local'
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
                _print_ask "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
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
            _print_ok "removed $dst"
        fi

        if [[ "$backup" == "true" ]]; then
            mv "$dst" "${dst}.backup"
            _print_ok "moved $dst to ${dst}.backup"
        fi
    fi

    if [[ "$skip" == "true" ]]; then
        _print_ok "skipped ${src/${DOTFILES_ROOT}\//}"
    else  # $skip == "false" or empty
        ln -s "$1" "$2"
        _print_ok "linked $1 to $2"
    fi
}

install_dotfiles() {
    _print_info 'installing dotfiles'

    local overwrite_all=false backup_all=false skip_all=false
    for src in $(find "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink'); do
        dst="$HOME/.$(basename "${src%.*}")"
        link_file "$src" "$dst"
    done
}

install_tools() {
    _print_info "installing tools and dependencies"

    # pre install
    [ -z "$(command -v python3)" ] && sudo apt-get -y install python3.8
    [ -z "$(command -v pip3)" ] && sudo apt-get -y install python3-pip
    # find and run all dotfiles lines iteratively
    find ${DOTFILES_ROOT} -mindepth 2 -maxdepth 2 -type f -name install.sh | while read line; do sh -c "${line}"; _print_ok "installed: ${line/${DOTFILES_ROOT}\//}"; done
}

setup
setup_local_zshrc
setup_local_gitconfig
install_dotfiles
install_tools
