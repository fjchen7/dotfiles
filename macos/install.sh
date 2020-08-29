# If we're on a Mac
if [[ "$(uname -s)" == "Darwin" ]]; then
    [ -z "$(command -v realpath)" ] && brew install coreutils
fi
