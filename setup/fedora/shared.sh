#!/bin/bash

# shared_fedora runs the shared installation script for Fedora.
shared_fedora() {
    set_error_trap
    echo_inf "Setting up shared configuration for Fedora environment..."

    echo_inf "Updating packages..."
    sudo dnf update -y &&
        sudo dnf upgrade -y &&
        sudo dnf autoremove -y

    setup_fedora_os_settings
}
