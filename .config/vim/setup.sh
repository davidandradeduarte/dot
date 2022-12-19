#!/bin/bash

setup_vim() {
    echo "Setting up vim..."

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    sym_link "$HOME/.vimrc" "$dir/.config/vim/.vimrc"

    vim +'PlugInstall --sync' +qa
}
