#!/bin/sh

basic_macos() {
    install_homebrew

    taps=()
    tap_brew "${taps[@]}"

    packages=(git tmux vim)
    install_brew_packages "${packages[@]}"
}
