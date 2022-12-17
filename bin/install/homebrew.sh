#!/bin/sh

install_homebrew() {
    if test ! $(which brew); then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Updating Homebrew..."
        brew update
    fi
}

install_brew_packages() {
    for package in "$@"; do
        echo "Installing $package..."
        if brew info "$package" | grep -q "Cask"; then
            brew install --cask "$package"
        else
            brew install "$package"
        fi
    done
}

tap_brew() {
    for tap in "$@"; do
        echo "Tapping $tap..."
        brew tap "$tap"
    done
}
