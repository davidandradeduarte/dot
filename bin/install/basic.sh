#!/bin/bash

basic() {
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

    # Setup configuration
    setup_bash
    setup_fzf
    setup_vim
    setup_tmux
    setup_git
}
