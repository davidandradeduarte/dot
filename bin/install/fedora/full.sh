#!/bin/bash

# full_fedora runs the full installation script for Fedora.
full_fedora() {
    set_error_trap
    echo_inf "Setting up full Fedora environment..."

    basic_fedora "no_echo"

    packages=(zsh)
    install_dnf_packages "${packages[@]}"

    if [ -n "$DESKTOP_SESSION" ]; then
        sudo dnf install -y fedora-workstation-repositories
        sudo dnf config-manager --set-enabled google-chrome
        packages=(google-chrome-stable)
        install_dnf_packages "${packages[@]}"
    fi
}
