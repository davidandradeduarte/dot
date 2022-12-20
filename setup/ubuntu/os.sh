#!/bin/bash

# setup_ubuntu_os_settings sets up OS settings for Ubuntu.
setup_ubuntu_os_settings() {
    set_error_trap
    echo_inf "Setting up Ubuntu OS settings..."

    sudo apt install -y software-properties-common
}
