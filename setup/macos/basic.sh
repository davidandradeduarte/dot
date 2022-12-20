#!/bin/bash

# basic_macos runs the basic installation script for macOS.
basic_macos() {
    set_error_trap
    if [[ "$1" != "no_echo" ]]; then
        echo_inf "Setting up basic macOS environment..."
    fi

    taps=()
    tap_brew "${taps[@]}"

    packages=(wget bash git tmux vim fzf)
    install_brew_packages "${packages[@]}"
}
