#!/bin/bash

full() {
    echo "Setting up full environment..."

    if [ "$OS" == "Darwin" ]; then
        full_macos
    elif [ "$OS" == "Linux" ]; then
        echo "Linux not supported yet."
    fi

    echo "Setting up symlinks..."
    # TODO
    sym_link "$HOME/.bin" "$dir/.bin"
    # sym_link "$HOME/.bash_profile" "$dir/.config/bash/.bash_profile"
    # sym_link "$HOME/.bashrc" "$dir/.config/bash/.bashrc"
    # sym_link "$HOME/.gitconfig" "$dir/.config/git/.gitconfig"
    # sym_link "$HOME/.tmux.conf" "$dir/.config/tmux/.tmux.conf"
    # sym_link "$HOME/.vimrc" "$dir/.config/vim/.vimrc"
    # sym_link "$HOME/.zshrc" "$dir/.config/zsh/.zshrc"
    # sym_link "$HOME/.config/fish/config.fish" "$dir/.config/fish/config.fish"
    # sym_link "$HOME/.config/nu/config.toml" "$dir/.config/nu/config.toml"
    # sym_link "$HOME/.config/starship.toml" "$dir/.config/starship.toml"
    # sym_link "$HOME/.config/omf" "$dir/.config/omf"
}
