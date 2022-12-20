#!/bin/bash

# install_dnf_packages <package>...
# Installs the given packages using dnf.
install_dnf_packages() {
    set_error_trap
    packages=("$@")
    for package in "${packages[@]}"; do
        echo_inf "Installing ${GREEN}$package${NO_COLOR}..."
        sudo dnf install -y "$package"
    done
}
