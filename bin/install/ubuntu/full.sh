#!/bin/bash

# full_ubuntu runs the full installation script for Ubuntu.
full_ubuntu() {
    set_error_trap
    echo_inf "Setting up full Ubuntu environment..."

    echo_inf "Updating packages..."
    sudo apt update &&
        sudo apt upgrade -y &&
        sudo apt autoremove -y

    packages=(bash zsh git tmux vim)
    install_apt_packages "${packages[@]}"

    # Custom installers
    install_fzf
}
