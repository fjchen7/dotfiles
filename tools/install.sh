#!/usr/bin/env bash

INSTALLERS=($(find ${DOTFILES_ROOT}/tools/installers -type f -name "*"))
FLAG=
case "$OSTYPE" in
    darwin* )
        FLAG="#darwin"
        ;;
    linux* )
        FLAG="#linux"
        ;;
    * )
        ;;
esac
# exit with error when platform is not macOS or Ubuntu
[ -z ${FLAG} ] && source ${DOTFILES_ROOT}/bin/_msg && _print_fail "Platform should be macOS or Ubuntu"

for file in "${INSTALLERS[@]}"; do
    cmd=$(grep -A1 "#cmd" ${file} | tail -n -1)
    # if command is existent, then no need to install and step into the next
    # note: if cmd is empty, it will go on to install
    [ ! -z "$(command -v $cmd)" ] && continue

    start_line_number=$(grep -n "${FLAG}" ${file} | cut -f1 -d:)  # line number of FLAG like #darwin or #linux
    if [[ ! -z ${start_line_number} ]]; then
        # start to execute command from FLAG like #darwin or #linux, and break when meeting empty line.
        # awk "NR > X && NR < Y file" ${file} is to retrieve lines between X and Y
        awk "NR > ${start_line_number}" ${file} | while read -r line; do if [[ ! -z ${line} ]]; then sh -c "${line}"; else break; fi; done
    fi
done
