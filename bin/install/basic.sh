#!/bin/bash

basic() {
    if [ "$OS" == "Darwin" ]; then
        basic_macos
    elif [ "$OS" == "Linux" ]; then
        basic_ubuntu
    fi

    # Custom installers
    install_fzf

    # Setup configuration
    setup_fzf
    setup_vim
}
