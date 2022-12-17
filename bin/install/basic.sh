#!/bin/bash

basic() {
    if [ "$OS" == "Darwin" ]; then
        basic_macos
    elif [ "$OS" == "Linux" ]; then
        echo "Linux not implemented yet"
        exit 1
    fi

    echo "Setting up symlinks..."
    sym_link "$HOME/.gitconfig" "$DOTFILES_DIR/.config/git/.gitconfig"
    sym_link "$HOME/.tmux.conf" "$DOTFILES_DIR/.config/tmux/.tmux.conf"
    sym_link "$HOME/.vimrc" "$DOTFILES_DIR/.config/vim/.vimrc"
}
