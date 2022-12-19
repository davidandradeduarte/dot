#!/bin/bash

# full runs the full installation script for the current OS
full() {
    set_error_trap
    if [ "$OS" == "Darwin" ]; then
        shared_macos
        full_macos
    elif [ "$OS" == "Linux" ]; then
        if [[ "$DISTRO" == *"fedora"* ]]; then
            shared_fedora
            full_fedora
        elif [[ "$DISTRO" == *"ubuntu"* ]]; then
            shared_ubuntu
            full_ubuntu
        else
            echo_err"Unsupported Linux distribution."
            exitc 1
        fi
    fi

    shared_full
}

# shared_full runs the shared installation script for all OSes.
shared_full() {
    set_error_trap

    # Symbolic links
    sym_link "$HOME/.bin" "$dir/bin"

    # Shells
    setup_bash
    setup_zsh

    # Other
    setup_fzf
    setup_vim
    setup_tmux
    setup_git
}
