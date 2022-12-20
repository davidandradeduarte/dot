#!/bin/bash

# basic_ubuntu runs the basic installation script for Ubuntu.
basic_ubuntu() {
    set_error_trap
    if [[ "$1" != "no_echo" ]]; then
        echo_inf "Setting up basic Ubuntu environment..."
    fi

    packages=(wget bash git tmux vim)
    install_apt_packages "${packages[@]}"

    # Custom installers
    install_fzf
}
