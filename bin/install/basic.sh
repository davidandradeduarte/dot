#!/bin/bash

basic() {
    echo "Setting up basic environment..."

    if [ "$OS" == "Darwin" ]; then
        basic_macos
    elif [ "$OS" == "Linux" ]; then
        echo "Linux not supported yet."
    fi

    echo "Setting up symlinks..."
    sym_link "$HOME/.bash_profile" "$dir/.config/bash/.bash_profile"
    sym_link "$HOME/.bashrc" "$dir/.config/bash/.bashrc"
    sym_link "$HOME/.gitconfig" "$dir/.config/git/.gitconfig"
    sym_link "$HOME/.tmux.conf" "$dir/.config/tmux/.tmux.conf"
    sym_link "$HOME/.vimrc" "$dir/.config/vim/.vimrc"
}
