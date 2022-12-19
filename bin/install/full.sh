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
            echor "Error: Unsupported Linux distribution."
            exitc 1
        fi
    fi

    sym_link "$HOME/.bin" "$dir/.bin"
}
