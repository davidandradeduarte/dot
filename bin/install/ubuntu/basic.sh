#!/bin/bash

# basic_ubuntu runs the basic installation script for Ubuntu.
basic_ubuntu() {
    set_error_trap
    echo_inf "Setting up basic Ubuntu environment..."

    echo_inf "Updating packages..."
    sudo apt update &&
        sudo apt upgrade -y &&
        sudo apt autoremove -y

    packages=(bash git tmux vim)
    install_apt_packages "${packages[@]}"

    # Custom installers
    install_fzf
}
