#!/bin/bash

full() {
    if [ "$OS" == "Darwin" ]; then
        full_macos
    elif [ "$OS" == "Linux" ]; then
        echo "Linux not implemented yet"
    fi

    echo "Setting up symlinks..."
    # TODO
    sym_link "$HOME/.bin" "$DOTFILES_DIR/.bin"
    # sym_link "$HOME/.gitconfig" "$DOTFILES_DIR/.config/git/.gitconfig"
    # sym_link "$HOME/.tmux.conf" "$DOTFILES_DIR/.config/tmux/.tmux.conf"
    # sym_link "$HOME/.vimrc" "$DOTFILES_DIR/.config/vim/.vimrc"
    # sym_link "$HOME/.zshrc" "$DOTFILES_DIR/.config/zsh/.zshrc"
    # sym_link "$HOME/.config/fish/config.fish" "$DOTFILES_DIR/.config/fish/config.fish"
    # sym_link "$HOME/.config/nu/config.toml" "$DOTFILES_DIR/.config/nu/config.toml"
    # sym_link "$HOME/.config/starship.toml" "$DOTFILES_DIR/.config/starship.toml"
    # sym_link "$HOME/.config/omf" "$DOTFILES_DIR/.config/omf"
}
