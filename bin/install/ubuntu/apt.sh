#!/bin/bash

install_apt_packages() {
    packages=("$@")
    for package in "${packages[@]}"; do
        if ! dpkg -s "$package" >/dev/null 2>&1; then
            echo "Installing $package..."
            sudo apt install -y "$package"
        fi
    done
}
