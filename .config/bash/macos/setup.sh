#!/bin/bash

setup_macos_bash() {
    echo "Setting up bash..."

    sym_link "$HOME/.bashrc" "$dir/.config/bash/macos/.bashrc"
}
