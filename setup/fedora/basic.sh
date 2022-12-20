#!/bin/bash

# basic_fedora runs the basic installation script for Fedora.
basic_fedora() {
    set_error_trap
    if [[ "$1" != "no_echo" ]]; then
        echo_inf "Setting up basic Fedora environment..."
    fi

    packages=(wget bash git tmux vim)
    install_dnf_packages "${packages[@]}"

    # Custom installers
    install_fzf
}
