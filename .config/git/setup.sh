#!/bin/bash

setup_git() {
    set_error_trap
    echo_inf "Setting up git..."

    sym_link "$HOME/.gitconfig" "$dir/.config/git/.gitconfig"
}
