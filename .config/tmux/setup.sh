#!/bin/bash

setup_tmux() {
    echo "Setting up tmux..."

    create_dir "$HOME/.config/tmux"

    sym_link "$HOME/.tmux.conf" "$dir/.config/tmux/.tmux.conf"
}
