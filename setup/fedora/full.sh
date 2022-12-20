#!/bin/bash

# full_fedora runs the full installation script for Fedora.
full_fedora() {
    set_error_trap
    echo_inf "Setting up full Fedora environment..."

    basic_fedora "no_echo"

    packages=(zsh golang fish)
    install_dnf_packages "${packages[@]}"

    # Custom installers
    install_chrome_fedora
    install_vscode_fedora
    install_lazygit_fedora
}
