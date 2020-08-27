
# If we're on a Mac
if [[ "$(uname -s)" == "Darwin" ]]; then
    export PATH=${DOTFILES_ROOT}/macos/bin:$PATH
fi
