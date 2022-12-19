#!/bin/bash

# basic_fedora runs the basic installation script for Fedora.
basic_fedora() {
    set_error_trap
    echo_inf "Setting up basic Fedora environment..."

    echo_inf "Updating packages..."
    sudo dnf check-update &&
        sudo dnf upgrade -y &&
        sudo dnf autoremove -y

    setup_fedora_os_settings

    packages=(bash git tmux vim)
    install_dnf_packages "${packages[@]}"
    if [ -n "$DESKTOP_SESSION" ]; then
        sudo dnf install -y fedora-workstation-repositories
        sudo dnf config-manager --set-enabled google-chrome
        packages=(google-chrome-stable)
        install_dnf_packages "${packages[@]}"
    fi

    # Custom installers
    install_fzf
}
