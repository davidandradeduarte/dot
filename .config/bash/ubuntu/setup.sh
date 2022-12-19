#!/bin/bash

setup_ubuntu_bash() {
    echo "Setting up bash..."

    sym_link "$HOME/.bashrc" "$dir/.config/bash/ubuntu/.bashrc"
}
