#!/bin/bash

full() {
    if [ "$OS" == "Darwin" ]; then
        basic_macos
    elif [ "$OS" == "Linux" ]; then
        if [[ "$DISTRO" == *"fedora"* ]]; then
            basic_fedora
        elif [[ "$DISTRO" == *"ubuntu"* ]]; then
            basic_ubuntu
        else
            echo "Unsupported Linux distribution."
            exit 1
        fi
    fi

    sym_link "$HOME/.bin" "$dir/.bin"
}
