# If we're on a Mac
if [[ "$(uname -s)" == "Darwin" ]]; then
    [ -z "$(which realpath)" ] && brew install coreutils
fi
