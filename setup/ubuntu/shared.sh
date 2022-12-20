#!/bin/bash

# shared_ubuntu runs the shared installation script for Ubuntu.
shared_ubuntu() {
    set_error_trap
    echo_inf "Setting up shared configuration for Ubuntu environment..."

    echo_inf "Updating packages..."
    sudo apt update &&
        sudo apt upgrade -y &&
        sudo apt autoremove -y

    setup_ubuntu_os_settings
}
