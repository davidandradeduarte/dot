#!/bin/bash

# Arguments
type=${type:-full}
dir=${dir:-"$HOME/.dotfiles"}
local=${local:-false}

# Editable settings
DOTFILES_REMOTE_HTTPS="https://github.com/davidandradeduarte/dot.git"
DOTFILES_REMOTE_SSH="git@github.com:davidandradeduarte/dot.git"

# Constants
OS=$(uname -s)
GREEN='\033[0;32m'
RED='\033[0;31m'
NO_COLOR='\033[0m'

echo() {
    if [ "$1" == "-n" ]; then
        command echo -n -e "${GREEN}$2${NO_COLOR}"
    else
        command echo -e "${GREEN}$1${NO_COLOR}"
    fi
}

echor() {
    command echo -e "${RED}$1${NO_COLOR}"
}

backup_dir() {
    if [ -d "$1" ]; then
        echo "Backing up $1..."
        mv "$1" "$1.bak"
    fi
}

clone() {
    if [ -d "$dir" ]; then
        remote=$(git -C "$dir" remote get-url origin 2>/dev/null)
        if [[ $remote == $DOTFILES_REMOTE_HTTPS ]] || [[ $remote == $DOTFILES_REMOTE_SSH ]]; then
            echo "Updating dotfiles..."
            git -C "$dir" pull
        else
            echo -n "$dir already exists. Overwrite it? (y/n) "
            read -r answer
            if [ "$answer" == "y" ]; then
                echo "Backing up old dotfiles..."
                mv "$dir" "$HOME/.dotfiles.bak"
                echo "Deleting folder..."
                rm -rf "$dir"
                echo "Cloning dotfiles..."
                git clone $DOTFILES_REMOTE_HTTPS "$dir"
            fi
        fi
    else
        echo "Cloning dotfiles..."
        git clone $DOTFILES_REMOTE_HTTPS "$dir"
    fi
}

main() {
    if [ "$local" != "true" ]; then
        clone
    fi

    for file in $(find "$dir/bin/install" -name "*.sh"); do
        . "$file"
    done

    for file in $(find "$dir/.config" -name "setup.sh"); do
        . "$file"
    done

    for file in $(find "$dir/.config" -name "install.sh"); do
        . "$file"
    done

    if [ "$type" == "basic" ]; then
        basic
    elif [ "$type" == "full" ]; then
        full
    else
        echor "Invalid argument $type. Valid arguments are: basic, full"
        exit 1
    fi

    echo "Done! :)"
    exit 0
}

main "$@"
