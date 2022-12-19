#!/bin/bash

basic() {
    if [ "$OS" == "Darwin" ]; then
        basic_macos
    elif [ "$OS" == "Linux" ]; then
        basic_ubuntu
    fi

    # Setup configuration
    setup_bash
    setup_fzf
    setup_vim
    setup_tmux
    setup_git
}
