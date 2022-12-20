#!/bin/bash

# full_ubuntu runs the full installation script for Ubuntu.
full_ubuntu() {
    set_error_trap
    echo_inf "Setting up full Ubuntu environment..."

    basic_ubuntu "no_echo"

    packages=(zsh)
    install_apt_packages "${packages[@]}"

    # Custom installers
    install_chrome_ubuntu
    install_vscode_ubuntu
    install_lazygit_ubuntu
    install_golang_ubuntu
    install_fish_ubuntu
}
