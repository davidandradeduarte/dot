#!/bin/bash

# shared_fedora runs the shared installation script for Fedora.
shared_fedora() {
    set_error_trap
    echo_inf "Setting up shared configuration for Fedora environment..."

    setup_fedora_os_settings
}
