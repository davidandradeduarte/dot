#!/bin/bash

basic_macos() {
    echo "Setting up basic macOS environment..."

    install_homebrew

    taps=()
    tap_brew "${taps[@]}"

    packages=(bash git tmux vim fzf)
    install_brew_packages "${packages[@]}"
}
