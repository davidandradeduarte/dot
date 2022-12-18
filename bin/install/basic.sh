#!/bin/bash

basic() {
    echo "Setting up basic environment..."

    if [ "$OS" == "Darwin" ]; then
        basic_macos
    elif [ "$OS" == "Linux" ]; then
        echo "Linux not supported yet."
    fi

    echo "Setting up symlinks..."
    sym_link "$HOME/.gitconfig" "$DOTFILES_DIR/.config/git/.gitconfig"
    sym_link "$HOME/.tmux.conf" "$DOTFILES_DIR/.config/tmux/.tmux.conf"
    sym_link "$HOME/.vimrc" "$DOTFILES_DIR/.config/vim/.vimrc"
}
