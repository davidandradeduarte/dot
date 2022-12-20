#!/bin/bash

# install_homebrew installs Homebrew if it is not installed.
install_homebrew() {
    set_error_trap
    if test ! $(which brew); then
        echo_inf "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo_inf "Updating Homebrew..."
        brew update
    fi
}

# install_brew_packages <package>...
# Installs the given packages using Homebrew.
install_brew_packages() {
    set_error_trap
    for package in "$@"; do
        echo_inf "Installing ${GREEN}$package${NO_COLOR}..."
        if brew info "$package" | grep -q "Cask"; then
            brew install --cask "$package"
        else
            brew install "$package"
        fi
    done
}

# tap_brew <tap>...
# Taps the given Homebrew repositories.
tap_brew() {
    set_error_trap
    for tap in "$@"; do
        echo_inf "Tapping ${GREEN}$tap${NO_COLOR}..."
        brew tap "$tap"
    done
}
