#!/bin/bash

basic_fedora() {
    echo "Setting up basic Fedora environment..."

    echo "Updating packages..."
    sudo dnf check-update &&
        sudo dnf upgrade -y &&
        sudo dnf autoremove -y

    packages=(bash git tmux vim)
    install_dnf_packages "${packages[@]}"

    # Custom installers
    install_fzf
}
