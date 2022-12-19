#!/bin/bash

# install_apt_packages <package>...
# Installs the given packages using apt.
install_apt_packages() {
    set_error_trap
    packages=("$@")
    for package in "${packages[@]}"; do
        if ! dpkg -s "$package" >/dev/null 2>&1; then
            echo_inf "Installing ${GREEN}$package${NO_COLOR}..."
            sudo apt install -y "$package"
        fi
    done
}
