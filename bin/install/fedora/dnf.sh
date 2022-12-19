#!/bin/bash

install_dnf_packages() {
    packages=("$@")
    for package in "${packages[@]}"; do
        echo "Installing $package..."
        sudo dnf install -y "$package"
    done
}
