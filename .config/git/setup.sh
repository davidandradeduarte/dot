#!/bin/bash

setup_git() {
    echo "Setting up git..."

    sym_link "$HOME/.gitconfig" "$dir/.config/git/.gitconfig"
}
