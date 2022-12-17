#!/bin/bash

DOTFILES_REMOTE_HTTPS="https://github.com/davidandradeduarte/dot.git"
DOTFILES_REMOTE_SSH="git@github.com:davidandradeduarte/dot.git"
DOTFILES_DIR="$HOME/.dotfiles"

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

clone() {
    if [ -d "$DOTFILES_DIR" ]; then
        remote=$(git -C "$DOTFILES_DIR" remote get-url origin 2>/dev/null)
        if [[ $remote == $DOTFILES_REMOTE_HTTPS ]] || [[ $remote == $DOTFILES_REMOTE_SSH ]]; then
            echo "Updating dotfiles..."
            git -C "$DOTFILES_DIR" pull
        else
            echo -n "$DOTFILES_DIR already exists. Overwrite it? (y/n) "
            read -r answer
            if [ "$answer" == "y" ]; then
                echo "Backing up old dotfiles..."
                mv "$DOTFILES_DIR" "$HOME/.dotfiles.bak"
                echo "Deleting folder..."
                rm -rf "$DOTFILES_DIR"
                echo "Cloning dotfiles..."
                git clone $DOTFILES_REMOTE_HTTPS "$DOTFILES_DIR"
            fi
        fi
    else
        echo "Cloning dotfiles..."
        git clone $DOTFILES_REMOTE_HTTPS "$DOTFILES_DIR"
    fi
}

main() {
    clone

    for file in $(find "$DOTFILES_DIR/bin/install" -name "*.sh"); do
        . "$file"
    done

    if [ "$1" == "basic" ]; then
        basic
    elif [ "$1" == "full" ]; then
        full
    else
        echor "Invalid argument. Use 'basic' or 'full'.\nUsage: $0 [basic|full]"
        exit 1
    fi

    echo "Done! :)"
    exit 0
}

main "$@"
