#!/bin/bash

# Arguments
dir=${1:-$dir}
no_confirm=${2:-$no_confirm}

# Editable settings
DOTFILES_REMOTE_HTTPS="https://github.com/davidandradeduarte/dot.git"
DOTFILES_REMOTE_SSH="git@github.com:davidandradeduarte/dot.git"

# Constants
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NO_COLOR='\033[0m'

# echo_inf [-n] <message>
# Prints an info message to stdout.
echo_inf() {
    if [ "$1" == "-n" ]; then
        echo -n -e "${GREEN}Info: ${NO_COLOR}$2"
    else
        echo -e "${GREEN}Info: ${NO_COLOR}$1"
    fi
}

# echo_warn [-n] <message>
# Prints a warning message to stdout.
echo_warn() {
    if [ "$1" == "-n" ]; then
        echo -n -e "${YELLOW}Warning: ${NO_COLOR}$2"
    else
        echo -e "${YELLOW}Warning: ${NO_COLOR}$1"
    fi
}

# echo_err [-n] <message>
# Prints an error message to stdout.
echo_err() {
    if [ "$1" == "-n" ]; then
        echo -n -e "${RED}Error: ${NO_COLOR}$2"
    else
        echo -e "${RED}Error: ${NO_COLOR}$1"
    fi
}

# uninstall removes any symlink to $dir and deletes $dir.
uninstall() {
    echo_inf "Deleting symbolic links..."
    find $HOME -type l -lname "*$dir*" -delete -print
    echo_inf "Deleting directory ${GREEN}$dir${NO_COLOR}..."
    rm -rf $dir
}

# main is the entry point of the uninstall script.
main() {
    if [ -z "$dir" ]; then
        echo_err "No directory specified."
        exit 1
    fi

    if [ ! -d "$dir" ]; then
        echo_err "Directory does not exist: ${RED}$dir${NO_COLOR}"
        exit 1
    fi

    if [ ! -d "$dir/.git" ]; then
        echo_err "Directory is not a git repository: ${RED}$dir${NO_COLOR}"
        exit 1
    fi

    remote=$(git -C "$dir" remote get-url origin)
    if [[ $remote != $DOTFILES_REMOTE_HTTPS ]] && [[ $remote != $DOTFILES_REMOTE_SSH ]]; then
        echo_err "Directory is not a dotfiles repository: ${RED}$dir${NO_COLOR}"
        exit 1
    fi

    if [ "$no_confirm" == "true" ]; then
        uninstall
    else
        echo_warn "This will delete all symbolic links in ${YELLOW}$HOME${NO_COLOR} that point to ${YELLOW}$dir${NO_COLOR} \
and delete ${YELLOW}$dir${NO_COLOR} afterwards.
It will not uninstall any packages, applications or OS settings that may have been added."
        read -p "Continue? [y/N] " answer
        if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
            uninstall
        else
            echo_inf "Aborting..."
            exit 0
        fi
    fi

    echo_inf "Done! :)"
    exit 0
}

main "$@"
