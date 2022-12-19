#!/bin/bash

# basic_macos runs the basic installation script for macOS.
basic_macos() {
    set_error_trap
    echo_inf "Setting up basic macOS environment..."

    # Package managers
    install_homebrew

    # Taps
    taps=()
    tap_brew "${taps[@]}"

    # Packages
    packages=(bash git tmux vim fzf)
    install_brew_packages "${packages[@]}"
}
