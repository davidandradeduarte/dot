#!/bin/bash

basic_ubuntu() {
    echo "Setting up basic Ubuntu environment..."

    echo "Updating packages..."
    sudo apt update &&
        sudo apt upgrade -y &&
        sudo apt autoremove -y

    packages=(bash git tmux vim)
    install_apt_packages "${packages[@]}"

    # Setup OS specific shells (before everything else)
    setup_ubuntu_bash

    # Custom installers
    install_fzf
}
