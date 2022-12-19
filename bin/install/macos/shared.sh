#!/bin/bash

# shared_macos runs the shared installation script for macOS.
shared_macos() {
    set_error_trap
    echo_inf "Setting up shared configuration for macOS environment..."

    install_homebrew

    setup_macos_os_settings
}
