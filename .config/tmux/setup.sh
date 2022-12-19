#!/bin/bash

setup_tmux() {
    set_error_trap
    echo_inf "Setting up tmux..."

    create_dir "$HOME/.config/tmux"

    sym_link "$HOME/.tmux.conf" "$dir/.config/tmux/.tmux.conf"
}
