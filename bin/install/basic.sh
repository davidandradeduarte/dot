#!/bin/bash

# basic runs the basic installation script for the current OS
# and all the shared OS setup scripts.
basic() {
    set_error_trap
    if [ "$OS" == "Darwin" ]; then
        basic_macos
    elif [ "$OS" == "Linux" ]; then
        if [[ "$DISTRO" == *"fedora"* ]]; then
            basic_fedora
        elif [[ "$DISTRO" == *"ubuntu"* ]]; then
            basic_ubuntu
        else
            echo_err"Unsupported Linux distribution."
            exitc 1
        fi
    fi

    shared_basic
}

# shared_basic runs the shared installation script for all OSes.
shared_basic() {
    set_error_trap

    # Shells
    setup_bash

    # Other
    setup_fzf
    setup_vim
    setup_tmux
    setup_git
}
